cp mango.repo /etc/yum.repos.d/mongo.repo
yum install mongodb-org -y
sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
#update localhost ip address 127.0.0.1 to 0.0.0.0
systemctl enable mongod
systemctl restart mongod