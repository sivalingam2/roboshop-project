curl -sL https://rpm.nodesource.com/setup_lts.x | bash
cp cart.repo /etc/systemd/system/cart.service
yum install nodejs -y
useradd roboshop
mkdir /app
curl -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip
cd /app
unzip /tmp/user.zip
cd /app
npm install
systemctl daemon-reload
systemctl enable cart
systemctl restart cart
