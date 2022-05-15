FROM ubuntu
RUN apt-get update \
   && apt-get install maven -y && apt-get install curl -y && apt-get install unzip -y \
   && apt-get install git -y \
   && git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git /var/boxfuse \
   && cd /var/boxfuse \
   && mvn package \
   && mkdir /var/share \
   && cp /var/boxfuse/target/hello-1.0.war /var/share/ \
   && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
   && unzip awscliv2.zip \
   && ./aws/install -i /usr/local/aws-cli -b /usr/local/bin \
   && ./aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli --update \
   && aws configure set aws_access_key_id "YCAJEeIxvjm3GjpXekRtIPZE_" \
   && aws configure set aws_secret_access_key "YCOHJ0w3RTu3XD_YQITb6XrHWQ7ZCHl2MJHHbo6M" \
   && aws configure set region "ru-central1"  \
   && cd /var/share \
   && aws --endpoint-url=https://storage.yandexcloud.net s3 cp hello-1.0.war s3://art40/hello.war
