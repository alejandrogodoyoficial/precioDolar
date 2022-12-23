FROM ubuntu:20.04
WORKDIR script
RUN [sudo apt-get update, sudo apt-get install jq, sudo apt install curl]
COPY . .
CMD ["bash", "script.sh"]

