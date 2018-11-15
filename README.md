# dbaskakov_infra [![Build Status](https://travis-ci.com/Otus-DevOps-2018-09/dbaskakov_infra.svg?branch=master)](https://travis-ci.com/Otus-DevOps-2018-09/dbaskakov_infra)
dbaskakov Infra repository

#HW10 - Ansible-3

 - на основе имеющихся плейбуков созданы две роли app, db
 - имеющееся описание инфраструктуры разделено на два окружения stage и prod
 - почищен рабочий каталог, файлы размещены по правильным папкам
 - установлена и настроена community роль jdauphant.nginx
 - изучена работа с ansible-vault
 - добавлен playbook для создания пользователей
 - модифицирована инфраструктура terraform для открытия 80 порта
 - добавлен вызов роли jdauphant.nginx в плейбук app.yml
 - создано динамическое инвентори для prod/stage окружений
 - настроен TravisCI для контроля инфраструктурного репозитория
 - реализованы проверки packer validate, terraform validate, tflint, ansible-lint
 - добавлен бейдж в README со статусом билда

#HW9 - Ansible-2

Были написаны plabooks, которые осуществляют провижн и деплой

Эти плэйбуки были использованы для запекания образов в пакере

Был добавлен скрипт для динамической генерации inventory файла с gce

Динамическая inventory файла
```
./gce.py --list
```

#HW8 - Ansible

Для указания хостов через json
```
ansible all -m ping -i inventory.json
```

Возьмет файл хостов из конфига
```
ansible all -m ping
```

#add in config for use always

alias someinternalhost="ssh -J baskakov@35.207.156.93 baskakov@10.156.0.4"

#connect to someinternalhost

ssh -J baskakov@35.207.156.93 baskakov@10.156.0.4

bastion_IP = 35.207.156.93

someinternalhost_IP = 10.156.0.4

testapp_IP = 35.205.56.184

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


# HW6 - Terraform

add multiply ssh users

```
metadata {
    ssh-keys = "appuser:${file(var.public_key_path)}appuser1:${file(var.public_key_path)}appuser2:${file(var.public_key_path)}"
  }
```

Если добавить ключ пользователя через веб-морду произойдет configuration drift и терраформ удалит его после terraform apply.

У данного балансировщика нет автомасштабирования+разные базы
