

// int ledPin = 2; // onboarad LED on GPIO23

// void setup() {
//   pinMode(ledPin, OUTPUT);
// }

// void loop() {
//   digitalWrite(ledPin, HIGH); // LED ON
//   delay(1000);                 // wait half second
//   digitalWrite(ledPin, LOW);  // LED OFF
//   delay(1000);                 // wait half second
// }

int ledPin = 23; // external LED on GPIO23

void setup() {
  pinMode(ledPin, OUTPUT);
}

void loop() {
  digitalWrite(ledPin, HIGH); // LED ON
  delay(1000);                 // wait half second
  digitalWrite(ledPin, LOW);  // LED OFF
  delay(1000);                 // wait half second
}
