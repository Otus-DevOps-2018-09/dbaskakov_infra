# dbaskakov_infra
dbaskakov Infra repository

#add in config for use always

alias someinternalhost="ssh -J baskakov@35.207.156.93 baskakov@10.156.0.4"

#connect to someinternalhost

ssh -J baskakov@35.207.156.93 baskakov@10.156.0.4

bastion_IP = 35.207.156.93

someinternalhost_IP = 10.156.0.4

testapp_IP = 35.242.202.117

testapp_port = 9292 

```
gcloud compute instances create reddit-app\
  --boot-disk-size=10GB \
  --image-family ubuntu-1604-lts \
  --image-project=ubuntu-os-cloud \
  --machine-type=g1-small \
  --tags puma-server \
  --restart-on-failure \
  --metadata-from-file startup-script=startup.sh
```

```
 gcloud compute firewall-rules create default-puma-server \
--allow tcp:9292 \
--source-ranges 0.0.0.0/0 \
--target-tags puma-server
```

# Конфигурация Packer

Все файлы конфигурации packer хранятся в каталоге packer.

# Создание базового образа с помощью packer

В файле ubuntu16.json описана конфигурация для создания образа с зависимостями приложения reddit.
После создания виртуальной машины приложение надо установить отдельно c помощью скрипта `scripts/deploy.sh`

```
packer build -var-file variables.json ubuntu16.json
```

# Создания application образа с помощью packer

В файле immutable.json описана конфигурация для создания образа приложения reddit. "Запекается" на основе образа reddit-base.
После создания виртуальной машины приложение уже запущено и работает.
```
packer build -var-file variables1.json immutable.json
```