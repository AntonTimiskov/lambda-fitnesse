sudo docker pull antontimiskov/labmda-fitnesse:latest
sudo docker tag antontimiskov/labmda-fitnesse:latest labmda-fitnesse:latest
sudo docker build --rm -t lambda-fitnesse --file ./Dockerfile .

