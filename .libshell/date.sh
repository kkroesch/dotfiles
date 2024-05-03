function ts2date {
  date -d @$1 '+%d.%m.%Y %H:%M:%S'
}
