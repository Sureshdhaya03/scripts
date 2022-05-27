import hashlib
import os
import boto3
import sys

AWS_REGION = "us-east-1"

Bucket_Name = "md5-bucket-001"
path = "s3://md5-bucket-001/input/"
s3_client = boto3.client('s3')
s3 = boto3.resource('s3')
bucket_name = s3.Bucket('md5-bucket-001')
status = "md5 failed"
cmd = "aws s3 cp s3://md5-bucket-001/output/index.dat index.dat"
os.system(cmd)
input_path = "index.dat"
output_path = "output.txt"

def md5(file_name):
    md5_hash = hashlib.md5()
    key = 'input/' + file_name
    response = s3_client.get_object(Bucket=Bucket_Name, Key=key)
    data = response['Body'].read()
    md5_hash.update(data)
    return md5_hash.hexdigest()


with open(input_path) as f:
    lines = f.readlines()
    for i in range(len(lines)):
        file_path = lines[i].split('|')[0]
        file = file_path.split('/')[-1]
        load_md5_value = lines[i].split('|')[1].strip()
        md5_result = md5(file)
        try:
            if load_md5_value == md5_result:
                status = "md5 matched"
            else:
                erro_message = "md5 value not matched"
        except:
            erro_message = sys.exc_info()[0]

        with open(output_path, 'a') as wr:
            wr.write(path + file + "|" + status + "|"+ "\n")
            wr.close()

def uploadfile(output_path):
    with open(output_path) as f:
        lines = f.readlines()
        for i in range(len(lines)):
            print(lines[i])
uploadfile(output_path)

cmd = "aws s3 cp  " + output_path + " s3://md5-bucket-001/output/output.txt"
os.system(cmd)


