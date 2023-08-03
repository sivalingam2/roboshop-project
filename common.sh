nodejs() {
log=/tmp/roboshop-log
echo  -e "\e[32m>>>>> ${component} service <<<<<\e[0m"
cp ${component}.repo /etc/systemd/system/${component}.service &>>${log}
echo  -e "\e[32m>>>>> mango repo file <<<<<\e[0m"
cp mango.repo /etc/yum.repos.d/mongo.repo &>> ${log}
echo  -e "\e[32m>>>>> setup nodejs <<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log}
echo  -e "\e[32m>>>>> install nodejs <<<<<\e[0m"
yum install nodejs -y &>>${log}
echo  -e "\e[32m>>>>> application user <<<<<\e[0m"
useradd roboshop &>>${log}
echo  -e "\e[32m>>>>> setup app directory <<<<<\e[0m"
rm -rf /app &>>${log}
echo  -e "\e[32m>>>>> setup app directory <<<<<\e[0m"
mkdir /app &>>${log}
echo  -e "\e[32m>>>>> download application <<<<<\e[0m"
curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>> ${log}
cd /app &>> ${log}
unzip /tmp/catalogue.zip &>>${log}
echo  -e "\e[32m>>>>> download dependencies <<<<<\e[0m"
cd /app &>>${log}
npm install &>>${log}
echo  -e "\e[32m>>>>> install mangodb <<<<<\e[0m"
yum install mongodb-org-shell -y &>> ${log}
echo  -e "\e[32m>>>>> replace mangodb <<<<<\e[0m"
mongo --host mangodb.sivadevops22.online </app/schema/${component}.js &>>${log}
echo  -e "\e[32m>>>>> load service <<<<<\e[0m"
systemctl daemon-reload &>>${log}
echo  -e "\e[32m>>>>> restart the service <<<<<\e[0m"
systemctl enable ${component} &>>${log}
systemctl restart ${component} &>>${log}
}
