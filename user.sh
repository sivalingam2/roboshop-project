curl -sL https://rpm.nodesource.com/setup_lts.x | bash
cp user.repo /etc/systemd/system/catalogue.service
cp mango.repo /etc/yum.repos.d/mongo.repo
yum install nodejs -y
useradd roboshop
mkdir /app
curl -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip
cd /app
unzip /tmp/user.zip
cd /app
npm install
yum install mongodb-org-shell -y
mongo --host mangodb.sivadevops22.online </app/schema/user.js
systemctl daemon-reload
systemctl enable user
systemctl start user
