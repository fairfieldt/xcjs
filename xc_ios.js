var _draw, _xcHandleKeyDown, _xcHandleKeyUp, _xcHandleMouseDown, _xcHandleMouseMoved, _xcHandleMouseUp, _xcLoadSprite, _xcNodeAnchorX, _xcNodeAnchorY, _xcNodeColor, _xcNodeOpacity, _xcNodeRotation, _xcNodeScaleX, _xcNodeScaleY, _xcNodeX, _xcNodeY, _xcSpriteDraw, _xcTextDraw, console, oldX, oldY, sprites, tapDown, xc, xc_init, xc_update;
sprites = [];
oldX = 0;
oldY = 0;
tapDown = false;
_xcLoadSprite = function(imageName) {
  return xc_load_sprite(imageName, 0);
};
_draw = function(node) {
  var _i, _len, _ref, _result, child;
  if (node.drawable) {
    node.draw();
  }
  _result = []; _ref = node.children;
  for (_i = 0, _len = _ref.length; _i < _len; _i++) {
    child = _ref[_i];
    _result.push(_draw(child));
  }
  return _result;
};
_xcHandleMouseDown = function(event) {
  var e, x, y;
  x = event.pageX - canvas.offsetLeft;
  y = event.pageY - canvas.offsetTop;
  oldX = x;
  oldY = y;
  tapDown = true;
  e = new XCTapDownEvent(x, y, 0);
  return xc.dispatchEvent(e);
};
_xcHandleMouseUp = function(event) {
  var e, x, y;
  tapDown = false;
  x = event.pageX - canvas.offsetLeft;
  y = event.pageY - canvas.offsetTop;
  e = new XCTapUpEvent(x, y, 0);
  return xc.dispatchEvent(e);
};
_xcHandleMouseMoved = function(event) {
  var e, moveX, moveY, x, y;
  if (tapDown) {
    x = event.pageX - canvas.offsetLeft;
    y = event.pageY - canvas.offsetTop;
    moveX = x - oldX;
    moveY = y - oldY;
    oldX = x;
    oldY = y;
    e = new XCTapMovedEvent(x, y, moveX, moveY, 0);
    return xc.dispatchEvent(e);
  }
};
_xcHandleKeyDown = function(event) {
  var e, key;
  key = event.which;
  e = new XCKeyDownEvent(key);
  return xc.dispatchEvent(e);
};
_xcHandleKeyUp = function(event) {
  var e, key;
  key = event.which;
  e = new XCKeyUpEvent(key);
  return xc.dispatchEvent(e);
};
_xcNodeX = function(node) {
  return node.X;
};
_xcNodeY = function(node) {
  return node.y;
};
_xcNodeColor = function(node) {
  return node.color;
};
_xcNodeScaleX = function(node) {
  return node.scaleX;
};
_xcNodeScaleY = function(node) {
  return node.scaleY;
};
_xcNodeRotation = function(node) {
  return node.rotation;
};
_xcNodeOpacity = function(node) {
  return node.opacity;
};
_xcNodeAnchorX = function(node) {
  return node.anchorX;
};
_xcNodeAnchorY = function(node) {
  return node.anchorY;
};
_xcSpriteDraw = function(node) {
  return xc_update_sprite(node.sprite, node.x, node.y, node.scaleX, node.scaleY, node.rotation, node.opacity, node.anchorX, node.anchorY);
};
_xcTextDraw = function(node) {};
xc_init = function() {
  var date, previousTime;
  xc_print("xc_init called");
  console.log = function(text) {
    return xc_print(text);
  };
  onLoad();
  date = new Date();
  return (previousTime = date.getTime());
};
xc_update = function(delta) {
  var currentScene;
  currentScene = xc.getCurrentScene();
  currentScene.update(delta);
  xc.draw(currentScene);
  return xc_gc();
};
xc = new xc();
console = [];