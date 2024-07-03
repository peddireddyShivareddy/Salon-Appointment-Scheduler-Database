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
  read SERVICE_ID_SELECTED
}
MAIN_MENU
if [[ ! $SERVICE =~ ^[1-5]$ ]]
then
MAIN_MENU "I could not find that service. What would you like today?"
else
SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE" | sed -e 's/^[ \t]*//')
echo -e "\nWhat's your phone number?"
read PHONE_NUMBER
CUSTOMER_NAME=$($PSQL "SELECT name from customers where phone = '$PHONE_NUMBER'")
if [[ -z $CUSTOMER_NAME ]]; then
    echo -e "\nI don't have a record for that phone number, what's your name?"
    read CUSTOMER_NAME
    INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME', '$PHONE_NUMBER')")
  fi

  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$PHONE_NUMBER'" | sed -e 's/^[ \t]*//')
  echo -e "\nWhat time would you like your $SERVICE_NAME, $CUSTOMER_NAME?"
  read TIME
  INSERT_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments (customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE, '$TIME')")
  echo -e "\nI have put you down for a $SERVICE_NAME at $TIME, $CUSTOMER_NAME."
fi
