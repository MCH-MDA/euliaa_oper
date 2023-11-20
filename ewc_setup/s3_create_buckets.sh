# Create S3 buckets. Pass bucket names as arguments to script.

for bucket in ${@}
do
    s3cmd mb $bucket
done