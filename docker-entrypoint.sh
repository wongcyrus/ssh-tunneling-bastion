#!/bin/bash

# Don't allow the setup to proceed unless there's an SSH password defined
[ -z "${BASTION_PASSWORD}" ] && \
    echo "[ERROR] Yeah, I'm gonna need you to define an \$BASTION_PASSWORD before I let you continue." && exit 1
[ -z "${STUDENT_PASSWORD}" ] && \
    echo "[ERROR] Yeah, I'm gonna need you to define an \$STUDENT_PASSWORD before I let you continue." && exit 1
    
# Change the SSH user's password to the environment variable
echo "bastion:${BASTION_PASSWORD}" | chpasswd
echo "student:${STUDENT_PASSWORD}" | chpasswd


# Change bastion's home directory if specified
[ -n "${SSH_HOME_DIR}" ] && \
    usermod -d $SSH_HOME_DIR bastion

ssh-keygen -A

exec "$@"