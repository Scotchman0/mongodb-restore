#!/bin/bash
#for recovery targeting

LATEST=$(date +%y-%m-%d_%H-%M)
LOG_LOCATION=/backup/logs/restore-${LATEST}.log
LAST_SNAP=$(ls -ltr mongo-snapshots/ | tail -n 1 | awk '{print $9}')
USERNAME=<username>
SECRET=$(cat /backup/.secret)

echo "Available snapshots at /backup/mongo-snapshots/"
ls /backup/mongo-snapshots/
echo "This script is designed to restore mongodb back to a previous snapshot"
echo "insert the name of the snapshot you wish to restore from /backup/mongo-snapshots/"
echo "example: ${LAST_SNAP}"
read SNAPSHOT

echo "now expanding snapshot at path: /backup/latest-snapshot"

#expand the snapshot:
tar -xvf /backup/mongo-snapshots/${SNAPSHOT} --directory=/backup/latest-snapshot/
echo "expanded snapshot ${SNAPSHOT}"

echo "press return to restore mongoDB to this revision"

read HOLD

echo "beginning mongorestore"
#restore mongoDB to local mongo database:
mongorestore -u $USERNAME -p $SECRET --drop /backup/latest-snapshot/backup/mongo | tee $LOG_LOCATION
echo "completed restore"
