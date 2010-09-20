var _draw, _xcHandleMouseDown, _xcHandleMouseMoved, _xcHandleMouseUp, oldX, oldY, sprites, tapDown, xc, xc_init;
sprites = [];
oldX = 0;
oldY = 0;
tapDown = false;
_draw = function(node) {
  var _a, _b, _c, _d, child;
  if (node.visible) {
    if (node.drawable) {
      node.draw(context);
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
xc_init = function() {
  var clear, date, fps, previousTime, update;
  window.canvas = document.getElementById('gameCanvas');
  window.context = canvas.getContext('2d');
  $(canvas).mousedown(_xcHandleMouseDown);
  $(canvas).mousemove(_xcHandleMouseMoved);
  $(canvas).mouseup(_xcHandleMouseUp);
  onLoad();
  date = new Date();
  previousTime = date.getTime();
  update = function() {
    var currentScene, currentTime, delta;
    currentTime = new Date().getTime();
    delta = currentTime - previousTime;
    previousTime = currentTime;
    currentScene = xc.getCurrentScene();
    currentScene.update(delta);
    clear();
    return xc.draw(currentScene);
  };
  clear = function() {
    return context.clearRect(0, 0, 640, 480);
  };
  fps = 60;
  return setInterval(update, 1000 / fps);
};
xc = new xc();
xc_init();