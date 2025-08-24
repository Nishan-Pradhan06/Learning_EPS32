#include <WiFi.h>

const char* ssid = "ESP NISHAN";
const char* password = "12345678";

WiFiServer server(80);

// LED pins
const int redLedPin = 23;
const int greenLedPin = 22;

// LED states
bool redLedState = false;
bool greenLedState = false;
bool blinkMode = false;

void setup() {
  Serial.begin(115200);

  pinMode(redLedPin, OUTPUT);
  pinMode(greenLedPin, OUTPUT);

  WiFi.softAP(ssid, password);
  Serial.println("ESP32 Access Point Started!");
  Serial.print("IP Address: ");
  Serial.println(WiFi.softAPIP());

  server.begin();
}

void loop() {
  WiFiClient client = server.available();
  if (client) handleClient(client);

  if (blinkMode) {
    digitalWrite(redLedPin, !redLedState);
    digitalWrite(greenLedPin, !greenLedState);
    redLedState = !redLedState;
    greenLedState = !greenLedState;
    delay(500);
  }
}

void handleClient(WiFiClient client) {
  String req = client.readStringUntil('\r');
  Serial.println(req);

  if (req.indexOf("/led/on") != -1) {
    blinkMode = false;
    setRed(true);
    setGreen(true);
    sendResponse(client, "Both LEDs ON");
  } 
  else if (req.indexOf("/led/red") != -1) {
    blinkMode = false;
    setRed(true);
    setGreen(false);
    sendResponse(client, "Red LED ON");
  } 
  else if (req.indexOf("/led/green") != -1) {
    blinkMode = false;
    setRed(false);
    setGreen(true);
    sendResponse(client, "Green LED ON");
  } 
  else if (req.indexOf("/led/blink") != -1) {
    blinkMode = true;
    redLedState = true;
    greenLedState = true;
    sendResponse(client, "Both LEDs BLINKING");
  } 
  else {
    sendResponse(client, "Unknown command");
  }

  client.stop();
}

// Simple functions to control LEDs
void setRed(bool state) {
  redLedState = state;
  digitalWrite(redLedPin, state ? HIGH : LOW);
}

void setGreen(bool state) {
  greenLedState = state;
  digitalWrite(greenLedPin, state ? HIGH : LOW);
}

// Send HTML response
void sendResponse(WiFiClient client, String msg) {
  client.println("HTTP/1.1 200 OK");
  client.println("Content-Type: text/html");
  client.println("Connection: close");
  client.println();
  client.println("<html><body>");
  client.println("<h1>" + msg + "</h1>");
  client.println("<a href=\"/led/on\">Both LEDs ON</a><br>");
  client.println("<a href=\"/led/red\">Red LED ON</a><br>");
  client.println("<a href=\"/led/green\">Green LED ON</a><br>");
  client.println("<a href=\"/led/blink\">Blink Both LEDs</a><br>");
  client.println("</body></html>");
}


// #include <WiFi.h>

// const char* ssid = "ESP NISHAN";
// const char* password = "12345678";


// int ledPin = 23;

// WiFiServer server(80);

// int blinkDelay = (500);
// bool ledState = false;


// void setup() {
//   Serial.begin(115200);
//   pinMode(ledPin, OUTPUT);


//   //wifi access point

//   WiFi.softAP(ssid, password);
//   Serial.println("ESP32 Access point Started!");
//   Serial.print("IP Address: ");
//   Serial.println(WiFi.softAPIP());

//   server.begin();
// }

// void loop() {
//   WiFiClient client = server.available();

//   if (client) {
//     String request = client.readStringUntil('\r');
//     Serial.println(request);

//     if (request.indexOf("/led/on") != -1) {
//       ledState = true;
//       digitalWrite(ledPin, HIGH);
//     } else {
//       ledState = false;
//       digitalWrite(ledPin, LOW);
//     }

//     client.println("HTTP/1.1 200 OK");
//     client.println("Content-Type: text/html");
//     client.println("Connection: close");
//     client.println();
//     client.println("LED UPDATED!!!");
//     client.stop();

//   }
// }

// void handleGreenLight()
// {

// }
