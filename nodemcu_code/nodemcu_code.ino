
#include "FirebaseESP8266.h"
#include <ESP8266WiFi.h>

#define FIREBASE_HOST "flutter-iot-f1373.firebaseio.com"
#define FIREBASE_AUTH "wo6h4ujqr52wplaf0w3Vq1vq0840pTLBGUbr2BaW"
#define WIFI_SSID "BRINE SOFTYWARE"
#define WIFI_PASSWORD "8973405088"


FirebaseData firebaseData;
FirebaseJson json;

void printResult(FirebaseData &data);


void setup()
{
  pinMode(D2, OUTPUT);
  digitalWrite(D2, LOW);
  Serial.begin(115200);
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("Connecting to Wi-Fi");
  while (WiFi.status() != WL_CONNECTED)
  {
    Serial.print(".");
    delay(300);
  }
  Serial.println();
  Serial.print("Connected with IP: ");
  Serial.println(WiFi.localIP());
  Serial.println();

  Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);
  Firebase.reconnectWiFi(true);
  firebaseData.setBSSLBufferSize(1024, 1024);
  firebaseData.setResponseSize(1024);
  Firebase.setReadTimeout(firebaseData, 100 * 60);
  Firebase.setwriteSizeLimit(firebaseData, "tiny");
  
}

void loop()
{

  if(Firebase.getBool(firebaseData, "light")){
     Serial.println(firebaseData.boolData());
     digitalWrite(D2,firebaseData.boolData());
  }
  delay(400);
}
