source common.sh

echo  -e "\e[32m>>>>> install nginx <<<<<\e[0m"
yum install nginx -y &>> ${log}
exit_status

echo  -e "\e[32m>>>>> default content <<<<<\e[0m"
cp fronted.confi /etc/nginx/default.d/roboshop.conf &>> ${log}
exit_status

echo  -e "\e[32m>>>>> remove the old content <<<<<\e[0m"
rm -rf /usr/share/nginx/html/* &>> ${log}
exit_status

echo  -e "\e[32m>>>>> download the content <<<<<\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>> ${log}
exit_status

cd /usr/share/nginx/html &>> ${log}

echo  -e "\e[32m>>>>> extract application <<<<<\e[0m"
unzip /tmp/frontend.zip &>> ${log}
exit_status

echo  -e "\e[32m>>>>> restart the service <<<<<\e[0m"
systemctl enable nginx &>> ${log}
systemctl restart nginx &>> ${log}
exit_status
