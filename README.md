[![Build Status](https://travis-ci.org/infrastructor/docker-centos-sshd.svg?branch=master)](https://travis-ci.org/infrastructor/docker-centos-sshd)

# docker-centos-sshd
CentOS 7 based image with SSHD service preconfigured. Useful for infrastructor integration testing. 
There are 3 users available: 
* root, password: infra, private key: see repository.
* devops, password: devops, private key: see repository, no password needed for sudo actions.
* sudops, password: sudops, private key: see repository, need a password for sudo actions.
