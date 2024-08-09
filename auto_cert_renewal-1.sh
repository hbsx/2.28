# ����֤��洢Ŀ¼
certs_directory="/etc/letsencrypt/live/"

days_before_expiry=5  # ������֤�鵽��ǰ���촥����ǩ

# ��������֤���ļ�
for cert_dir in $certs_directory*; do
    # ��ȡ����
    domain=$(basename "$cert_dir")

    # ���� README Ŀ¼
    if [ "$domain" = "README" ]; then
        continue
    fi

    # ������ڼ���֤����Ϣ
    echo "���֤��������ڣ� ${domain}"

    # ��ȡfullchain.pem�ļ�·��
    cert_file="${cert_dir}/fullchain.pem"

    # ��ȡ֤���������
    expiration_date=$(openssl x509 -enddate -noout -in "${cert_file}" | cut -d "=" -f 2-)

    # ���֤���������
    echo "�������ڣ� ${expiration_date}"

    # ������ת��Ϊʱ���
    expiration_timestamp=$(date -d "${expiration_date}" +%s)
    current_timestamp=$(date +%s)

    # ���������ڻ��м���
    days_until_expiry=$(( ($expiration_timestamp - $current_timestamp) / 86400 ))

    # ����Ƿ���Ҫ��ǩ����������ǩ����������£�
    if [ $days_until_expiry -le $days_before_expiry ]; then
        echo "֤�齫��${days_before_expiry}���ڹ��ڣ����ڽ����Զ���ǩ��"

        # ֹͣ Nginx
        docker stop npm_app_1

        iptables -P INPUT ACCEPT
        iptables -P FORWARD ACCEPT
        iptables -P OUTPUT ACCEPT
        iptables -F
    
        ip6tables -P INPUT ACCEPT
        ip6tables -P FORWARD ACCEPT
        ip6tables -P OUTPUT ACCEPT
        ip6tables -F

        # ��ǩ֤��
        certbot certonly --standalone -d $domain --email your@email.com --agree-tos --no-eff-email --force-renewal

        # ���� Nginx
        docker start npm_app_1

        echo "֤���ѳɹ���ǩ��"
    else
        # ��δ������ǩ�����������֤����Ȼ��Ч
        echo "֤����Ȼ��Ч��������ڻ��� ${days_until_expiry} �졣"
    fi

    # ����ָ���
    echo "--------------------------"
done