FROM node:4.6

RUN npm install serverless@1.0.0-rc.2 -g
RUN npm install serverless-plugin-write-env-vars -g
RUN npm install serverless-run-function-plugin -g

ENV NODE_PATH=/usr/local/lib/node_modules
ENV AWS_REGION=us-east-1

RUN apt-get update && \
    apt-get install -qq -y unzip

ENV PYTHON_URL https://www.python.org/ftp/python/3.5.2/Python-3.5.2.tgz
RUN mkdir binaries && \
    cd /binaries && \
    curl -o python.tgz -L $PYTHON_URL && \
    tar xf python.tgz && \
    cd /binaries/Python-3.5.2 && \
    ls -al && \
    ./configure && make && make install && \
    rm -rf /binaries/* && \
    python3 --version

RUN pip3 install pyinstaller==3.2

RUN apt-get install -qq -y openjdk-7-jre-headless

ENV FITNESSE_URL "http://fitnesse.org/fitnesse-standalone.jar?responder=releaseDownload&release=20160618"
RUN cd /binaries && \
    curl -o fitnesse-standalone.jar -L $FITNESSE_URL && \
    chmod 777 /binaries/fitnesse-standalone.jar

ENV W_URL https://pypi.python.org/packages/65/60/d154ad7ebc4627238a24505871ccb6495e9dc1f71abe55e8516a65187203/waferslim-1.0.2-py3.1.zip#md5=0a64e550f67b3e02d99373d83498547d
RUN cd /binaries && \
    curl -o waferslim.zip -L $W_URL && \
    unzip waferslim && \
    cd /binaries/waferslim-1.0.2 && \
    python3 setup.py install

WORKDIR /lambda-fitnesse


CMD ["/bin/bash"]
