var console, gcCounter, handleKeyDown, handleKeyUp, handleMouseDown, handleMouseMoved, handleMouseUp, oldX, oldY, sprites, tapDown, xc, xc_init, xc_update, _xcSpriteDraw, _xcTextDraw;
sprites = [];
oldX = 0;
oldY = 0;
tapDown = false;
gcCounter = 0;
_xcSpriteDraw = function(node) {};
_xcTextDraw = function(node) {};
handleMouseDown = function(event) {
  var e, x, y;
  x = event.x;
  y = event.y;
  tapDown = true;
  e = new XCTapDownEvent(x, y, 0);
  return xc.dispatchEvent(e);
};
handleMouseUp = function(event) {
  var e, x, y;
  tapDown = false;
  x = event.x;
  y = event.y;
  e = new XCTapUpEvent(x, y, 0);
  return xc.dispatchEvent(e);
};
handleMouseMoved = function(event) {
  var e, moveX, moveY, x, y;
  if (tapDown) {
    x = event.x;
    y = event.y;
    moveX = event.moveX;
    moveY = event.moveY;
    e = new XCTapMovedEvent(x, y, moveX, moveY, 0);
    return xc.dispatchEvent(e);
  }
};
handleKeyDown = function(event) {};
handleKeyUp = function(event) {};
xc_init = function() {
  var date, previousTime;
  xc_print("xc_init called");
  console.log = xc_print;
  main();
  date = new Date();
  return previousTime = date.getTime();
};
xc_update = function(delta) {
  var currentScene, tapEvent;
  currentScene = xc.getCurrentScene();
  tapEvent = xc_get_tap();
  while (tapEvent !== null) {
    if (tapEvent.name === 'tapDown') {
      handleMouseDown(tapEvent);
    } else if (tapEvent.name === 'tapMoved') {
      handleMouseMoved(tapEvent);
    } else if (tapEvent.name === 'tapUp') {
      handleMouseUp(tapEvent);
    }
    tapEvent = xc_get_tap();
  }
  currentScene.tick(delta);
  if (gcCounter++ > 30) {
    return xc_gc();
  }
};
xc = new XC();
console = [];