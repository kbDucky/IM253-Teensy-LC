#include <Bounce2.h>

/* Program for Teensy LC for use with game Mario Kart 64 on the Project64 emulator.
 *  Has potentiometers for wheel use and reverse driving, along with touch sensors that 
 *  can be physically wired up to resemble gas/stop/clutch pedals.
 * 
 * Author: Kaylynn Borror
 */

// Potentiometer constants for pin positions
const int kSteeringPotPin = A9;     // digital pin 23
const int kReverSlidePotPin = A8;   // digital pin 22

// Touch sense constants for pin positions
const int kClutchPin = 1;           // drifting movement
const int kBrakePin = 3;            // brake
const int kGasPin = 4;              // gas
const int kItemPin = 2;             // item use

const int kTouchThreshold = 2500;

// Bounce object for a button to be connected to the Teensy
Bounce itemLauncher = Bounce();

void setup() {
  // Set Bounce object for item use
  itemLauncher.attach(kItemPin, INPUT_PULLUP);
}

void loop() {
  itemLauncher.update();

  // Map potentiometer values to a simpler range, in this case
  // between (-50, 50) with 0 in the middle
  int potVal = map(analogRead(kSteeringPotPin), 0, 1203, -50, 50);
  int slideVal = map(analogRead(kReverSlidePotPin), 0, 1203, -50, 50);
  
  // ======================== Gas and Break
  if(touchRead(kGasPin) > kTouchThreshold) {
    // Push the gas
    Keyboard.press(KEY_X);    // default emulator key
  }
  else {
    Keyboard.release(KEY_X);
  }
  
  if(touchRead(kBrakePin) > kTouchThreshold) {
    // Push the brake
    Keyboard.press(KEY_C);    // default emulator key
  }
  else {
    Keyboard.release(KEY_C);
  }
  
  // ======================== Steering left and right
  // Pot is set to take higher values
  // as left and lower values as right
  if(potVal > 25 ) {
    // Turn left
    Keyboard.press(KEY_LEFT);
  }
  else {
    Keyboard.release(KEY_LEFT);
  }
  if(potVal < -25) {
    // Turn right
    Keyboard.press(KEY_RIGHT);
  }
  else {
    Keyboard.release(KEY_RIGHT);
  }

  // ======================== Reverse or Forward
  if(slideVal < 0) {
    // Send player into a reverseable state
    Keyboard.press(KEY_DOWN);
  }
  else {
    // Begin to go or keep going forward
    Keyboard.release(KEY_DOWN);
  }

  // ======================== Checking for drifting
  if(touchRead(kClutchPin) > kTouchThreshold) {
    Keyboard.press(KEY_E);
    }
  else {
    Keyboard.release(KEY_E);
  }

  // ======================== Item button
  if(itemLauncher.fell()) {
    Keyboard.press(KEY_S);    // one of multiple default keys
  }
  if(itemLauncher.rose()) {
   Keyboard.release(KEY_S);
  }
  
}
