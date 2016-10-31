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

echo "Running... $CMD"
sudo docker run -ti --rm \
     -v "$(pwd)/serverless.yml:/binaries/serverless.yml" \
     -v "$(pwd)/handler.js:/binaries/handler.js" \
     -v "$(pwd)/event.json:/binaries/event.json" \
     -v "$FITNESSE_ROOT:/binaries/FitNesseRoot" \
     -v "$FIXTURES:/binaries/fixtures"\
     -e "SLS_DEBUG=$SLS_DEBUG" \
     antontimiskov/lambda-fitnesse:latest \
     $CMD
