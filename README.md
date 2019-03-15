# openvdocker

Anbindung einer Viessmann Heizung über eine Optolinkschnittstelle.

Es wird der vcontrold Server mit dem vclient zur Verfügung gestellt. Optional können die Werte in einem einstellbarem Intervall über Mqtt gepublisht werden.

Das Image wurde für den TWS2XXX der Firma [ElabNET](https://forum.timberwolf.io) auf Basis von Debian Stretch erstellt.
Die Konfiguration erfolgt über Portainer um den Dienst so einfach wie möglich zur Verfügung zu stellen.

Wer mich etwas unterstützen möchte:

[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://paypal.me/murelli146?locale.x=de_DE)


# Installation über Portainer

## Volume erstellen:
Name: vcontrold-conf > "Create the Volume" drücken.

## Container erstellen:
```
Name: knxdmxdocker
Image: murelli146/knxdmxdocker
Port mapping: host 3002 -> container 3002 TCP
> "Deploy the Container"
```
## Container einstellen
```
Command > Console: none
Volumes mapping > container: /etc/vcontrold -> volume: vcontrold-conf
Env >
    IPMQTTBROKER    192.168.179.45       IP vom Mqtt Broker (z.B. mosquitto)
    PORTMQTTBROKER  1883                 Port vom Mqtt Broker
    MQTTTOPIC       Vitoplus_300         Topic Name (Ergebnis: z.B. Vitoplus_300/getTempA)
    MQTT            true                 Mqtt Option aktivieren oder deaktivieren
    MQTTPUB         30                   Zeit in Sekunden wie oft die Werte gepublisht werden (! Abfrageintervall)
Restart policy > value: always
> "Deploy the Container"
```

# Konfiguration

Alle relevanten Dateien sind im /etc/vcontrold Ordner.

Um auf die Dateien zu zugreifen, verwendet man am besten den [SSH Container](https://forum.timberwolf.io/app.php/kb/viewarticle?a=70 )

### vcontrold.xml und vito.xml
Diese zwei Files müssen an die jeweilige Heizungstype angepasst werden. 
Die Informationen bekommt man über das [openv Wiki](https://github.com/openv/openv/wiki)
Für die Konfiguration dieser Dateien kann hier kein Support erfolgen.

Nun ist der vcontrold Server einsatzbereit und man kann über telnet (IP_vom_Host:3002) auf die vclient prompt zugreifen.

Ist die Option Mqtt aktiviert muss man noch volgende Einstellungen vornehmen.

### 1_mqtt_commands.txt
Befehlsliste die Abgerufen werden. 
Die Zeilennummer entspricht der Variablen Nummer im Template (2_mqtt.tmpl)

z.B. Zeilennummer 3 entspricht im Template den Variablen $C3 (Befehlsname) und $3 (Wert)

`3 getTempWWist`

### 2_mqtt.tmpl
Hier wird eingestellt welche Werte veröffentlicht werden sollen.

z.B. Zeile 3 (getTempWWist) der Befehlsliste

`mosquitto_pub -h $IPMQTTBROKER -p $PORTMQTTBROKER -t $MQTTTOPIC/$C3 -m $3`

Zur Veranschaulichung, diese Zeile sieht letztlich beim Abfragen wie folgt aus:

`mosquitto_pub -h 192.168.179.45 -p 1883 -t Vitoplus_300/getTempWWist -m 60.00000`

## ToDo
Werte sollen zukünftig über mqtt auch gesetzt werden können.


## Image über git erstellen

```
git clone https://github.com/murelli146/openvdocker.git
cd openvdocker
docker build -t openvdocker .

```
