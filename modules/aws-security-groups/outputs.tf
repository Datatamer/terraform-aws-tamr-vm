output "security_groups" {
  value = concat(
    aws_security_group.security-groups-ingress-cidr,
    aws_security_group.security-groups-ingress-sg,
    aws_security_group.security-groups-egress-cidr,
    aws_security_group.security-groups-egress-sg,
  )

  description = "Security groups created by this module"
}
output "security_groups_ids" {
  value = concat(
    length(aws_security_group.security-groups-ingress-cidr) > 0 ?
    aws_security_group.security-groups-ingress-cidr[*].id : [],
    length(aws_security_group.security-groups-ingress-sg) > 0 ?
    aws_security_group.security-groups-ingress-sg[*].id : [],
    length(aws_security_group.security-groups-egress-cidr) > 0 ?
    aws_security_group.security-groups-egress-cidr[*].id : [],
    length(aws_security_group.security-groups-egress-sg) > 0 ?
    aws_security_group.security-groups-egress-sg[*].id : [],
  )
  description = "IDs of the security groups created by this module"
}
