
# Create/delete DB with DBCA

template:
$ORACLE_HOME/assistants/dbca/dbca.rsp


dbca -silent -responseFile ./dbca.rsp


dbca -silent -deleteDatabase -sourceDB cdb2 -sysDBAUserName sys -sysDBAPassword OraPasswd1


dbca -silent -createDatabase \
 -templateName General_Purpose.dbc \
 -gdbname cdb3 -sid cdb3 -responseFile NO_VALUE \
 -characterSet AL32UTF8 \
 -sysPassword OraPasswd1 \
 -systemPassword OraPasswd1 \
 -createAsContainerDatabase true \
 -numberOfPDBs 1 \
 -pdbName pdb3 \
 -pdbAdminPassword OraPasswd1 \
 -databaseType MULTIPURPOSE \
 -automaticMemoryManagement false \
 -totalMemory 1536 \
 -storageType FS \
 -datafileDestination "/u01/app/oracle/oradata/" \
 -redoLogFileSize 50 \
 -emConfiguration NONE \
 -ignorePreReqs