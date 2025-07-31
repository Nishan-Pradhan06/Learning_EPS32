#include <WiFi.h>
#include <WebServer.h>

const char* ssid = "MyESP32AP";
const char* password = "ESP32pass";

WebServer server(80);

void handleRoot() {
  server.send(200, "text/html", "<h1>ESP32 AP Web Server</h1><p>You are connected!</p>");
}

void setup() {
  Serial.begin(115200);

  WiFi.softAP(ssid, password, 6);
  Serial.print("Access Point IP: ");
  Serial.println(WiFi.softAPIP());
  Serial.print("WiFi AP channel: ");
  Serial.println(WiFi.channel());

  server.on("/", handleRoot);
  server.begin();
  Serial.println("HTTP server started");
}

void loop() {
  server.handleClient();
}
