my_sql_pasword=$1
if [ -z "${my_sql_pasword}" ];then
  echo input password missing
  exit 1
fi
cp mysql.repo  /etc/yum.repos.d/mysql.repo
yum module disable mysql -y
yum install mysql-community-server -y
systemctl enable mysqld
systemctl restart mysqld
mysql_secure_installation --set-root-pass ${my_sql_pasword}