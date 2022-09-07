#include <StaticThreadController.h>
#include <ThreadController.h>
#include <Thread.h>

#include <SoftwareSerial.h>
#include <ArduinoJson.h>
#include <MHZ19.h>
#include <Wire.h>
#include <DHT.h>

#define DHTPIN 9
DHT dht(DHTPIN, DHT22);
float temp;
int hum;
int light;

int motor1pin1 = 11;
int motor1pin2 = 12;
int P = 13;
bool fanning = false;

SoftwareSerial co2sensor(2, 3); //RX, TX
SoftwareSerial nodemcu(5, 6);
MHZ19 mhz(&co2sensor);


ThreadController controll = ThreadController();

Thread DHTThread = Thread();
Thread MHZThread = Thread();
Thread pHThread = Thread();
Thread JsonThread = Thread();
Thread LightThread = Thread();
 
ThreadController groupOfThreads = ThreadController();

void DHT()
{
  hum = dht.readHumidity();
  temp = dht.readTemperature();
  Serial.print("Humidity : ");
  Serial.println(hum);
  Serial.print("Temperature : ");
  Serial.println(temp);

  if (temp >= 28.0){
    fanning = true;
  }
}

void MHZ()
{
  MHZ19_RESULT response = mhz.retrieveData();
  if (response == MHZ19_RESULT_OK)
  {
    Serial.print(F("CO2 : "));
    Serial.println(mhz.getCO2());
  }
  else
  {
    Serial.print(F("Error, code : "));
    Serial.println(response);
  }
}

void Light(){
  light = analogRead(A1);
  Serial.print("Brightness : ");
  Serial.println(light);
}

void Json()
{
  StaticJsonBuffer<9000> jsonBuffer;
  JsonObject& data = jsonBuffer.createObject();
  
  data["co2"] = mhz.getCO2();
  data["humidity"] = hum;
  data["temperature"] = temp; 
  data["light"] = light; 
  
  data.printTo(nodemcu);
  jsonBuffer.clear();

}


void setup()
{
  pinMode(motor1pin1, OUTPUT);
  pinMode(motor1pin2, OUTPUT);
  pinMode(P, OUTPUT);
  
  Serial.begin(9600);
  
  Wire.begin();
  dht.begin();
  nodemcu.begin(9600);
  co2sensor.begin(9600); 

  DHTThread.onRun(DHT);
  DHTThread.setInterval(2500);
  
  MHZThread.onRun(MHZ);
  MHZThread.setInterval(2500);
  
  LightThread.onRun(Light);
  LightThread.setInterval(2500);
  
  JsonThread.onRun(Json);
  JsonThread.setInterval(2500);

  controll.add(&DHTThread);
  
  groupOfThreads.add(&MHZThread);
  groupOfThreads.add(&LightThread);
  groupOfThreads.add(&JsonThread);

  controll.add(&groupOfThreads);

}

void loop()
{
  
  controll.run();

  float h = 3.1415;
  h/=2;
  

  nodemcu.listen();
  if (nodemcu.available() > 0){
    char buf = nodemcu.read();
    if (buf == 'c'){
      Serial.println("COOLING ON");

      analogWrite(P, 255);
      analogWrite(motor1pin1, 255);
      analogWrite(motor1pin2, 0);
      delay(10000);
      analogWrite(motor1pin1, 0);
      
    } 
    
    else if (buf == 'h'){
      Serial.println("HEATING ON");

      analogWrite(P, 255);
      analogWrite(motor1pin1, 255);
      analogWrite(motor1pin2, 0);
      delay(10000);
      analogWrite(motor1pin1, 0);
     
    }
    
    delay(2500);
  }
}
