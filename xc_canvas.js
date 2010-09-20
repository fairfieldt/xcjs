var _draw, _xcHandleMouseDown, _xcHandleMouseMoved, _xcHandleMouseUp, oldX, oldY, sprites, tapDown;
sprites = [];
oldX = 0;
oldY = 0;
tapDown = false;
_draw = function(node) {
  var _a, _b, _c, _d, child;
  if (node.visible) {
    if (node.sprite) {
      node.sprite.Draw(context);
    }
    _a = []; _c = node.children;
    for (_b = 0, _d = _c.length; _b < _d; _b++) {
      child = _c[_b];
      _a.push(_draw(child));
    }
    return _a;
  }
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