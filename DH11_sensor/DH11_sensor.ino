// #include <Arduino.h>
#include "DHT.h"


#define DHT_DATA_PIN 5
#define DHTTYPE DHT11

DHT dht (DHT_DATA_PIN,DHTTYPE);

void setup()
{
  Serial.begin(115200);
  Serial.println("DHT11 with esp32");
  dht.begin();
}

void loop()
{
  delay(2000);

  float h =dht.readHumidity();
  float t = dht.readTemperature();

  if(isnan(h) || isnan(t))
  {
    Serial.println("Failed to read from DH11 sensor! Check writing");
    return ;
  }
  Serial.printf("Humidity: %.1f%% | Temperature: %.1f °C\n", h, t);
}