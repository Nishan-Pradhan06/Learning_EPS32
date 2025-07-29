#include <WiFi.h>
#include <FirebaseClient.h>

//Wifi connection
const char* ssid = "-1";
const char* password = "9817326306r";

//Firebase Configrations
const char* firebaseHost = "lightcontrol-ff81f-default-rtdb.firebaseio.com";
const char* firebaseAuth = ""; //leaving empty in test mode
FirebaseClient firebase(firebaseHost, firebaseAuth);

const char* path ="/light_status";
const int ledPin = 2;


void setup(){
  Serial.begin(115200);
  pinMode(ledPin,OUTPUT);
  WiFi.begin(ssid,password);

  while (WiFi.status() != WL_CONNECTED){
    delay(500);
    Serial.print(".");
  }
  Serial.print("\nConnected to WiFi");
}

void loop(){
  String value = firebase.getString(path);
  if(value == "true")
  {
    digitalWrite(ledPin,HIGH);
  }
  else{
    digitalWrite(ledPin,LOW);
  }

  delay(2000);
}