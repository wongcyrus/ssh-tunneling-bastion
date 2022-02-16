FROM alpine:latest
LABEL maintainer="Cyrus Wong <cywong@vtc.edu.hk>"
RUN apk add --update --no-cache openssh bash wget curl vim shadow 

ADD sshd_config /etc/ssh/sshd_config    
RUN ssh-keygen -A


# Add a "bastion" user with a default password of "bastion"
RUN adduser -s /bin/bash -S bastion && \
    echo "bastion:bastion" | chpasswd && \
    mkdir -p /home/bastion/.ssh

RUN adduser -s /bin/bash -S student && \
    echo "student:student" | chpasswd && \
    mkdir -p /home/bastion/.ssh
    
# Set a motd
ADD motd /etc/motd

# Expose SSH
EXPOSE 22

# Define our entrypoint
ADD docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["bash", "/usr/local/bin/docker-entrypoint.sh"]

# Start the server
CMD ["/usr/sbin/sshd", "-D", "-e"]