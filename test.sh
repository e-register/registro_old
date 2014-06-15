#!/bin/bash -e

start=`date +%s%N`

YELLOW="\e[1;93m"
GREEN="\e[1;32m"
DEFAULT="\e[0m"

# test mysql
echo -e "$YELLOW=============== TEST MYSQL ===============$DEFAULT"
export DB=mysql
RAILS_ENV=test bundle exec rake --trace db:migrate test
echo -e "\n\n"


# test sqlite
echo -e "$YELLOW============== TEST SQLITE ===============$DEFAULT"
export DB=sqlite
RAILS_ENV=test bundle exec rake --trace db:migrate test
echo -e "\n\n"


# test postgresql
echo -e "$YELLOW============ TEST POSTGRESQL =============$DEFAULT"
export DB=postgresql
RAILS_ENV=test bundle exec rake --trace db:migrate test


end=`date +%s%N`
elasped=`echo "scale=3;($end-$start)/1000000000" | bc`
coverage=`egrep -o '([0-9\.]*)' coverage/.last_run.json`

echo -e "$GREEN\n------------ ALL TEST SUCCEDED! --------------$DEFAULT"
echo -e "$YELLOW--------- elasped time: $elasped sec ------------$DEFAULT"
echo -e "$YELLOW----------- coverage: $coverage % ----------------\n$DEFAULT"
