This PowerShell script copies your old Greasemonkey scripts to your new machine. It automates the process of transferring data from your old database to a new one, shutting down and restarting Firefox, dumping data, and ensuring proper database structure in the new database.

The Greasmonkey scripts are stored in a SQLite file called "61413404gyreekansoem.sqlite", which can be found in this path:

    • C:\Users\[USER]\AppData\Roaming\Mozilla\Firefox\Profiles\[PROFILE].default-release\storage\default\moz-extension+++[EXT-ID]\idb\

Features

    • Checks that the old database file exits before starting.
    • Shuts down Firefox to ensure no interference during the process.
    • Deletes the current database (61413404gyreekansoem.sqlite) from the new machine.
    • Dumps data from the old database and filters out the relevant INSERT statements for the new database.
    • Drops existing indexes and triggers from the new database before importing the data.
    • Imports the filtered data into the new database.
    • Restarts Firefox to verify that the new database is successfully imported.
    • Reminds user to create a backup of the new database after migration.

Requirements

    • SQLite: Ensure sqlite3.exe is available on your system. You can download it here for free: https://sqlite.org/download.html
    • Firefox: The script assumes Firefox is installed and running on the machine.
    • PowerShell: This script is written for PowerShell and will run on Windows.

Installation

    • Clone the repository to your local machine.
    • Ensure you have access to sqlite3.exe.
    • Ensure the paths to the old and new databases are correct.
    • Run the script from PowerShell.
    • Enjoy your old sccripts on your new machine!

Usage

    • $oldDatabasePath = "A:\OldPath\61413404gyreekansoem.sqlite"  # Path to old database
    • $newDatabasePath = "C:\NewPath\61413404gyreekansoem.sqlite"  # Path to new database

The script will automatically handle the following steps:

    1. Shutdown Firefox.
    2. Delete the new database.
    3. Dump and filter the old database's data.
    4. Drop old indexes and triggers in the new database.
    5. Import the filtered data into the new database.
    6. Restart Firefox.

Notes

    • The script waits for Firefox to shut down and start again, so please make sure Firefox is installed and running on your system.
    • The script assumes that both the old and new databases are SQLite databases with similar structures. (Firefox extensions)
    • Remember to back up the new database immediately after the migration is complete and regularly thereafter to avoid data loss.
    
Warning

    • This script assumes your new machine has no scripts on it, if it does they will be automatically deleted and there will be no way to recover them, use with care.

License

    • This project is licensed under the MIT License - see the LICENSE file for details.
    
