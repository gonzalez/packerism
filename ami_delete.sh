#!/bin/sh
# ------------------------------------------------------------------
# [http://github.com/gonzalez]
#  Name:
#   ami_delete.sh
#
#  Description:
#   This script finds the ami's snapshot based on ami id,
#   deregisters the ami and removes the snapshot
#
#  Usage:
#   ./ami_delete.sh ami-xxxx
#
#  Dependency:
#   https://github.com/aws/aws-cli installed locally.
# ------------------------------------------------------------------

AMI=$1
#todo - replace with regex
SNAPSHOTID=`aws ec2 describe-images --image-ids $AMI |grep SnapshotId|cut -d  "\"" -f4`

echo "Deregistering $AMI . . . "
`aws ec2 deregister-image --image-id $AMI`

sleep 15

echo "Deleting Snapshot $SNAPSHOTID associated with $AMI"
`aws ec2 delete-snapshot --snapshot-id $SNAPSHOTID`
