# docker-zentao

禅道 Docker 镜像，镜像里不含数据库服务，在禅道安装时填写外部或宿主机的数据库服务。

- Linux 宿主机的数据库 IP 默认为 ``172.17.0.1``，宿主机执行``ifconfig``查看``docker0``的 IP 地址。
- macOS 宿主机的数据库地址默认为 ``host.docker.internal``，参考[Docker for Mac Stable release notes](https://docs.docker.com/docker-for-mac/release-notes/)。

可挂载目录  
/app/zentaopms:该目录为禅道目录，里面包含禅道代码及附件上传目录。

首次运行容器后，浏览器访问``http://IP:端口``，如果界面显示禅道安装界面，说明容器运行正常。  
依照安装程序，最后将禅道安装成功，就可以使用禅道了。

docker-compose 方式启动

```bash
docker-compose pull
# 后台启动
docker-compose up -d
# 停止
docker-compose down
```

docker 启动

```bash
docker run --name zentao --restart=always -p 80:80 -v ~/docker/zentao/www:/app/zentaopms -d jefferlau/zentao:without-db
```


