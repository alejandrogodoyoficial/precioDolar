FROM ubuntu:20.04
WORKDIR script
RUN  apt-get update &&  apt-get install -y jq curl
COPY . .
CMD ["bash", "script.sh"]

