# generate a new bucket and attach policy. Takes bucket name as first argument (omit the s3:// part)

BUCKET_NAME=$1  # e.g. eprofile-dl-raw
POLICY_FILE=s3_policy_ukmo.txt

if [ $# -ne 1 ]
then
    echo "sript excepts 1 input argument, namely the bucket name"
    exit 2
fi

# abort if bucket already exists
s3cmd info s3://$BUCKET_NAME > /dev/null 2>&1
if [ $? -eq 0 ]
then
    echo "bucket s3://$BUCKET_NAME does already exist. Refusing to change anything on it"
    exit 1
fi

# generate bucket and attach policy
s3cmd mb s3://$BUCKET_NAME
s3cmd setpolicy $POLICY_FILE s3://$BUCKET_NAME

