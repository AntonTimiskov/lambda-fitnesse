if [[ -z $* ]]; then
  IMAGE_NAME="antontimiskov/lambda-fitnesse:latest"
else
  IMAGE_NAME=$1
fi

echo $IMAGE_NAME

sudo docker build --rm -t $IMAGE_NAME --file ./Dockerfile .
