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
  
  // Initialize Serial port
  Serial.begin(9600);
  nodemcu.begin(9600);
  while (!Serial) continue;
}

void loop() {

  StaticJsonBuffer<3000> jsonBuffer;
  JsonObject& data = jsonBuffer.parseObject(nodemcu);

  if (data == JsonObject::invalid()) {
    jsonBuffer.clear();
    return;
  }
 
  float WTemp = data["waterTemp"];
  Serial.print("Water Temperature : ");
  Serial.println(WTemp);
  
  float WLevel = data["waterLevel"];
  Serial.print("Water Level : ");
  Serial.println(WLevel);

  float voltage = data["voltage"];
  float ph = voltage * 14.0/5.0;
  Serial.print("Voltage : ");
  Serial.println(voltage);
  Serial.print("Water pH : ");
  Serial.println(ph);

  WiFiClient client;
  
  if (WiFi.status() == WL_CONNECTED) { 
 
    StaticJsonBuffer<3000> JSONbuffer;   
    JsonObject& JSONencoder = JSONbuffer.createObject(); 
 
    JsonArray& waterTemp = JSONencoder.createNestedArray("waterTemp"); 
    waterTemp.add(String(WTemp)); 

    JsonArray& waterLevel = JSONencoder.createNestedArray("waterLevel"); 
    waterLevel.add(String(WLevel)); 

    JsonArray& pH = JSONencoder.createNestedArray("pH"); //JSON array
    pH.add(String(ph)); 


 
    char JSONmessageBuffer[5000];
    JSONencoder.prettyPrintTo(JSONmessageBuffer, sizeof(JSONmessageBuffer));
    Serial.println(JSONmessageBuffer);
 
    HTTPClient http; 
 
    http.begin(client, "http://192.168.123.181:9090/monitoringWater");
    http.addHeader("Content-Type", "application/json");
 
    int httpCode = http.POST(JSONmessageBuffer);
    String payload = http.getString();
 
    Serial.println(httpCode);
    Serial.println(payload);
 
    http.end();
 
  } else {
    Serial.println("Error in WiFi connection");
  }
}
