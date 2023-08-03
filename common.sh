echo  -e "\e[32m>>>>> ${component} service <<<<<\e[0m"
cp ${component}.repo /etc/systemd/system/${component}.service &>> /tmp/roboshop-log
echo  -e "\e[32m>>>>> mango repo file <<<<<\e[0m"
cp mango.repo /etc/yum.repos.d/mongo.repo &>> /tmp/roboshop-log
echo  -e "\e[32m>>>>> setup nodejs <<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>> /tmp/roboshop-log
echo  -e "\e[32m>>>>> install nodejs <<<<<\e[0m"
yum install nodejs -y &>> /tmp/roboshop-log
echo  -e "\e[32m>>>>> application user <<<<<\e[0m"
useradd roboshop &>> /tmp/roboshop-log
echo  -e "\e[32m>>>>> setup app directory <<<<<\e[0m"
mkdir /app &>> /tmp/roboshop-log
echo  -e "\e[32m>>>>> download application <<<<<\e[0m"
curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>> /tmp/roboshop-log
cd /app &>> /tmp/roboshop-log
unzip /tmp/catalogue.zip &>> /tmp/roboshop-log
echo  -e "\e[32m>>>>> download dependencies <<<<<\e[0m"
cd /app &>> /tmp/roboshop-log
npm install &>> /tmp/roboshop-log
echo  -e "\e[32m>>>>> install mangodb <<<<<\e[0m"
yum install mongodb-org-shell -y &>> /tmp/roboshop-log
echo  -e "\e[32m>>>>> replace mangodb <<<<<\e[0m"
mongo --host mangodb.sivadevops22.online </app/schema/${component}.js &>> /tmp/roboshop-log
echo  -e "\e[32m>>>>> load service <<<<<\e[0m"
systemctl daemon-reload &>> /tmp/roboshop-log
echo  -e "\e[32m>>>>> restart the service <<<<<\e[0m"
systemctl enable ${component} &>> /tmp/roboshop-log
systemctl restart ${component} &>> /tmp/roboshop-log
