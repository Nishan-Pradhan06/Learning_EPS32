#include <WiFi.h>

const char* ssid = "ESP NISHAN";
const char* password = "12345678";

WiFiServer server(80);

// SENSORS PINS
#define echoPin 2
#define trigPin 4

// SENSOR STATE
bool isUltraSonicSensorEnable = false;

// MAIN PROGRAM
void setup() {
  Serial.begin(115200);

  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);

  WiFi.softAP(ssid, password);
  Serial.println("ESP32 Access Point Started!");
  Serial.println("IP Address:");
  Serial.println(WiFi.softAPIP());

  server.begin();
}

// MEASURE THE DISTANCE
long readUltraSonic() {
  digitalWrite(trigPin, LOW);
  delayMicroseconds(2);

  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);

  long duration = pulseIn(echoPin, HIGH, 30000);
  long distance = duration / 58.2;
  return distance;
}

// HANDLE CLIENTS
void handleClient(WiFiClient client) {
  String req = client.readStringUntil('\r');
  client.flush();

  // Print incoming request for debugging
  Serial.println("===== New Request =====");
  Serial.println(req);

  if (req.indexOf("/ultrasonic/enable") != -1) {
    isUltraSonicSensorEnable = true;
    Serial.println("Ultrasonic Sensor ENABLED");
  }
  if (req.indexOf("/ultrasonic/disable") != -1) {
    isUltraSonicSensorEnable = false;
    Serial.println("Ultrasonic Sensor DISABLED");
  }

  // PREPARE RESPONSE
  String response = "HTTP/1.1 200 OK\r\nContent-Type: application/json\r\n\r\n";
  if (isUltraSonicSensorEnable) {
    long distance = readUltraSonic();
    response += "{\"status\":\"enabled\",\"distance\":" + String(distance) + "}";
  } else {
    response += "{\"status\":\"disabled\"}";
  }

  // Send response to client
  client.print(response);
  client.stop();

  // Print response JSON in Serial Monitor
  Serial.println("Response Sent:");
  Serial.println(response);
  Serial.println("=======================");
}

void loop() {
  WiFiClient client = server.available();
  if (client) {
    handleClient(client);
  }
}



// #include <Wire.h>
// #define echoPin 2               // CHANGE PIN NUMBER HERE IF YOU WANT TO USE A DIFFERENT PIN
// #define trigPin 4               // CHANGE PIN NUMBER HERE IF YOU WANT TO USE A DIFFERENT PIN
// long duration, distance;
// void setup(){
//   Serial.begin (115200);
//   pinMode(trigPin, OUTPUT);
//   pinMode(echoPin, INPUT);
// }
// void loop(){
//   digitalWrite(trigPin, LOW);
//   delayMicroseconds(2);
//   digitalWrite(trigPin, HIGH);
//   delayMicroseconds(10);
//   digitalWrite(trigPin, LOW);

//   duration = pulseIn(echoPin, HIGH);
//   distance = duration / 58.2;
//   String disp = String(distance);

//   Serial.print("Distance: ");
//   Serial.print(disp);
//   Serial.println(" cm");
//   delay(1000);
// }