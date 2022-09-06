#!/bin/bash

rm -rf $0

red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
plain='\033[0m'

cur_dir=$(pwd)

# check root
[[ $EUID -ne 0 ]] && echo -e "${red}Error：${plain} This script must be run as root user!\n" && exit 1

# check os
if [[ -f /etc/redhat-release ]]; then
    release="centos"
elif cat /etc/issue | grep -Eqi "debian"; then
    release="debian"
elif cat /etc/issue | grep -Eqi "ubuntu"; then
    release="ubuntu"
elif cat /etc/issue | grep -Eqi "centos|red hat|redhat"; then
    release="centos"
elif cat /proc/version | grep -Eqi "debian"; then
    release="debian"
elif cat /proc/version | grep -Eqi "ubuntu"; then
    release="ubuntu"
elif cat /proc/version | grep -Eqi "centos|red hat|redhat"; then
    release="centos"
else
    echo -e "${red}System version not detected, please contact script author!${plain}\n" && exit 1
fi

arch=$(arch)

if [[ $arch == "x86_64" || $arch == "x64" || $arch == "amd64" ]]; then
  arch="64"
elif [[ $arch == "aarch64" || $arch == "arm64" ]]; then
  arch="arm64-v8a"
else
  arch="64"
  echo -e "${red}No schema detected, use default schema: ${arch}${plain}"
fi

echo "Architecture System: ${arch}"

if [ "$(getconf WORD_BIT)" != '32' ] && [ "$(getconf LONG_BIT)" != '64' ] ; then
    echo "This software does not support 32-bit (x86) system, please use 64-bit (x86_64) system, if found wrong, please contact the author"
    exit 2
fi

os_version=""

# os version
if [[ -f /etc/os-release ]]; then
    os_version=$(awk -F'[= ."]' '/VERSION_ID/{print $3}' /etc/os-release)
fi
if [[ -z "$os_version" && -f /etc/lsb-release ]]; then
    os_version=$(awk -F'[= ."]+' '/DISTRIB_RELEASE/{print $2}' /etc/lsb-release)
fi

if [[ x"${release}" == x"centos" ]]; then
    if [[ ${os_version} -le 6 ]]; then
        echo -e "${red}Please use CentOS 7 or later!${plain}\n" && exit 1
    fi
elif [[ x"${release}" == x"ubuntu" ]]; then
    if [[ ${os_version} -lt 16 ]]; then
        echo -e "${red}Please use Ubuntu 16 or higher!${plain}\n" && exit 1
    fi
elif [[ x"${release}" == x"debian" ]]; then
    if [[ ${os_version} -lt 8 ]]; then
        echo -e "${red}Please use Debian 8 or later!${plain}\n" && exit 1
    fi
fi


install_iprecorder() {
    if [[ -e /usr/local/iprecorder/ ]]; then
        rm /usr/local/iprecorder/ -rf
    fi

    mkdir /usr/local/iprecorder/ -p
	cd /usr/local/iprecorder/
    
    if  [ $# == 0 ] ;then
        last_version=$(curl -Ls "https://api.github.com/repos/AikoCute-Offical/iprecorder/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
        if [[ ! -n "$last_version" ]]; then
            echo -e "${red}iprecorder version detection failed, maybe GIthub API limit exceeded, please try again later or specify iprecorder version setting manually${plain}"
            exit 1
        fi
        echo -e "The latest version of iprecorder has been detected：${last_version}，Start the installation"
        wget -N --no-check-certificate -O /usr/local/iprecorder/iprecorder-linux.zip https://github.com/AikoCute-Offical/iprecorder/releases/download/${last_version}/iprecorder-linux-${arch}.zip
        if [[ $? -ne 0 ]]; then
            echo -e "${red}iprecorder download failed, make sure your server can download Github files${plain}"
            exit 1
        fi
    else
        last_version=$1
        url="https://github.com/AikoCute-Offical/iprecorder/releases/download/${last_version}/iprecorder-linux-${arch}.zip"
        echo -e "iprecorder starts up v$1"
        wget -N --no-check-certificate -O /usr/local/iprecorder/iprecorder-linux.zip ${url}
        if [[ $? -ne 0 ]]; then
            echo -e "${red}Download iprecorder v$1 Failed, make sure this version exists${plain}"
            exit 1
        fi
    fi

    unzip iprecorder-linux.zip
    rm iprecorder-linux.zip -f
    mkdir /etc/iprecorder/ -p
    echo -e "${green}iprecorder ${last_version}${plain} The installation is complete, it is already set to start automatically"

    if [[ ! -f /etc/iprecorder/config.json ]]; then
        cp config.json /etc/iprecorder/
    fi

    if [[ ! -f /etc/iprecorder/IP2LOCATION-LITE-DB3.BIN ]]; then
        cp IP2LOCATION-LITE-DB3.BIN /etc/iprecorder/
    fi

    
    echo -e ""
    echo " How to use the iprecorder . management script " 
    echo "------------------------------------------"
    echo "           iprecorder   - Show admin menu      "
    echo "               iprecorder by AikoCute          "
    echo "------------------------------------------"
}

install_iprecorder