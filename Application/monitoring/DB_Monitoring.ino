#include <ArduinoOTA.h>
#include <DHT.h>
#include <ESP8266WiFi.h>
#include <WiFiClient.h> 
#include <ESP8266WebServer.h>
#include "mainPage.h"

#define DHTPIN 2     
#define DHTTYPE DHT11
DHT dht(DHTPIN, DHTTYPE);

float h = 0.0;
float t = 0.0;

unsigned long preMills =0;
const long interval = 5000;

const char *ssid = "U+Net0A7D";
const char *password = "1C1B032653";

String strTemp, strHumi, myLocalIP;
ESP8266WebServer server(80);        // 기본서버로 설정하면 주소입력창에 포트번호 안적어도 됨
IPAddress myIP;

void setup() 
{
    Serial.begin(115200);
    dht.begin();

    WiFi.begin(ssid, password);   
    while (WiFi.status() != WL_CONNECTED) 
    {
        delay(500);
        Serial.print(".");
    }


    myIP = WiFi.localIP();
    char buf[18];                           // https://gist.github.com/loosak/76019faaefd5409fca67
    sprintf(buf, "%d.%d.%d.%d", myIP[0], myIP[1], myIP[2], myIP[3]);
    myLocalIP = String(buf);

    Serial.println("IP: " + myLocalIP);

    server.on("/", [](){
    String s = (const __FlashStringHelper *)MAIN_page;  // 웹페이지 HTML 불러오기​​​
    strTemp = (String)t;                                // 온습도값을 문자열로 변환
    strHumi = (String)h;
    s.replace("@@TEMP@@", strTemp);                     // 변환된 온습도 수치를 HTML placeholder와 교체
    s.replace("@@HUMI@@", strHumi);  

    server.send(200, "text/html", s);});                   // HTML 코드를 반환     

    server.on("/temperature", [](){
    server.send(200, "text/plain", String(t).c_str());});    

    server.on("/humidity", [](){
    server.send(200, "text/plain", String(h).c_str());});
    
    
    server.onNotFound([]() {
    server.send(404,"text/plain", "404: Not found");});
    server.begin();
    }


void loop() {
    ArduinoOTA.handle();
    server.handleClient();
    delay(0);

    getData();
}

// 설정된 interval 간격마다 온습도 확인 5초마다 읽음
bool getData() {
    unsigned long curMills = millis();
    if (curMills - preMills >= interval)
    {
    preMills = curMills;
    h = dht.readHumidity();         // 상대습도 읽기
    t = dht.readTemperature();      // 섭씨온도 읽기

    // Check if any reads failed and exit early (to try again).
    if (isnan(h) || isnan(t)) 
    {
    Serial.println(F("Failed to read from DHT sensor!"));
    return false;
    }
    }
    return true;
}