# PostgreSQL Backup and Restore Utility

This Bash script (246 lines of code) serves as an interactive menu utility designed to manage PostgreSQL databases efficiently. It provides users with a menu interface offering three main functionalities.

## Description

- **Check postgreSQL**: This option allows users to check for and install PostgreSQL client tools based on their Linux distribution. It verifies the installation of essential tools such as `psql` and `pg_dump` and displays their versions.

- **Backup DB**: Users can create backups of PostgreSQL databases by providing connection details such as host, database name, and user credentials. The script generates a backup file with a timestamp in the filename for easy identification.

- **Restore DB**: This option facilitates the restoration of PostgreSQL databases from previously created backup files. Users select the backup file from a list of the 20 most recent files in the script's directory and provide connection details for the new PostgreSQL database.

It's a user-friendly menu layout and prompts for user input when necessary, this script simplifies routine tasks related to PostgreSQL database management, making it convenient and accessible for users of all experience levels.

***

## Table of Contents
- [Features ✨](#features)
- [Usage](#usage)
- [Requirements](#requirements)
- [Error Handling](#error-handling)
- [License](#license)
- [Fork Information](#fork-information)
- [Safety Disclaimer](#safety-disclaimer)
- [Author](#author)

***

## Features

![Usage Example](img/1%20-%20MENU.png)

1. **Check PostgreSQL**: This option installs the necessary PostgreSQL client tools (based on the detected Linux distribution) and displays the versions of `psql` and `pg_dump`.

![Usage Example](img/3%20-%20OPC%201%20-%20CHECKS%20FOR%20POSTGRES%20INSTALLS.png)

***

2. **Backup DB**: This option prompts the user to enter the connection details for the PostgreSQL database they want to back up. It then creates a backup SQL file in the same directory as the script, using the current timestamp in the file name.

![Usage Example](img/4%20-%20OPC%202%20-%20OLD%20SERVER%20TO%20BACKUP.png)

***

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

***

- Any error that apear when traying to create a backup file.
![Usage Example](img/5%20-%20OPC%202%20-%20ERROR%20FOR%20BACKUP.png)

***

- Errors hwen there are no .sql files in the directory to restore.
![Usage Example](img/7%20-%20OPC%203%20-%20ERROR%20FOR%20RESTORE.png)

***

## License

This project is licensed under the [MIT License](LICENSE).

***

## Fork Information

This repository is a modified fork of the [bashmenu](https://github.com/jveyes/bashmenu) repository by JESUS VILLALOBOS.

***

![Disclaimer](img/disclaimer.png)

## Safety Disclaimer

This Bash script is provided as-is, without any warranties or guarantees of any kind. While every effort has been made to ensure its reliability and security, it is important to note that:

- **No Information Collection**: This script does not collect any personal or sensitive information from users. All operations are performed locally on the user's machine.

- **No Malicious Code**: The script has been developed with transparency and security in mind. It does not contain any malicious code or hidden functionalities that could compromise the user's system.

- **User Responsibility**: Users are advised to review the script's code and verify its functionality before running it on their systems. It is recommended to run scripts obtained from the internet in a controlled environment to ensure safety.

- **Use at Your Own Risk**: The use of this script is entirely at the user's discretion. The author(s) and contributors cannot be held responsible for any damages or losses resulting from its use.

It is recommended to exercise caution and perform due diligence when using scripts obtained from external sources.

***

## Author

This script was created by JESUS VILLALOBOS.
