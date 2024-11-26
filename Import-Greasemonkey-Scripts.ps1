# Paths
$oldDatabasePath = "A:\OldPath\61413404gyreekansoem.sqlite" # Path to old database
$newDatabasePath = "C:\NewPath\61413404gyreekansoem.sqlite" # Path to new database

# Shut down Firefox
Write-Host "Shutting down Firefox..."
Stop-Process -Name "firefox" -Force -ErrorAction SilentlyContinue

# Wait for Firefox to exit
Write-Host "Waiting for Firefox to shut down..."
while (Get-Process -Name "firefox" -ErrorAction SilentlyContinue) {
    Start-Sleep -Seconds 1
}
Write-Host "Firefox is completely shut down."

# Delete the current database
Write-Host "Deleting the current gyreekansoem.sqlite..."
Remove-Item -Path $newDatabasePath -Force

# Start Firefox
Write-Host "Starting Firefox..."
Start-Process -FilePath "firefox.exe"

# Wait for Firefox to start
Write-Host "Waiting for Firefox to start..."
while (-not (Get-Process -Name "firefox" -ErrorAction SilentlyContinue)) {
    Start-Sleep -Seconds 1
}

# Wait an additional 5 seconds after Firefox has started
Write-Host "Firefox is running. Waiting 5 more seconds..."
Start-Sleep -Seconds 5

# Shut down Firefox
Write-Host "Shutting down Firefox..."
Stop-Process -Name "firefox" -Force -ErrorAction SilentlyContinue

# Wait for Firefox to exit
Write-Host "Waiting for Firefox to shut down..."
while (Get-Process -Name "firefox" -ErrorAction SilentlyContinue) {
    Start-Sleep -Seconds 1
}
Write-Host "Firefox is completely shut down."

# Dump data from the old database
Write-Host "Dumping data from the old database..."
$sqliteDumpPath = "$env:TEMP\dump.sql"
& sqlite3.exe $oldDatabasePath ".dump" > $sqliteDumpPath

# Filter the dump file to include only the desired INSERT statements
Write-Host "Filtering the dump file..."
(Get-Content $sqliteDumpPath) -match "INSERT INTO (object_data|unique_index_data)" | Set-Content $sqliteDumpPath

# SQL commands to drop indexes and triggers
$sqlCommands = @"
DROP INDEX IF EXISTS index_data_value_locale_index;
DROP INDEX IF EXISTS unique_index_data_value_locale_index;
DROP TRIGGER IF EXISTS object_data_insert_trigger;
DROP TRIGGER IF EXISTS object_data_update_trigger;
DROP TRIGGER IF EXISTS object_data_delete_trigger;
DROP TRIGGER IF EXISTS file_update_trigger;
"@

# Execute the SQL commands using sqlite3.exe
Write-Host "Dropping indexes and triggers in the new database..."
$sqlCommands | & sqlite3.exe $newDatabasePath


# Import data into the new database
Write-Host "Importing data into the new database..."
Get-Content $sqliteDumpPath | & sqlite3.exe $newDatabasePath


# Start Firefox to verify the data is imported
Write-Host "Starting Firefox..."
Start-Process -FilePath "firefox.exe"

# Suggest a backup
Write-Host "Remember to back up the new database immediately and regularly!"

# Done
Write-Host "Script complete. Enjoy!"
