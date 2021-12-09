#!/bin/bash
osversion=$(awk -F= '/^NAME/{print $2}' /etc/os-release)

case "$osversion" in
        "\"Amazon Linux\"") 
              echo "********** Downloading Cloudwatch Agent **********"
              sudo curl https://s3.${region}.amazonaws.com/amazoncloudwatch-agent-${region}/amazon_linux/amd64/latest/amazon-cloudwatch-agent.rpm --output agent.rpm
              echo "********** Installing Cloudwatch Agent **********"
              sudo yum install -y ./agent.rpm ;;
        "\"Ubuntu\"") 
              echo "********** Downloading Cloudwatch Agent **********"
              curl https://s3.${region}.amazonaws.com/amazoncloudwatch-agent-${region}/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb --output agent.deb
              sudo dpkg -i ./agent.deb ;;
              *) echo "Not recognized OS, aborting..." ;;

esac

cd /opt/aws/amazon-cloudwatch-agent/etc/
sudo touch cloudwatch-config.json
sudo echo " {
    \"logs\": {
            \"endpoint_override\": \"${endpoint}\",
      \"logs_collected\": {
             \"files\": {
                 \"collect_list\": [
                     {
                         \"file_path\": \"/home/ubuntu/tamr/logs/unify-all.error.log\",
                         \"log_group_name\": \"tamr.log\",
                         \"log_stream_name\": \"unify\",
                         \"timestamp_format\": \"%H: %M: %S%y%b%-d\"
                     },  
                     {
                         \"file_path\": \"/home/ubuntu/tamr/logs/unify-all.out.log\",
                         \"log_group_name\": \"tamr.log\",
                         \"log_stream_name\": \"unify\",
                         \"timestamp_format\": \"%H: %M: %S%y%b%-d\"
                     },
                     {
                         \"file_path\": \"/home/ubuntu/tamr/logs/unify-events.log\",
                         \"log_group_name\": \"tamr.log\",
                         \"log_stream_name\": \"unify\",
                         \"timestamp_format\": \"%H: %M: %S%y%b%-d\"
                     }, 
                     {
                         \"file_path\": \"/home/ubuntu/tamr/logs/unify.log\",
                         \"log_group_name\": \"tamr.log\",
                         \"log_stream_name\": \"unify\",
                         \"timestamp_format\": \"%H: %M: %S%y%b%-d\"
                     },
                     {
                         \"file_path\": \"/opt/aws/amazon-cloudwatch-agent/logs/amazon-cloudwatch-agent.log\",
                         \"log_group_name\": \"tamr.log\",
                         \"log_stream_name\": \"unify\",
                         \"timestamp_format\": \"%H: %M: %S%y%b%-d\"
                     }
                     
                 ]
              }
          }
      }
  } " | sudo tee cloudwatch-config.json

case "$osversion" in
        "\"Amazon Linux\"") 
              echo "********** Mounting Cloudwatch Agent config file to Cloduwatch Agent **********"
              sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -s -c file:/opt/aws/amazon-cloudwatch-agent/etc/cloudwatch-config.json
              sudo amazon-cloudwatch-agent-ctl -a start ;;

        "\"Ubuntu\"") 
              sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -s -c file:/opt/aws/amazon-cloudwatch-agent/etc/cloudwatch-config.json
              sudo systemctl start amazon-cloudwatch-agent.service ;;
              *) echo "Not recognized OS, aborting..."

esac
