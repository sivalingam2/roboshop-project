log=/tmp/roboshop-log
greet() {
echo  -e "\e[32m>>>>> mango repo file <<<<<\e[0m"
cp mango.repo /etc/yum.repos.d/mongo.repo &>> ${log}
echo  -e "\e[32m>>>>> setup nodejs <<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log}
echo  -e "\e[32m>>>>> install nodejs <<<<<\e[0m"
yum install nodejs -y &>>${log}

 func_apppreq

echo  -e "\e[32m>>>>> download dependencies <<<<<\e[0m"
npm install &>>${log}
func_schema_setup

func_start

}
func_java() {
  echo  -e "\e[32m>>>>> install maven <<<<<\e[0m"
  yum install maven -y &>>${log}

 func_apppreq
 echo  -e "\e[32m>>>>>  build${component} service <<<<<\e[0m"
  mvn clean package &>> ${log}
  mv target/${component}-1.0.jar ${component}.jar &>> ${log}

  func_schema_setup

  func_start
}
func_apppreq(){
  echo  -e "\e[32m>>>>> ${component} service <<<<<\e[0m"
  cp ${component}.service /etc/systemd/system/${component}.service &>>${log}
  echo  -e "\e[32m>>>>> application user <<<<<\e[0m"
  useradd roboshop &>>${log}
  echo  -e "\e[32m>>>>> clean old content <<<<<\e[0m"
  rm -rf /app &>>${log}
  echo  -e "\e[32m>>>>> download application <<<<<\e[0m"
  mkdir /app &>>${log}
  curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>> ${log}
  cd /app &>> ${log}
  unzip /tmp/${component}.zip &>>${log}
  cd /app &>>${log}

}
func_start() {
  echo  -e "\e[32m>>>>> restart ${component} service <<<<<\e[0m"
  systemctl daemon-reload &>>${log}
  systemctl enable ${component} &>>${log}
  systemctl restart ${component} &>>${log}
}
func_python() {
  echo  -e "\e[32m>>>>>  build${component} service <<<<<\e[0m"
  yum install python36 gcc python3-devel -y &>>${log}

func_apppreq

  echo  -e "\e[32m>>>>>  build${component} service <<<<<\e[0m"
  pip3.6 install -r requirements.txt &>>${log}

 func_start
}
func_go() {
  echo  -e "\e[32m>>>>> install golang <<<<<\e[0m"
  yum install golang -y &>>${log}
  func_apppreq
 echo  -e "\e[32m>>>>> download the dependencies & build the software <<<<<\e[0m"
  go mod init ${component}  &>>${log}

  go get &>>${log}
  go build &>>${log}
  func_start
}
func_schema_setup() {
  if [ "${schema_type}" == "mangodb" ]; then
    echo  -e "\e[32m>>>>> install mangodb <<<<<\e[0m"
    yum install mongodb-org-shell -y &>> ${log}
    echo  -e "\e[32m>>>>> load schema mangodb <<<<<\e[0m"
    mongo --host mangodb.sivadevops22.online </app/schema/${component}.js &>>${log}
  fi

   if [ "${schema_type}" == "mysql" ]; then
      echo  -e "\e[32m>>>>>  install mysql client <<<<<\e[0m"
      yum install mysql -y &>> ${log}
      echo  -e "\e[32m>>>>>  load schema service <<<<<\e[0m"
      mysql -h mysql.sivadevops22.online -uroot -pRoboShop@1 < /app/schema/${component}.sql &>> ${log}
  fi
}

