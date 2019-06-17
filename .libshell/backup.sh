export RESTIC_REPOSITORY=${HOME}/myCloud/backup
export RESTIC_PASSWORD_FILE=${HOME}/.resticpassword

function backup() {
    restic backup --exclude-file="${HOME}/.libshell/backup-exclude.txt" $1
}

function snapshots() {
    restic snapshots
}
