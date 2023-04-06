FROM ubuntu:22.04

WORKDIR /temp

RUN apt-get -qq update
RUN apt-get -qq install curl -y
RUN apt-get -qq install zip unzip -y

# Install aws cli
RUN curl -s "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip -qq awscliv2.zip
RUN ./aws/install
RUN rm -rf awscliv2.zip
RUN rm -rf aws

# Install python3.10
RUN apt-get install python3.10 -y
RUN apt-get install python3.10-venv -y

# Install terraform
# https://releases.hashicorp.com/terraform/
RUN curl -s "https://releases.hashicorp.com/terraform/1.5.2/terraform_1.5.2_linux_amd64.zip" -o terraform.zip
RUN unzip -qq terraform.zip
RUN mv terraform /usr/bin/
RUN rm -rf terraform.zip


