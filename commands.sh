yum install nginx
nginx -V 2>&1 | grep -o with-http_stub_status_module
systemctl start nginx
systemctl enable nginx


vim /etc/nginx/nginx.conf

   location /nginx_status {
        stub_status;
        allow all ;
        }
save and exit 

103.150.30.161/stub_status  // search this in the web browser it will show curresponding output if the module is enabled and vice versa

mkdir -p /home/a.com/public_html 
mkdir -p /home/a.com/public_html

echo "hello hello this is a.com" /home/a.com/public_html/index.html
echo "hello hello this is b.com " /home/b.com/public_html/index.html

vim /etc/nginx/conf.d/a.com.conf

server {
        listen 80;
        listen [::]:80;

        root /home/a.com/public_html;
        index index.html index.htm index.nginx-debian.html;

        server_name a.com;

        location / {
                try_files $uri $uri/ =404;
        }

    access_log /var/log/nginx/a.com.access.log;
    error_log /var/log/nginx/a.com.error.log;

}

save and exit

vim /etc/nginx/conf.d/b.com.conf


server {
        listen 80;
        listen [::]:80;

        root /home/b.com/public_html;
        index index.html index.htm index.nginx-debian.html;

        server_name b.com;

        location / {
                try_files $uri $uri/ =404;
        }

    access_log /var/log/nginx/b.com.access.log;
    error_log /var/log/nginx/b.com.error.log;

}
~      


save and exit

nginx -t
nginx -s reload
systemctl restart nginx

//configuring gzip

vim /etc/nginx/nginx.conf

gzip on;
gzip_vary on;
gzip_min_length 1;
gzip_proxied expired no-cache no-store private auth;
gzip_types text/plain text/css text/xml text/javascript application/x-javascript application/xml;
gzip_disable "MSIE [1-6]\.";

//add the above  in the httpd function module

save and exit

nginx -t

systemctl restart nginx

yum install php56 // xcache only supports till php 5.6

yum install php56-php-fpm

systemctl start php56-php-fpm


yum install php56-php-xcache.x86_64
yum install php56-xcache-admin.noarch​

vim /opt/remi/php56/root/etc/php.ini
extension=xcache.so



vim /etc/nginx/conf.d/a.com.conf

server {
        listen 80;
        listen [::]:80;

        root /home/a.com/public_html;
        index index.html index.htm index.nginx-debian.html;

        server_name a.com;

        location / {
                try_files $uri $uri/ =404;
        }
        location ~ \.php$ {
    fastcgi_pass 127.0.0.1:9000;
    fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    include fastcgi_params;
}

    access_log /var/log/nginx/a.com.access.log;
    error_log /var/log/nginx/a.com.error.log;
}

save and exit



vim /etc/nginx/conf.d/b.com

server {
        listen 80;
        listen [::]:80;

        root /home/b.com/public_html;
        index index.html index.htm index.nginx-debian.html;

        server_name b.com;

        location / {
                try_files $uri $uri/ =404;
        }
        location ~ \.php$ {
    fastcgi_pass 127.0.0.1:9000;
    fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    include fastcgi_params;
}

    access_log /var/log/nginx/b.com.access.log;
    error_log /var/log/nginx/b.com.error.log;

}


systemctl restart php56-php-fpm

nginx -t
nginx -s reload
systemctl restart nginx


NOTE : please make sure that you make necessary changes in /etc/hosts and /etc/host.conf file before accessing the websites





