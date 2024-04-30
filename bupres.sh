#!/bin/bash

################################################################################
# Bash Script Information
# -----------------------
# Description: This Bash script provides an interactive menu with three
#              commands and an option to exit. The commands demonstrate
#              different functionalities, such as:
#              1. Checking the installed PostgreSQL client tools
#              2. Backing up a PostgreSQL database to a .sql file
#              3. Restoring a PostgreSQL database from a backup .sql file
# Date:        January 15, 2024
# Creator:     JESUS VILLALOBOS
# Version:     1.0
# License:     MIT License
################################################################################

# Array to store the menu options
menu_options=(
    "Check postgreSQL"
    "Backup DB"
    "Restore DB"
    "Exit"
)

# Function to display the menu
display_menu() {
  clear
  # The max number og characters is 49 for the top line; please modify as you need just by adding this char ─
  echo "╭───────────────────────────────────────────────╮"
  max_length=0
  # Find the maximum length of menu options
  for option in "${menu_options[@]}"; do
    length=${#option}
    if (( length > max_length )); then
      max_length=$length
    fi
  done

  # Calculate the width of the menu option
  menu_width=$((max_length + 6)) # Add space for option number and padding

  for i in "${!menu_options[@]}"; do
    option="${menu_options[$i]}"
    # Construct the menu option with proper padding, by adding spaces after (($menu_width))s 
    printf "│ %-3s%-$(($menu_width))s                     │\n" "$((i+1))." "$option"
  done
  # The max number og characters is 49 for the bottom line; please modify as you need just by adding this char ─
  echo "╰───────────────────────────────────────────────╯"
}

# Function to execute (Check postgreSQL)
execute_command1() {
  # Detect the Linux distribution
  if [ -f /etc/debian_version ]; then
    # Debian-based distribution (Ubuntu, Debian, etc.)
    echo "Installing requirements for PostgreSQL on Debian-based (Ubuntu, Debian, etc.) ..."
    echo "sudo password maybe required"
    echo " "
    sudo apt-get install postgresql-client postgresql-client-common -y -qq 2>&1 > /dev/null
  elif [ -f /etc/redhat-release ]; then
    # Red Hat-based distribution (CentOS, RHEL, etc.)
    echo "Installing requirements for PostgreSQL on Red Hat-based system (CentOS, RHEL, etc.) ..."
    echo "sudo password maybe required"
    echo " "
    sudo yum install postgresql-client postgresql-client-common -y -q
  elif [ -f /etc/arch-release ]; then
    # Arch-based distribution (Arch Linux, Manjaro, etc.)
    echo "Installing requirements for PostgreSQL on Arch-based system (Arch Linux, Manjaro, etc.) ..."
    echo "sudo password maybe required"
    echo " "
    sudo pacman -S postgresql-client --noconfirm
  else
    echo "Unsupported Linux distribution. Please install the PostgreSQL client tools manually."
    return 1
  fi

  if [ $? -eq 0 ]; then
    echo "PostgreSQL client tools installed successfully."
    echo " "
    psql_version=$(psql --version)
    echo -e "\e[31m\e[1mpsql version\e[31m\e[0m: $psql_version"
    pg_dump_version=$(pg_dump --version)
    echo -e "\e[31m\e[1mpg_dump version\e[31m\e[0m: $pg_dump_version"
  else
    echo "Error installing PostgreSQL client tools."
  fi
}

# Function to execute (Backup DB)
execute_command2() {
  # Prompt the user for database connection details
  echo
  echo -e "Enter the \e[31mPostgreSQL OLD connection\e[0m details:"
  echo
  read -p "HOST: " PGHOST
  read -p "DATABASE: " PGDATABASE
  read -p "USER: " PGUSER
  read -p "FILENAME: " BACKUP_FILE_NAME

  # Get the directory of the running script
  SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
  # Prompt the user for the backup file name (without .sql extension)
  TIMESTAMP=$(date +"%Y%m%d_%H%M")
  BACKUP_FILE="$SCRIPT_DIR/${BACKUP_FILE_NAME}_${TIMESTAMP}.sql"

  # Create the backup
  echo
  echo -n -e "\e[32mCreating backup file...\e[0m"
  echo
  echo
  if pg_dump -h $PGHOST -d $PGDATABASE -U $PGUSER -p 5432 -f $BACKUP_FILE; then
      echo
      echo "Done."
      echo "Backup of DB was created: $BACKUP_FILE"
  else
      echo
      echo -e "\e[31mError creating the file for a Backup of the DB\e[0m"
  fi
}

# Function to execute (Restore DB)
execute_command3() {
    # Prompt the user for connection details
    echo -e "Enter the \e[32mPostgreSQL NEW connection\e[0m details:"
    echo
    read -p "NEW host name: " NEW_PGHOST
    read -p "NEW database name: " NEW_PGDATABASE
    read -p "NEW user name: " NEW_PGUSER

    # Set the directory where the backup SQL files are located
    BACKUP_DIR=$(pwd)

    # Get a list of the 2 most recent .sql files in the directory, along with their creation timestamps
    sql_files=($(find "$BACKUP_DIR" -maxdepth 1 -type f -name "*.sql" -printf "%T@ %f\n" | sort -nr | head -n 20 | awk '{print $2}'))
    timestamps=($(find "$BACKUP_DIR" -maxdepth 1 -type f -name "*.sql" -printf "%T@ %f\n" | sort -nr | head -n 20 | awk '{print $1}'))
    echo

    # Check if there are any SQL files in the directory
    if [ ${#sql_files[@]} -eq 0 ]; then
        echo -e "No SQL files found in the directory located at: \e[31m$BACKUP_DIR\e[0m"
        return
    fi

    # Display the list of files and prompt the user to select one
    echo "Select the SQL file to restore:"
    echo " "
    PS3="Enter the number of the file: "
    select file in "${sql_files[@]}"; do
        if [ -n "$file" ]; then
            # Convert the timestamp to a human-readable format
            # human_timestamp=$(date -d "@${timestamps[$REPLY-1]}" '+%Y-%m-%d %H:%M')
            BACKUP_FILE="$BACKUP_DIR/$file"
            echo

            # Display a "Restoring database..." message while the restore is in progress
            echo -n -e "Restoring database from file: \e[32m$file\e[0m"
            echo
            echo

            if psql -h $NEW_PGHOST -d $NEW_PGDATABASE -U $NEW_PGUSER -p 5432 -f $BACKUP_FILE; then
                echo
                echo "Done."
                echo
                echo -e "Backup restore successful: \e[93m$BACKUP_FILE\e[0m"
            else
                echo
                echo -e "Error restoring the backup file: \e[31m$BACKUP_FILE\e[0m"
            fi
            return
        else
            echo
            echo -e "\e[31mInvalid selection of a file to restore\e[0m"
            echo "Please try again"
            break
        fi
    done
}

# Function to start task
task_started() {
    # Displays a message indicating the start of the task
    echo ""
    echo -e "╭─────────────────────────────────────────────╮"
    echo -e "│ \e[93mTHE TASK HAS STARTED RUNNING\e[0m                │"
    echo -e "╰─────────────────────────────────────────────╯"
}

# Function to end task
task_ended() {
    # Displays a message indicating the end of the task
    echo ""
    echo -e "╭─────────────────────────────────────────────╮"
    echo -e "│ \e[32mTHE TASK HAS FINISHED RUNNING\e[0m               │"
    echo -e "╰─────────────────────────────────────────────╯"
}

# Main loop for the menu
while true; do
    # Calls the function to display the menu
    display_menu

    # Prompts the user to enter a choice (1-4)
    read -p "Enter your choice (1-4): " choice

    # Uses a case statement to execute the corresponding function based on the user's choice
    case $choice in
        1)
            # Calls functions to start, execute, and end the task for option 1
            task_started
            execute_command1
            task_ended
            ;;
        2)
            # Calls functions to start, execute, and end the task for option 2
            task_started
            execute_command2
            task_ended
            ;;
        3)
            # Calls functions to start, execute, and end the task for option 3
            task_started
            execute_command3
            task_ended
            ;;
        4)
            echo ""
            echo -e "\e[32mExiting the menu. Goodbye!\e[0m"
            echo ""
            exit 0
            ;;
        *)
            # Displays an error message for invalid choices
            echo ""
            echo -e "\e[31mInvalid choice [\e[1m$choice\e[0m\e[31m]\e[0m"
            echo -e "\e[31mPlease enter a number between 1 and 4.\e[0m"
            echo ""
            ;;
    esac

    # Displays a message and waits for the user to press Enter to continue
    echo -e -n "\e[1mPress Enter to continue...\e[0m"
    read -s -n 1 -p ""
done
