#!/bin/bash -e

YELLOW="\e[1;93m"
GREEN="\e[1;32m"
DEFAULT="\e[0m"

# test mysql
echo -e "$YELLOW=============== TEST MYSQL ===============$DEFAULT"
export DB=mysql
rake test
echo -e "\n\n"


# test sqlite
echo -e "$YELLOW============== TEST SQLITE ===============$DEFAULT"
export DB=sqlite
rake test
echo -e "\n\n"


# test postgresql
echo -e "$YELLOW============ TEST POSTGRESQL =============$DEFAULT"
export DB=postgresql
rake test

echo -e "$GREEN\n------------ ALL TEST SUCCEDED! --------------\n$DEFAULT"
