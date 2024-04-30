# PostgreSQL Backup and Restore Utility

This Bash script provides an interactive menu with three commands and an option to exit. The commands demonstrate different functionalities related to PostgreSQL database management:

![Usage Example](img/)
*Figure 1: Running the script and navigating through the menu options.*

1. **Check PostgreSQL**: This option installs the necessary PostgreSQL client tools (based on the detected Linux distribution) and displays the versions of `psql` and `pg_dump`.

2. **Backup DB**: This option prompts the user to enter the connection details for the PostgreSQL database they want to back up. It then creates a backup SQL file in the same directory as the script, using the current timestamp in the file name.

3. **Restore DB**: This option prompts the user to enter the connection details for the PostgreSQL database they want to restore. It then lists the 2 most recent backup SQL files in the same directory as the script, and allows the user to select the file to restore.

## Usage

1. Clone the repository or download the script file.
2. Make the script executable: `chmod +x bupres.sh`
3. Run the script: `./bupres.sh` or `bash bupres.sh`

The script will display an interactive menu with the available options. Follow the on-screen instructions to perform the desired actions.
img/1%20-%20MENU.png

![Usage Example]([img/1%20-%20MENU.png])
*Figure 1: Running the script and navigating through the menu options.*

## Requirements

- Bash shell
- PostgreSQL client tools (`psql`, `pg_dump`)
- Supported Linux distributions:
  - Debian-based (Ubuntu, Debian, etc.)
  - Red Hat-based (CentOS, RHEL, etc.)
  - Arch-based (Arch Linux, Manjaro, etc.)

## Error Handling

The script includes basic error handling for different scenarios:
- Unsupported Linux distribution detection.
- Error messages for failed installations of PostgreSQL client tools.
- Invalid selections in the menu options.
- Errors during the creation or restoration of database backups.

![Error Handling](images/error_handling.png)
*Figure 2: Example of error handling during script execution.*

## License

This project is licensed under the [MIT License](LICENSE).

## Author

This script was created by JESUS VILLALOBOS.
