#include <OneWire.h>
#include <DallasTemperature.h>

#include <StaticThreadController.h>
#include <ThreadController.h>
#include <Thread.h>

#include <SoftwareSerial.h>
#include <ArduinoJson.h>

#define ONE_WIRE_BUS 12
#define sen0205 A2
float WTemp;
int WLevel;
float voltage;

SoftwareSerial nodemcu(5, 6);

OneWire oneWire(ONE_WIRE_BUS);
DallasTemperature sensors(&oneWire);

ThreadController controll = ThreadController();

Thread DS18Thread = Thread();
Thread SEN0205Thread = Thread();
Thread pHThread = Thread();
Thread JsonThread = Thread();


ThreadController groupOfThreads = ThreadController();

void DS18()
{
  sensors.requestTemperatures(); 
  float WTemp = sensors.getTempCByIndex(0); 
  Serial.print("Water temperature: ");
  Serial.println(WTemp);

}


void SEN0205()
{
  int WLevel = analogRead(sen0205);
  Serial.print("Water Level: ");
  Serial.println(WLevel);
}

void pH()
{
  int sensorValue = analogRead(A0);
  voltage = sensorValue * (5.0 / 1023.0);
  Serial.print("voltage : ");
  Serial.println(voltage);
}


void Json()
{
  StaticJsonBuffer<5000> jsonBuffer;
  JsonObject& data = jsonBuffer.createObject();
  
  data["waterTemp"] = sensors.getTempCByIndex(0);
  data["waterLevel"] = analogRead(sen0205);
  data["voltage"] = voltage; 
  
  data.printTo(nodemcu);
  jsonBuffer.clear();

}


void setup()
{
  Serial.begin(9600);
  pinMode(sen0205, INPUT);
  sensors.begin();
  Serial.println(F("Starting..."));

  nodemcu.begin(9600);

  DS18Thread.onRun(DS18);
  DS18Thread.setInterval(2500);
  
  SEN0205Thread.onRun(SEN0205);
  SEN0205Thread.setInterval(2500);

  pHThread.onRun(pH);
  pHThread.setInterval(2500);

  JsonThread.onRun(Json);
  JsonThread.setInterval(2500);

  controll.add(&DS18Thread);

  groupOfThreads.add(&SEN0205Thread);
  groupOfThreads.add(&pHThread);
  groupOfThreads.add(&JsonThread);
  
  controll.add(&groupOfThreads);

}

void loop()
{
  
  controll.run();

  float h = 3.1415;
  h/=2;

}
