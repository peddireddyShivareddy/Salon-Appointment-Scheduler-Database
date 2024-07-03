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
CUSTOMER_NAME=$($PSQL "SELECT name from customers where phone = '$PHONE_NUMBER'")
if [[ -z $CUSTOMER_NAME ]]
then
echo -e "\nI don't have a record for that phone number, what's your name?"
read CUSTOMER_NAME
INSERT_CUSTOMER_RESULT=$($PSQL "insert into customers(name,phone) values('$CUSTOMER_NAME','$PHONE_NUMBER')")
else

fi
fi
