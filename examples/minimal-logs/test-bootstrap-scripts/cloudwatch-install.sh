#!/bin/bash
os=$(awk -F= '/^NAME/{print $2}' /etc/os-release)

case $os in
        "\"Amazon Linux\"" | "\"Red Hat Enterprise Linux\"")
              echo "********** Downloading Cloudwatch Agent **********"
              curl https://s3.${region}.amazonaws.com/amazoncloudwatch-agent-${region}/amazon_linux/amd64/latest/amazon-cloudwatch-agent.rpm --output agent.rpm
              if [[ $(ls -la | grep agent) ]];
              then
              echo "Cloudwatch agent installation file was found."
              else
              echo "Could not download the Cloudwatch agent installation file."
              exit 1
              fi
              echo "********** Installing Cloudwatch Agent **********"
              rpm -i ./agent.rpm ;;
        "\"Ubuntu\"")
              echo "********** Downloading Cloudwatch Agent **********"
              curl https://s3.${region}.amazonaws.com/amazoncloudwatch-agent-${region}/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb --output agent.deb
              if [[ $(ls -la | grep agent) ]];
              then
              echo "Cloudwatch agent installation file was found."
              else
              echo "Could not download the Cloudwatch agent installation file."
              exit 1
              fi
              echo "********** Installing Cloudwatch Agent **********"
              dpkg -i ./agent.deb ;;
        *)    echo "Not recognized OS, aborting..." ;;

esac

cd /opt/aws/amazon-cloudwatch-agent/etc/
touch cloudwatch-config.json
echo " {
    \"logs\": {
            \"endpoint_override\": \"${endpoint}\",
      \"logs_collected\": {
             \"files\": {
                 \"collect_list\": [
                     {
                         \"file_path\": \"/home/ubuntu/tamr/logs/unify-all.error.log\",
                         \"log_group_name\": \"${log_group}\",
                         \"log_stream_name\": \"unify-all.error\",
                         \"timestamp_format\": \"%H: %M: %S%y%b%-d\"
                     },
                     {
                         \"file_path\": \"/home/ubuntu/tamr/logs/unify-all.out.log\",
                         \"log_group_name\": \"${log_group}\",
                         \"log_stream_name\": \"unify-all.out\",
                         \"timestamp_format\": \"%H: %M: %S%y%b%-d\"
                     },
                     {
                         \"file_path\": \"/home/ubuntu/tamr/logs/unify-events.log\",
                         \"log_group_name\": \"${log_group}\",
                         \"log_stream_name\": \"unify-events\",
                         \"timestamp_format\": \"%H: %M: %S%y%b%-d\"
                     },
                     {
                         \"file_path\": \"/home/ubuntu/tamr/logs/unify.log\",
                         \"log_group_name\": \"${log_group}\",
                         \"log_stream_name\": \"unify\",
                         \"timestamp_format\": \"%H: %M: %S%y%b%-d\"
                     },
                     {
                         \"file_path\": \"/home/ubuntu/tamr/logs/auth.log\",
                         \"log_group_name\": \"${log_group}\",
                         \"log_stream_name\": \"unify-auth\",
                         \"timestamp_format\": \"%H: %M: %S%y%b%-d\"
                     },
                     {
                         \"file_path\": \"/home/ubuntu/tamr/logs/dataset.log\",
                         \"log_group_name\": \"${log_group}\",
                         \"log_stream_name\": \"unify-dataset\",
                         \"timestamp_format\": \"%H: %M: %S%y%b%-d\"
                     },
                     {
                         \"file_path\": \"/home/ubuntu/tamr/logs/recipe.log\",
                         \"log_group_name\": \"${log_group}\",
                         \"log_stream_name\": \"unify-recipe\",
                         \"timestamp_format\": \"%H: %M: %S%y%b%-d\"
                     },
                     {
                         \"file_path\": \"/home/ubuntu/tamr/logs/dedup.log\",
                         \"log_group_name\": \"${log_group}\",
                         \"log_stream_name\": \"unify-dedup\",
                         \"timestamp_format\": \"%H: %M: %S%y%b%-d\"
                     }
                 ]
              }
          }
      }
  } " | tee cloudwatch-config.json

  echo "********** Mounting Cloudwatch Agent config file to Cloduwatch Agent **********"
  /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -s -c file:/opt/aws/amazon-cloudwatch-agent/etc/cloudwatch-config.json

case $os in
       "\"Amazon Linux\"" | "\"Red Hat Enterprise Linux\"")
         echo "********** Starting Cloudwatch Agent **********"
              amazon-cloudwatch-agent-ctl -a start ;;
        "\"Ubuntu\"")
        echo "********** Starting Cloudwatch Agent **********"
              systemctl start amazon-cloudwatch-agent.service ;;
        *)    echo "Not recognized OS, aborting..."

esac
