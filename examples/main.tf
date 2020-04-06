module "tamr-vm" {
  source = "git::https://github.com/Datatamer/terraform-emr-tamr-vm"
  aws_role_name = "name-for-tamr-role"
  aws_instance_profile_name = "name-for-tamr-instance-profile"
  aws_account_id = "123456789012"
  aws_emr_creator_policy_name = "name-for-emr-permissions-policy"
  aws_emrfs_user_policy_name = "name-for-s3-permissions-policy"
  aws_emrfs_hbase_bucket_name = "hbase-root-bucket-name"
  aws_emrfs_hbase_logs_bucket_name = "hbase-logs-bucket-name"
  aws_emrfs_spark_logs_bucket_name = "spark-logs-bucket-name"
  vpc_id = "vpc-12345abcde"
  ami = "ami-abcde12345"
  instance_type = "m4.2xlarge"
  key_name = "ssh-key-name"
  subnet_id = "subnet-123456789"
  ingress_cidr_blocks = [
    "1.2.3.4/16",
    "10.10.10.10/32"
  ]
}
