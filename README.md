# PostgreSQL Backup and Restore Utility

This Bash script provides an interactive menu with three commands and an option to exit. The commands demonstrate different functionalities related to PostgreSQL database management:

## Table of Contents
- [Features ✨](#features)
- [Usage](#usage)
- [Requirements](#requirements)
- [Error Handling](#error-handling)
- [License](#license)
- [Author](#author)

***
**
## Features

![Usage Example](img/1%20-%20MENU.png)

1. **Check PostgreSQL**: This option installs the necessary PostgreSQL client tools (based on the detected Linux distribution) and displays the versions of `psql` and `pg_dump`.

![Usage Example](img/3%20-%20OPC%201%20-%20CHECKS%20FOR%20POSTGRES%20INSTALLS.png)

2. **Backup DB**: This option prompts the user to enter the connection details for the PostgreSQL database they want to back up. It then creates a backup SQL file in the same directory as the script, using the current timestamp in the file name.

![Usage Example](img/4%20-%20OPC%202%20-%20OLD%20SERVER%20TO%20BACKUP.png)

3. **Restore DB**: This option prompts the user to enter the connection details for the PostgreSQL database they want to restore. It then lists the 2 most recent backup SQL files in the same directory as the script, and allows the user to select the file to restore.

![Usage Example](img/6%20-%20OPC%203%20-%20BACKUP%20TO%20RESTORE.png)

***

## Usage

1. Clone the repository or download the script file.
2. Make the script executable: `chmod +x bupres.sh`
3. Run the script: `./bupres.sh` or `bash bupres.sh`

***

## Requirements

- Bash shell
- PostgreSQL client tools (`psql`, `pg_dump`)
- Supported Linux distributions:
  - Debian-based (Ubuntu, Debian, etc.)
  - Red Hat-based (CentOS, RHEL, etc.)
  - Arch-based (Arch Linux, Manjaro, etc.)

***

## Error Handling

The script includes basic error handling for different scenarios:
- Asks for sudo local password in order to check installed versiones of psql and pg_dump, for example in debian based systems it will run (sudo apt-get install postgresql-client postgresql-client-common -y -qq 2>&1 > /dev/null) 

![Usage Example](img/2%20-%20OPC%201%20-%20ASK%20SUDO%20PWD.png)

- Any error that apear when traying to create a backup file.
![Usage Example](img/5%20-%20OPC%202%20-%20ERROR%20FOR%20BACKUP.png)

- Errors hwen there are no .sql files in the directory to restore.
![Usage Example](img/7%20-%20OPC%203%20-%20ERROR%20FOR%20RESTORE.png)

***

## License

This project is licensed under the [MIT License](LICENSE).

***

## Author

This script was created by JESUS VILLALOBOS.
