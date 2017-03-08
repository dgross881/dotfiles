# db-dump DB_NAME FILENAME
function db-dump() {
  if (( $# == 2 )); then
    pg_dump --clean --create --format=custom --file "$2" "$1" && \
      echo "Wrote to $2"
  else
    echo "Usage: db-dump DB_NAME FILENAME"
    return 1
  fi
}

# db-restore DB_NAME FILENAME
function db-restore() {
  if (( $# == 2 )); then
    dropdb "$1" && \
      createdb "$1" && \
      pg_restore \
        --verbose \
        --clean \
        --no-acl \
        --no-owner \
        --jobs `getconf _NPROCESSORS_ONLN` \
        --dbname "$1" \
        "$2"
  else
    echo "Usage: db-restore DB_NAME FILENAME"
    return 1
  fi
}
