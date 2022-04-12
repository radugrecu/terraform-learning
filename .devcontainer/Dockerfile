# https://hub.docker.com/r/amazon/aws-cli/tags
FROM amazon/aws-cli:2.1.36

# install command.
RUN yum update -y \
    && yum install -y less vim wget unzip tar \
    && yum clean all

# install terraform.
# https://releases.hashicorp.com/terraform/
# https://azukipochette.hatenablog.com/entry/2018/06/24/004354
# ARG terraform_version="0.14.10"
# RUN wget https://releases.hashicorp.com/terraform/${terraform_version}/terraform_${terraform_version}_linux_amd64.zip && \
#     unzip ./terraform_${terraform_version}_linux_amd64.zip -d /usr/local/bin/

# initialize command.
# ARG AWS_ACCESS_KEY_ID
# ARG AWS_SECRET_ACCESS_KEY
# COPY ../settings/.aws /root/.aws
# COPY ../settings/init.sh /root/init.sh
# RUN chmod +x /root/init.sh && /root/init.sh