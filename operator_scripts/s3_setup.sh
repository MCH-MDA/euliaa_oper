# Install s3cmd
sudo apt-get install s3cmd

file_conf = '~/.s3cfg'
if [ ! -f "$file_conf" ]; then
    echo "configuration file $file_conf does not exist! To make the package run do the following:"
    echo "    1. Copy s3cfg_example to ~/.s3fg"
    echo "    2. Edit ~/.s3cfg and add your access and secret keys (https://morpheus.ecmwf.int/tools/cypher)"
    echo "    3. Re-run your script"
    exit 2
fi

s3cmd --configure # Not sure if this is necessary, or in which case (without this it didn't seem to work on my LabVM but to be checked)