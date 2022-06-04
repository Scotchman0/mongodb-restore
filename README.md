# mongodb-restore
A personal project to aide in the backup and restoration of mongodb databases using mongodump and mongorestore - to be used with crontab


# granting role permission for primary unit
 db.grantRolesToUser( "`<backup-user>`", [ { role: "backup", db: "admin" } ] )
