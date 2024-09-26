x-ui

    bash <(curl -Ls https://raw.githubusercontent.com/FranzKafkaYu/x-ui/956bf85bbac978d56c0e319c5fac2d6db7df9564/install.sh) 0.3.4.4
    

搭建vision节点申请证书

#三种方式任选其中一种，申请失败则更换方式
#申请证书方式1： 
  
    ~/.acme.sh/acme.sh  --issue -d 你的域名 --standalone -k ec-256 --force --insecure
  
#申请证书方式2： 
        
    ~/.acme.sh/acme.sh --register-account -m "${RANDOM}@chacuo.net" --server buypass --force --insecure && ~/.acme.sh/acme.sh  --issue -d 你的域名 --standalone -k ec-256 --force --insecure --server buypass
        

#申请证书方式3： 
        
    ~/.acme.sh/acme.sh --register-account -m "${RANDOM}@chacuo.net" --server zerossl --force --insecure && ~/.acme.sh/acme.sh  --issue -d 你的域名 --standalone -k ec-256 --force --insecure --server zerossl

#安装证书：
    
    ~/.acme.sh/acme.sh --install-cert -d 你的域名 --ecc --key-file /etc/x-ui/server.key --fullchain-file /etc/x-ui/server.crt


=======================================================================================
    
    mkdir -p /etc/npm
    
    cd /etc/npm
    
    vim docker-compose.yml

    
    version: '3'
    
    services:
      
      app:
        
        image: 'jc21/nginx-proxy-manager:latest'
        
        restart: unless-stopped
        
        ports:
      - '80:80'  # 保持默认即可，不建议修改左侧的80
      - '81:81'  # 冒号左边可以改成自己服务器未被占用的端口
      - '443:443' # 保持默认即可，不建议修改左侧的443
    volumes:
      - ./data:/data # 冒号左边可以改路径，现在是表示把数据存放在在当前文件夹下的 data 文件夹中
      - ./letsencrypt:/etc/letsencrypt  # 冒号左边可以改路径，现在是表示把数据存放在在当前文件夹下的 letsencrypt 文件夹中



按一下 esc，然后 :wq 保存退出，之后

lsof -i:81  #查看 81 端口是否被占用，如果被占用，重新自定义一个端口

-bash: lsof: command not found


apt install lsof  #安装 lsof

cd /root/etc/npm   # 来到 dockercompose 文件所在的文件夹下

docker-compose up -d

http://ip:81

Email:    admin@example.com
Password: changeme

========================================

申请证书

curl https://get.acme.sh | sh

~/.acme.sh/acme.sh --register-account -m xxxx@gmail.com

~/.acme.sh/acme.sh --issue -d s.kejilion.eu.org --standalone



下载证书

~/.acme.sh/acme.sh --installcert -d s.kejilion.eu.org --key-file /home/web/certs/key.pem --fullchain-file /home/web/certs/cert.pem

================================================













