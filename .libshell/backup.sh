export BORG_REPO=~/myCloud/backup/github
export BORG_PASSPHRASE=$(pass macbook-15/backup)

export ARCHIVE=$(date +'%a-%Y-%m-%d')

/usr/bin/borg create     \
    --verbose            \
    --filter AME         \
    --list               \
    --stats              \
    --show-rc            \
    --compression lz4    \
    --exclude-caches     \
    --exclude=.venv      \
    --exclude=.vagrant   \
    --exclude=*.pyc      \
    ::${ARCHIVE}         \
    /Users/tzhkrka5/Documents/GitHub

/usr/bin/borg prune     \
    --list              \
    --show-rc           \
    --keep-daily    7   \
    --keep-weekly   4   \
    --keep-monthly  6
