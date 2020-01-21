
/* Program for Teensy LC for use on Autodesk Sketchbook on full-screen with color editor set open
    and uses touch sensors for the pins associated with rotating around the color wheel in
    fourths, both clockwise and counterclockwise.
    Also has a pin dedicated to applying chosen color to canvas in 'fill' mode

    Author: Kaylynn Borror
*/


// Pin variables
const int gbTouchPin = 1;
const int brTouchPin = 3;
const int ryTouchPin = 4;
const int ygTouchPin = 23;
const int bgTouchPin = 22;
const int gyTouchPin = 19;
const int yrTouchPin = 18;
const int rbTouchPin = 17;

const int paintTouchPin = 16;

// Pressure threshold for determining if surface is touched or not
const int touchThreshould = 1500;


void setup() {
  Mouse.screenSize(1920, 1080);  // configure screen size
}

void loop() {

  // ======================================================== CounterClockwise Movements
  // ================================ Green To Blue
  colorWheelMovement(gbTouchPin, 1720, 400, 2, 4, 2, 2, 2, 0);

  // ================================ Blue To Red
  colorWheelMovement(brTouchPin, 1800, 480, 4, -2, 2, -2, 0, -2);

  // ================================ Red To Yellow
  colorWheelMovement(ryTouchPin, 1880, 400, -2, -4, -2, -2, -2, 0);

  // ================================ Yellow To Green
  colorWheelMovement(ygTouchPin, 1800, 320, -4, 2, -2, 2, 0, 2);


  // ======================================================== Clockwise Movements
  // ================================ Blue To Green
  colorWheelMovement(bgTouchPin, 1800, 480, -4, -2, -2, -2, 0, -2);

  // ================================ Green To Yellow
  colorWheelMovement(gyTouchPin, 1720, 400, 2, -4, 2, -2, 2, 0);

  // ================================ Yellow To Red
  colorWheelMovement(yrTouchPin, 1800, 320, 4, 2, 2, 2, 0, 2);

  // ================================ Red To Blue
  colorWheelMovement(rbTouchPin, 1880, 400, -2, 4, -2, 2, -2, 0);


  // 1 second delay to keep color wheel from constantly resetting to beginning position
  delay(1000);


  //====================================================== Touch to Paint
  // Make sure 'Fill' is selected on Autodesk Sketchbook, or else this will just put a dot of color on canvas
  if (touchRead(paintTouchPin) > touchThreshould) {
    Mouse.moveTo(1000, 500);
    Mouse.click();
  }
}

/* Function for movement along the color wheel
    touchPin = pin on teensy for action
    xLocation and yLocation = x and y coordinate on the window for the mouse to point to
    x1, y1, x2, y2, x3, y3 are the x and y coordinates of the three seperate movements for the quarter circle
    of the color wheel
*/
void colorWheelMovement(int touchPin, int xLocation, int yLocation, int x1, int y1, int x2, int y2, int x3, int y3) {
  if (touchRead(touchPin) > touchThreshould) {
    Mouse.moveTo(xLocation, yLocation);
    Mouse.press();

    // First movement
    for (int i = 0; i < 10; i++) {
      Mouse.move(x1, y1);
      delay(50);
      // if the touchpin was released
      if (touchRead(touchPin) < touchThreshould) {
        Mouse.release();
        break;
      }
    }
    
    // Second movement
    for (int i = 0; i < 20; i++) {
      Mouse.move(x2, y2);
      delay(50);
      // if the touch pin was released
      if (touchRead(touchPin) < touchThreshould) {
        Mouse.release();
        break;
      }
    }
    
    // Third movement
    for (int i = 0; i < 15; i++) {
      Mouse.move(x3, y3);
      delay(50);
      //if the touch pin was released
      if (touchRead(touchPin) < touchThreshould) {
        Mouse.release();
        break;
      }
    }
    
    // if all movements have been completed, stop at the end
    Mouse.release();
  }
}
