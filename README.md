# ssh-tunneling-bastion

## Start Container
docker run --name ssh-tunneling-bastion -p 22:22 --rm \
    -e "BASTION_PASSWORD=Abcd1234" \
    -e "STUDENT_PASSWORD=Abcd1234" \
    ssh-tunneling-bastion:latest

## Stop Container
docker container stop ssh-tunneling-bastion

## Build Container
docker build -t ssh-tunneling-bastion .

## For AWS Cloud9
All SSH in port 2222 because 22 is in use.

security_group=$(ec2-metadata -s | cut -d " " -f 2);
aws ec2 authorize-security-group-ingress --group-name $security_group --protocol tcp --port 2222 --cidr 0.0.0.0/0


# Push to docker hub
docker image build -t wongcyrus/ssh-tunneling-bastion:v1 .
docker image push wongcyrus/ssh-tunneling-bastion:v1

