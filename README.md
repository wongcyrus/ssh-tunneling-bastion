# ssh-tunneling-bastion

## Start Container
docker run --name ssh-bastion -p 22:22 --rm \
    -e "BASTION_PASSWORD=Abcd1234" \
    -e "STUDENT_PASSWORD=Abcd1234" \
    ssh-bastion:latest

## Stop Container
docker container stop ssh-bastion

## Build Container
docker build -t ssh-bastion .


## For AWS Cloud9
All SSH in port 2222 because 22 is in use.

security_group=$(ec2-metadata -s | cut -d " " -f 2);
aws ec2 authorize-security-group-ingress --group-name $security_group --protocol tcp --port 2222 --cidr 0.0.0.0/0