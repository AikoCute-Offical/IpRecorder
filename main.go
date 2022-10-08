package main

import (
	"IpRecorder/bot"
	"IpRecorder/conf"
	"IpRecorder/cron"
	"IpRecorder/data"
	"IpRecorder/http"
	"flag"
	"fmt"
	"log"
)

var path = flag.String("path", "./config.json", "config file path")

var (
	version  = "0.0.5"
	codename = "IpRecorder"
	intro    = "Backend For AikoR"
)

func showVersion() {
	fmt.Printf("%s %s (%s) \n", codename, version, intro)
}

func main() {
	flag.Parse()
	config, err := conf.New(*path)
	if err != nil {
		log.Fatalln("Init config obj error: ", err)
	}
	err = config.LoadConfig()
	if err != nil {
		log.Fatalln("Load config error: ", err)
	}
	dataObj := data.New(config.OnlineIpLimit)
	go func() {
		err := http.NewHttp(config, dataObj).Start()
		if err != nil {
			log.Fatalln("Start http service error: ", err)
		}
	}()
	botObj, err := bot.New(config)
	if err != nil {
		log.Fatalln("Init bot service error: ", err)
	}
	cronObj, err := cron.New(dataObj, botObj, config)
	if err != nil {
		log.Fatalln("Init cron error: ", err)
	}
	err = cronObj.Start()
	if err != nil {
		log.Fatalln("Start cron error: ", err)
	}
}
