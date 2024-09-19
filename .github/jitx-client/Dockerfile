FROM 657302324634.dkr.ecr.us-west-2.amazonaws.com/jitx-client:develop
# To pull this image locally, you need to authenticate with JITX's ECR assuming you have a jitx profile with credentials:
# aws ecr --profile jitx get-login-password --region us-west-2 | docker login --username AWS --password-stdin 657302324634.dkr.ecr.us-west-2.amazonaws.com

WORKDIR /app
COPY ./user.params /root/.jitx/user.params
COPY ./license /root/.jitx/license

CMD ["/bin/bash", "-c", "apt update ; apt install make build-essential -y ; git config --global --replace-all safe.directory '*' ; export STANZA_CONFIG=/root/.jitx/current ; export SLM_ROOT_DIR=${STANZA_CONFIG}/slm ; export SLM_STANZA=jstanza ; export PATH=$PATH:${STANZA_CONFIG}/stanza:${SLM_ROOT_DIR} ; cat $STANZA_CONFIG/scripts/install-info.sh ; cd jsl ; make tests"]
 
