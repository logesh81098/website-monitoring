##############################################################################################################################
#                                            IAM Module
##############################################################################################################################

#IAM Role
resource "aws_iam_role" "website-monitoring-server-role" {
  name = "website-monitoring-server-iam-role"
  description = "IAM Role for Website Monitoring server"
  tags = {
    Name = "Website Monitoring Server Role"
  }
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "sts:AssumeRole",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            }
        }
    ]
}
EOF
}





##############################################################################################################################
#                                            IAM Policy
##############################################################################################################################

#IAM Policy
resource "aws_iam_policy" "website-monitoring-server-policy" {
  name = "website-monitoring-server-iam-policy"
  description = "IAM Policy for Website Monitoring Server"
  tags = {
    Name = "Website Monitoring Server IAM Policy"
  }
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "ReadCloudWatchLogMetrics",
            "Effect": "Allow",
            "Action": [
                "cloudwatch:GetMetricData",
                "cloudwatch:GetMetricStatistics",
                "cloudwatch:ListMetrics",
                "cloudwatch:DescribeAlarms",
                "cloudwatch:DescribeAlarmHistory"
            ],
            "Resource": "*"
        },
        {
            "Sid": "DiscoverEC2Instances",
            "Effect": "Allow",
            "Action": [
                "ec2:DescribeInstances",
                "ec2:DescribeInstances",
                "ec2:DescribeRegions",
                "ec2:DescribeTags",
                "ec2:DescribeVolumes"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}


##############################################################################################################################
#                                             IAM Role Policy Attachment
##############################################################################################################################

resource "aws_iam_role_policy_attachment" "website-monitoring-server" {
  role = aws_iam_role.website-monitoring-server-role.id
  policy_arn = aws_iam_policy.website-monitoring-server-policy.arn
}


##############################################################################################################################
#                                                IAM Instance Profile
##############################################################################################################################

resource "aws_iam_instance_profile" "instance-profile" {
  role = aws_iam_role.website-monitoring-server-role.id
  name = "website-monitoring-server-instance-profile"
}