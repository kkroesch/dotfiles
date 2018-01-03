#!/bin/bash
# TAR Full/Diff Backup Skript
# by A.Laub andreas[-at-]laub-home.de

# Directories
DATADIR="/srv/data"
BACKUPDIR="/srv/backup"
# Backup Filenames
FULLBACKUPFILE="$(date +"%F-%H%M")-FULL.tar.gz"
DIFFBACKUPFILE="$(date +"%F-%H%M")-DIFF.tar.gz"
# Make only a Full Backups and No Differential (yes/no)
FULLBACKUPONLY="no"
# Day for the FullBackup (Sun,Mon,Tue,Wed,Thu,Fri,Sat)
FULLBACKUPDAY="Sun"
#Delete old Backupfiles when they are xx Days old
DAYS="14"

function REMOVE {
        #Remove old Backup files
        find $BACKUPDIR -iname "*DIFF.tar.gz" -daystart -mtime +$DAYS -delete
        FULLBACKUPDAYS=$(( $DAYS+7 ))
        find $BACKUPDIR -iname "*FULL.tar.gz" -daystart -mtime +$FULLBACKUPDAYS -delete
        #Remove Timestamp File on Fullbackupday
        if [ $(date +%a) = $FULLBACKUPDAY -o $FULLBACKUPONLY = yes ]; then
                rm -f $BACKUPDIR/timestamp.txt
        fi
}

function FULLBACKUP {
        echo "FULL: Backup Files"
        date '+%Y-%m-%d' > $BACKUPDIR/timestamp.txt
        tar czvf $BACKUPDIR/$FULLBACKUPFILE $DATADIR 2> /tmp/tmp_file
        /bin/ls -lh $BACKUPDIR/*.tar.gz | awk '{ print $5 " " $9}'
}

function DIFFBACKUP {
        #Timestamp Datei Auslesen
        NDATE=$(cat $BACKUPDIR/timestamp.txt)
        echo "DIFF: Backup Files"
        tar czvf $BACKUPDIR/$DIFFBACKUPFILE --newer $NDATE $DATADIR 2> /tmp/tmp_file
        /bin/ls -lh $BACKUPDIR/*.tar.gz | awk '{ print $5 " " $9}'
}

# Start the Job
REMOVE
if [ ! -f $BACKUPDIR/timestamp.txt ]; then
        FULLBACKUP                                                                                                            $
elif [ -f $BACKUPDIR/timestamp.txt ]; then
        DIFFBACKUP
fi
