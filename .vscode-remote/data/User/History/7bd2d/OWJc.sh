#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"
echo -e "\n~~~~~ MY SALON ~~~~~\n"
echo "Welcome to My Salon, how can I help you?"
MAIN_MENU() {
  if [[ $1 ]]
then
  echo -e "\n$1"
fi
  OPTIONS=$($PSQL "SELECT service_id,name from services")
  echo "$OPTIONS" | while read SERVICE_ID BAR NAME
  do
  echo -e "\n$SERVICE_ID) $NAME"
  done
  read SERVICE
}
MAIN_MENU
if [[ ! $SERVICE =~ ^[1-5]$ ]]
then
MAIN_MENU "I could not find that service. What would you like today?"
else
echo -e "\nWhat's your phone number?"
read PHONE_NUMBER
IF
fi
