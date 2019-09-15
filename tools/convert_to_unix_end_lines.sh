# Converts windows line-endings to unix ones
# USAGE: ./convert_to_unix_end_lines.sh COMMIT_DIR_NAME
echo -e "$(find ../data/$1 -name '*.txt')\n$(find ../data/$1 -name '*.md')" | xargs dos2unix
