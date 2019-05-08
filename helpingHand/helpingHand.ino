/**
 * Arduino code for the "Helping Hand" for Teensy LC
 * 
 * Has the ability to change between the computer's languages and switch between
 * Hiragana, Katakana, and English for the Japanese language.
 * Also has options for Microsoft Word 2016 on Windows 10 to select font size and
 * set Microsoft Word document to traditional "essay format" (Times New Roman font,
 * Font size 12, Double Spacing w/o space after)
 * 
 * Author: Kaylynn Borror     Date: 22-04-2019
 * Demo found at following link : https://www.youtube.com/
 */

#include <Bounce2.h>

// Clarify Teensy pins for button/touch use
int middleFing = 19;
int indexFing = 13;
int languagePin = 0;
int fontPin = 1;
int essayPin = 4;

// Make indexFinger and MiddleFinger act as a button
Bounce* middleFinger;
Bounce* indexFinger;

// Determine which touch pad option has been activated
bool lang = false;
bool font = false;
bool essay = false;

bool hiragana = false;

// Fill in to the settings of your machine -- my machine has 3 languages active on it =============================================================================FIX
//int numberOfLang = 3;

// Determines whether the interaction has just occured, or is running on repeat and
// doesn't need to be activated again
double ticks = 0;

int touchThreshold = 1500;

void setup() {
  Mouse.screenSize(1920, 1080);
  
  middleFinger = new Bounce();
  middleFinger->attach(middleFing, INPUT_PULLUP);
  indexFinger = new Bounce();
  indexFinger->attach(indexFing, INPUT_PULLUP);

}

void loop() {
  //================================================ Update the Bounce Buttons
  middleFinger->update();
  indexFinger->update();

  //================================================ Check touchPad and set booleans
  if(touchRead(languagePin) > touchThreshold && ticks >= 60) {
    ticks = 0;
    lang = true;
    font = false;
    essay = false;
  }
  else if(touchRead(fontPin) > touchThreshold && ticks >= 60) {
    ticks = 0;
    font = true;
    lang = false;
    essay = false;
  }
  else if(touchRead(essayPin) > touchThreshold && ticks >= 60) {
    ticks = 0;
    essay = true;
    lang = false;
    font = false;
  }

  //================================================ Set Language details
  if(lang) {
    // if language was just touched, select new language
    if(ticks == 0) {
      Keyboard.press(MODIFIERKEY_GUI);
      Keyboard.press(KEY_SPACE);
      Keyboard.release(MODIFIERKEY_GUI);
      Keyboard.release(KEY_SPACE);
    }
    
    // Select Hiragana/English with index finger
    if(indexFinger->fell() && hiragana == false) {
      hiragana = true;
      Keyboard.press(MODIFIERKEY_CTRL);
      Keyboard.press(KEY_CAPS_LOCK);
      Keyboard.release(MODIFIERKEY_CTRL);
      Keyboard.release(KEY_CAPS_LOCK);
    }
    else if (indexFinger->fell() && hiragana == true) {
      hiragana = false;
      Keyboard.press(MODIFIERKEY_SHIFT);
      Keyboard.press(KEY_CAPS_LOCK);
      Keyboard.release(MODIFIERKEY_SHIFT);
      Keyboard.release(KEY_CAPS_LOCK);
    }
    // Select Katakana with middle finger
    if(middleFinger->fell()) {
      Keyboard.press(MODIFIERKEY_ALT);
      Keyboard.press(KEY_CAPS_LOCK);
      Keyboard.release(MODIFIERKEY_ALT);
      Keyboard.release(KEY_CAPS_LOCK);
    }
  }
  //================================================ Set Font details
  else if(font) {
    Mouse.moveTo(360, 100);
    delay(200);
    Mouse.click();
    font = false;
  }
  //================================================ Set Essay details
  else if(essay) {
    // Set Times New Roman
    Mouse.moveTo(335, 100);
    Mouse.click();
    Mouse.moveTo(335, 310);
    delay(300);
    Mouse.move(10, 0);
    delay(300);
    Mouse.click();
    
    // Set font size 12
    Mouse.moveTo(360, 100);
    delay(200);
    Mouse.click();
    delay(200);
    Keyboard.press(KEY_1);
    Keyboard.release(KEY_1);
    Keyboard.press(KEY_2);
    Keyboard.release(KEY_2);

    // Set double spaceing w/o added spacing after
    Mouse.moveTo(790, 140);
    delay(200);
    Mouse.click();
    Mouse.click();
    Mouse.moveTo(790, 250);
    delay(300);
    Mouse.move(10, 0);
    delay(300);
    Mouse.click();

    Mouse.moveTo(790, 140);
    delay(200);
    Mouse.click();
    delay(200);
    Mouse.moveTo(790, 390);
    delay(200);
    Mouse.click();

    essay = false;
  }

  ticks += 1;

}
