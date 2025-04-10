
# euliaa_oper

## Overview

This repository contains scripts to help set up the data processing of the EULIAA Lidar.

The scripts are designed to setup the processing on the European Weather Cloud (EWC).

## Repository Structure

The subdirectories contain the following:

- `ewc_setup/`: Contains all the shell scripts used for various operational tasks, to run on the European Weather Cloud.
- `operator_setup/`: Scripts to be installed at operator station (i.e. lidar)

## Installation

### On the European Weather Cloud
In your virtual machine
- Clone this repository
- `cd euliaa_oper/ewc_setup/`
- Then run `./main.sh`
- You will need to enter the access and secret keys in the S3 bucket configuration.

### On operator (lidar unit)
This mostly takes care of installing packages for data transfer to S3 bucket
- clone this repository
- `cd euliaa_oper/operator_setup`
- `cp ewc_example.conf ewc.conf`
- Then, edit ewc.conf and add the access and secret keys for S3 bucket configuration. You can also change where the buckets are mounted (`S3_MOUNTPOINT`), currently `/data/`.
- Make the bash scripts executable: `chmod +x *.sh`
- Run `./install_s3.sh` : this installs and configures the S3 buckets. At the end, you will be requested to validate the configuration (by hitting Enter or typing 'y').
- Run `./s3_automount_buckets.sh <your_bucket_name>`. For now, you should set `<your_bucket_name>` to `euliaa-l1`.

## Configuration and documentation

The processing scripts themselves are here: https://github.com/MCH-MDA/euliaa_postproc.git .
