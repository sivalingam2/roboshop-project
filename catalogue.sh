echo  -e "\e[32 >>>>> setup nodejs <<<<< \e[om"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash
echo  -e "\e[32 >>>>> catalogue service <<<<< \e[om"
cp catalogue.repo /etc/systemd/system/catalogue.service
echo  -e "\e[32 >>>>> mango repo file <<<<< \e[om"
cp mango.repo /etc/yum.repos.d/mongo.repo
echo  -e "\e[32 >>>>> install nodejs <<<<< \e[om"
yum install nodejs -y
echo  -e "\e[32 >>>>> application user <<<<< \e[om"
useradd roboshop
echo  -e "\e[32 >>>>> setup app directory <<<<< \e[om"
mkdir /app
echo  -e "\e[32 >>>>> download application <<<<< \e[om"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip
cd /app
unzip /tmp/catalogue.zip
echo  -e "\e[32 >>>>> download dependencies <<<<< \e[om"
cd /app
npm install
echo  -e "\e[32 >>>>> install mangodb <<<<< \e[om"
yum install mongodb-org-shell -y
echo  -e "\e[32 >>>>> replace mangodb <<<<< \e[om"
mongo --host mangodb.sivadevops22.online </app/schema/catalogue.js
echo  -e "\e[32 >>>>> load service <<<<< \e[om"
systemctl daemon-reload
echo  -e "\e[32 >>>>> start the service <<<<< \e[om"
systemctl enable catalogue
systemctl restart catalogue
