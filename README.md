![image](https://github.com/user-attachments/assets/28fda70d-63e1-4692-85fc-e9bf559611a5)
自用 留底

    
    sed -i 's/^.*PermitRootLogin.*/PermitRootLogin yes/g' /etc/ssh/sshd_config
    
    sed -i 's/^.*PasswordAuthentication.*/PasswordAuthentication yes/g' /etc/ssh/sshd_config
    
    
    service ssh restart

    
