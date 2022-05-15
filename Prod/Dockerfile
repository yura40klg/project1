FROM tomcat:9
RUN apt-get update \
   && apt-get install curl -y && apt-get install unzip -y \
   && apt-get install git -y \
   && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
   && unzip awscliv2.zip \
   && ./aws/install -i /usr/local/aws-cli -b /usr/local/bin \
   && ./aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli --update \
   && aws configure set aws_access_key_id "YCAJEeIxvjm3GjpXekRtIPZE_" \
   && aws configure set aws_secret_access_key "YCOHJ0w3RTu3XD_YQITb6XrHWQ7ZCHl2MJHHbo6M" \
   && aws configure set region "ru-central1" \
   && aws --endpoint-url=https://storage.yandexcloud.net s3 cp s3://art40/hello.war /usr/local/tomcat/webapps/hello.war
