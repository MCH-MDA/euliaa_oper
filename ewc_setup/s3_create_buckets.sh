# Create S3 buckets. Pass bucket names as arguments to script.

path_scripts=$(dirname "$0")

for bucket in ${@}
do
    $path_scripts/s3_generate_bucket.sh $bucket
done

