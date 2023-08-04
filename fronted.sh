source common.sh
echo  -e "\e[32m>>>>> install nginx <<<<<\e[0m"
yum install nginx -y
exit_status
echo  -e "\e[32m>>>>> default content <<<<<\e[0m"
cp fronted.confi /etc/nginx/default.d/roboshop.conf
echo  -e "\e[32m>>>>> remove the old content <<<<<\e[0m"
exit_status
rm -rf /usr/share/nginx/html/*
exit_status
echo  -e "\e[32m>>>>> download the content <<<<<\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip
cd /usr/share/nginx/html
echo  -e "\e[32m>>>>> extract application <<<<<\e[0m"
unzip /tmp/frontend.zip
exit_status
echo  -e "\e[32m>>>>> restart the service <<<<<\e[0m"
systemctl enable nginx
systemctl restart nginx
exit_status
