echo  -e "\e[32m>>>>> catalogue service <<<<<\e[0m"
cp catalogue.repo /etc/systemd/system/catalogue.service
echo  -e "\e[32m>>>>> mango repo file <<<<<\e[0m"
cp mango.repo /etc/yum.repos.d/mongo.repo
echo  -e "\e[32m>>>>> setup nodejs <<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
echo  -e "\e[32m>>>>> install nodejs <<<<<\e[0m"
yum install nodejs -y
echo  -e "\e[32m>>>>> application user <<<<<\e[0m"
useradd roboshop
echo  -e "\e[32m>>>>> setup app directory <<<<<\e[0m"
mkdir /app
echo  -e "\e[32m>>>>> download application <<<<<\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
cd /app
unzip /tmp/catalogue.zip
echo  -e "\e[32m>>>>> download dependencies <<<<<\e[0m"
cd /app
npm install
echo  -e "\e[32m>>>>> install mangodb <<<<<\e[0m"
yum install mongodb-org-shell -y
echo  -e "\e[32m>>>>> replace mangodb <<<<<\e[0m"
mongo --host mangodb.sivadevops22.online </app/schema/catalogue.js
echo  -e "\e[32m>>>>> load service <<<<<\e[0m"
systemctl daemon-reload
echo  -e "\e[32m>>>>> restart the service <<<<<\e[0m"
systemctl enable catalogue
systemctl restart catalogue
