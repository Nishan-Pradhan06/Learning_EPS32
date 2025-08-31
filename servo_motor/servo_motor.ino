#include <ESP32Servo.h>


Servo myServo;
int ServoPin = 22;

void setup()
{
  myServo.attach(ServoPin);
  // myServo.write(90);
  Serial.begin(115200);
}

void loop()
{
  if(Serial.available())
  {
    int angle = Serial.parseInt();
    myServo.write(angle);
  }
  delay(20);
}