#!/bin/bash

read -p "Enter AWS profile to use for deployment [default]: " PROFILE
PROFILE=${PROFILE:-default}
echo $PROFILE

read -p "Enter a stack name [Keep-RDS-DB-Stopped]: " STACK_NAME
STACK_NAME=${STACK_NAME:-Keep-RDS-DB-Stopped}
echo $STACK_NAME

read -p "Enter 'c' for keeping a cluster stopped, 'i' for an instance [c]: " DB_OPTION
DB_OPTION=${DB_OPTION:-c}
echo $DB_OPTION

if [ "$DB_OPTION" == "c" ]; then
    aws --profile $PROFILE cloudformation deploy \
        --stack-name $STACK_NAME \
        --template-file ./stop-db-cluster/main.yml \
        --parameter-overrides file://stop-db-cluster/params.json \
        --capabilities CAPABILITY_NAMED_IAM
elif [ "$DB_OPTION" == "i" ]; then
    aws --profile $PROFILE cloudformation deploy \
        --stack-name $STACK_NAME \
        --template-file ./stop-db-instance/main.yml \
        --parameter-overrides file://stop-db-instance/params.json \
        --capabilities CAPABILITY_NAMED_IAM
else
    echo "Invalid choice. Please select either 'c' for cluster or 'i' for instance."
fi

echo "Congrats, your DB will now be stopped indefinitely (online at most as long as your polling schedule)"
