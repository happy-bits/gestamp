# Se när Demofilen + backupfilen senast uppdaterades

Öppna Powershell och gå in i mappen där MDF och LOG-filerna finns

    cd C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA

Kör följande (förutsätter backupfilen finns vid c:\TMP\demo.bak)

    clear; Get-ChildItem Demo*, C:\TMP\demo.bak| Select-Object Name, Length, LastAccessTime, LastWriteTime