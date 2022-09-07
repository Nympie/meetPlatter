#include <ESP8266HTTPClient.h>
#include <ESP8266WiFi.h>
#include <ArduinoJson.h>
#include <SoftwareSerial.h>


SoftwareSerial nodemcu(D6, D5);

void setup() {

  WiFi.begin("U+Net0A7D", "1C1B032653");   
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.println("Waiting for connection");
  }
  
  Serial.begin(9600);
  Serial1.begin(9600);
  nodemcu.begin(9600);
  while (!Serial) continue;
}

void loop() {

  WiFiClient client;
  HTTPClient http;
  StaticJsonBuffer<3000> jsonBuffer;
  JsonObject& data = jsonBuffer.parseObject(nodemcu);

  if (data == JsonObject::invalid()) {
    jsonBuffer.clear();
    return;
  }
 
  float humi = data["humidity"];
  float temp = data["temperature"];
  float CO2 = data["co2"];
  float lux = data["light"];
  
  if (WiFi.status() == WL_CONNECTED) {
 
    StaticJsonBuffer<3000> JSONbuffer;   //Declaring static JSON buffer
    JsonObject& JSONencoder = JSONbuffer.createObject(); 
 
    JsonArray& AirHumi = JSONencoder.createNestedArray("AirHumi");
    AirHumi.add(String(humi));
    JsonArray& AirTemp = JSONencoder.createNestedArray("AirTemp");
    AirTemp.add(String(temp));
    JsonArray& Co2 = JSONencoder.createNestedArray("Co2"); 
    Co2.add(String(CO2)); 
    JsonArray& LUX = JSONencoder.createNestedArray("LUX"); 
    LUX.add(String(lux)); 

    char JSONmessageBuffer[5000];
    JSONencoder.prettyPrintTo(JSONmessageBuffer, sizeof(JSONmessageBuffer));
    Serial.println(JSONmessageBuffer);


 
    http.begin(client, "http://192.168.123.181:9090/monitoringAir");
    http.addHeader("Content-Type", "application/json");

    int httpCode = http.POST(JSONmessageBuffer);
    String payload = http.getString();
     
    Serial.println(httpCode);
    Serial.println(payload);

    http.end();


    
    http.begin(client, "http://192.168.123.181:9090/motor_control");
    int httpCode2 = http.GET(); 
    if (httpCode2 > 0) {
      String data = http.getString();
      if (data == "b'cool'"){
        data = 'c';
      } else if (data == "b'heat'"){
        data = 'h';
      }
      nodemcu.print(data);
      delay(2500);
    }
    else Serial.println("An error ocurred");

    http.end();
 
  } 
  else {
    Serial.println("Error in WiFi connection");
  }

}
