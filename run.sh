#!/bin/bash

CMD=$*

if [[ $CMD == "help" ]]; then
  CMD=""
fi

if [[ -z $CMD ]]; then
  echo "Usage:"
  echo "  help                           - (default) You are here now"
  echo "  deploy                         - Deploy to AWS"
  echo "  local <function> <event-json>  - Run the fucntion locally, emulate lambda"
  echo "  invoke <function> <event-json> - Run the fucntion locally, emulate lambda"
  echo "  /bin/bash                      - Type /bin/bash to go inside container"
  exit 1
fi 

if [[ $1 == "deploy" ]]; then
  shift 1
  CMD="sls deploy $*"
fi

if [[ $1 == "local" ]]; then
 echo "$3" > ./event.json
 fn=$2
 shift 3
 CMD="sls run -f $fn -p ./event.json $*"
fi

if [[ $1 == "invoke" ]]; then
 echo "$3" > ./event.json
 fn=$2
 shift 3
 CMD="sls invoke -f $fn -p ./event.json $*"
fi

if [[ -z $FITNESSE_ROOT ]]; then
  echo 'Define: $FITNESSE_ROOT environment variable before run.'
  exit 1
fi

if [[ -z $FIXTURES ]]; then
  echo 'Define: $FIXTURES environment variable before run.'
  exit 1
fi

if [[ -z $PRODUCT_URL ]]; then
  echo 'Define: $PRODUCT_URL environment variable before run.'
  exit 1
fi

if [[ -z $IMAGE_NAME ]]; then
  IMAGE_NAME="antontimiskov/lambda-fitnesse:latest"
  echo 'IMAGE_NAME was not provided. Will use $IMAGE_NAME by default'
fi

if [[ -z $CRYPT ]]; then
  echo 'Define: $CRYPT environment variable before run.'
  exit 1
fi

echo "Running... $CMD"
sudo docker run -ti --rm \
     -v "$(pwd)/serverless.yml:/binaries/serverless.yml" \
     -v "$(pwd)/handler.js:/binaries/handler.js" \
     -v "$(pwd)/event.json:/binaries/event.json" \
     -v "$FITNESSE_ROOT:/binaries/FitNesseRoot" \
     -v "$FIXTURES:/binaries/fixtures"\
     -v "$CRYPT:/binaries/crypt"\
     -e "API_HOST=$API_HOST" \
     -e "API_PORT=$API_PORT" \
     -e "API_PROTO=$API_PROTO" \
     -e "SLS_DEBUG=$SLS_DEBUG" \
     -e "PRODUCT_URL=$PRODUCT_URL" \
     -p "$FITNESSE_PORT:$FITNESSE_PORT"\
     --net=dmp \
     $IMAGE_NAME \
     $CMD
