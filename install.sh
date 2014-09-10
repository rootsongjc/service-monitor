#!/bin/bash
########################
#Install monitor
#Authro: jcsong
#Date: 2014-08-05
########################
echo "Installing pypa0setuptools..."
cd pypa-setuptools
python setup.py install
echo "Installing argparse..."
cd ../argparse-1.2.1
python setup.py install
echo "Installing thrift..."
cd ../thrift-0.9.1
python setup.py install
cd ../
echo "Complete"
