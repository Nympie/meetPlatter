#include <ESP8266WiFi.h>
#include <ESP8266HTTPClient.h>
#include <DHT.h>
#include <WiFiClient.h>
#include <time.h>

#define SERVER_IP "192.168.123.10"  // db서버의 주소
#define DHTPIN 2         // DHT11 센서의 DATA와 연결된 nodemcu의 포트번호
#define DHTTYPE DHT11       // DHT11을 사용함을 명시
#define STASSID "U+Net0A7D"   // WiFi SSID 입력
#define STAPSK  "1C1B032653"   // WiFi 비밀번호 입력

DHT dht(DHTPIN, DHTTYPE);

struct tm *lc;          // 내가 원하는대로 날짜형식 작성을 위해 필요한 구조체

void setup() {
  Serial.begin(115200);
  WiFi.mode(WIFI_STA);
  WiFi.begin(STASSID, STAPSK);
  configTime(-(3600*9), 0, "1.kr.pool.ntp.org"); // 9시간 시차, 서머타임 적용 X

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("");
  Serial.print("WiFi Connected! IP address: ");
  Serial.println(WiFi.localIP());
  
  Serial.println(F("Gather Temperature, Humidity"));
  Serial.println(F("Wait 60 Seconds...\n"));
  dht.begin();
}

String pluszero(int value){     // localtime을 통해 생성된 구조체의 값이 10 미만이면
  String out;           // 한자리 숫자로 나온다. 예를들어 9일이면 09가 아닌
  if(value < 10){         // 9로 나와서 한자리 숫자일 경우 앞에 0을 추가하는
    out.concat("0");        // 작업을 하는 함수이다.
    out.concat(String(value));
    return out;
  }else{
    out = String(value);
    return out;
  }
}

String calcdate(struct tm *t){        // 현재 시간을 DATETIME 형식으로 바꾸어
  String out = String((1900+t->tm_year)); // String 타입으로 return 한다.
  out.concat("-");
  out.concat(pluszero((t->tm_mon)+1));
  out.concat("-");
  out.concat(pluszero(t->tm_mday));
  out.concat(" ");
  out.concat(pluszero(t->tm_hour));
  out.concat(":");
  out.concat(pluszero(t->tm_min));
  out.concat(":");
  out.concat(pluszero(t->tm_sec));
  return out;
}

void loop() {
  
  delay(60000);  // 측정 간 1분간의 지연을 설정한다. 따라서 1분마다 데이터가 축적된다.
  WiFiClient client;
  HTTPClient http;
  
  time_t now = time(nullptr);
  lc = localtime(&now);   // 현재 시간을 localtime을 통한 구조체 설정

  // 온도와 습도값을 읽는데 250ms가 소요된다.
  // 센서가 값을 읽을때 2초의 시간이 소요될것이다.
  float h = dht.readHumidity();
  
  // 섭씨온도값으로 온도를 수집한다. (기본값)
  float t = dht.readTemperature();
  
  //float f = dht.readTemperature(true); // 섭씨온도(oC)가 아닌 화씨온도(oF)사용시
                                         // (isFahrenheit = true) 설정을 해준다.

  // 읽기에 실패하였는지 확인하고 만약 그렇다면 빠르게 탈출한다. (빠른 재시작을 위해)
  if (isnan(h) || isnan(t)) {
    Serial.println(F("Failed to read from DHT sensor!"));
    return;
  }

  // 온도 습도 영역
  Serial.print(F("Humidity: ")); Serial.print(h);
  Serial.print(F("%  Temperature: ")); Serial.print(t);Serial.print(F("°C "));

  // 시간 영역
  Serial.print(F("기준 시간 : "));
  String date = calcdate(lc);
  Serial.println(date);
  Serial.println("");

  if ((WiFi.status() == WL_CONNECTED)) {

    Serial.print("[HTTP] 서버 연결을 시도합니다...\n");
    
    http.begin(client, "http://" SERVER_IP "/insert_post.php");  // 요청을 보낼 URL 입력
    http.addHeader("Content-Type", "application/x-www-form-urlencoded");
    // POST 요청을 할때 전송 방식을 정한다.
    
    Serial.print("[HTTP] 수집한 값의 POST 요청을 시도합니다...\n");
    String POSTBODY = String("Humidity=");
    POSTBODY.concat(String(h));
    POSTBODY.concat(String("&Temperature="));
    POSTBODY.concat(String(t));
    POSTBODY.concat(String("&Time="));
    POSTBODY.concat(String(date));
    int httpCode = http.POST(POSTBODY); // 위에 작성한 URL로 POST 요청을 보낸다.

    if (httpCode > 0) {
      // HTTP 헤더를 전송하고 그에 대한 응답을 핸들링하는 과정
      Serial.printf("[HTTP] 응답 Code : %d\n", httpCode);

      // HTTP 응답 200, 즉 정상응답이면 서버로부터 수신된 응답을 출력한다.
      if (httpCode == HTTP_CODE_OK) {
        const String& payload = http.getString();
        Serial.print("서버로부터 수신된 응답 : ");
        Serial.println(payload);
        Serial.println("");
      }
    } else {    // 에러발생시 에러내용을 출력한다.
      Serial.printf("[HTTP] POST 요청이 실패했습니다. 오류 : %s\n", http.errorToString(httpCode).c_str());
    }

    http.end();
  }
}