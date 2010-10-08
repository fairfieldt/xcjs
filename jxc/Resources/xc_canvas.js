var _xcDraw, _xcHandleKeyDown, _xcHandleKeyUp, _xcHandleMouseDown, _xcHandleMouseMoved, _xcHandleMouseUp, _xcLoadSprite, _xcLoadText, _xcNodeAnchorX, _xcNodeAnchorY, _xcNodeColor, _xcNodeOpacity, _xcNodeRotation, _xcNodeScaleX, _xcNodeScaleY, _xcNodeX, _xcNodeY, _xcSpriteDraw, _xcTextDraw, oldX, oldY, sprites, tapDown, xc, xc_init;
sprites = [];
oldX = 0;
oldY = 0;
tapDown = false;
_xcLoadSprite = function(imageName) {
  var sprite;
  sprite = new Image();
  sprite.src = imageName;
  return sprite;
};
_xcLoadText = function(node) {
  return null;
};
_xcDraw = function(node) {
  var _a, _b, _c, child;
  if (node.visible) {
    context.save();
    if (node.drawable) {
      node.draw();
    }
    _b = node.children;
    for (_a = 0, _c = _b.length; _a < _c; _a++) {
      child = _b[_a];
      _xcDraw(child);
    }
    return context.restore();
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
  context.translate(node.x - (node.x * node.anchorX), node.y - (node.x * node.anchorY));
  context.rotate(node.rotation * Math.PI / 180);
  context.globalAlpha = node.opacity;
  return context.drawImage(node.sprite, 0, 0, node.width, node.height, 0, 0, node.width * node.scaleX, node.height * node.scaleY);
};
_xcTextDraw = function(node) {
  node.font = node.fontSize + "pt " + node.fontName;
  context.font = node.font;
  context.translate(node.x - (node.x * node.anchorX), node.y - (node.x * node.anchorY));
  context.rotate(node.rotation * Math.PI / 180);
  context.scale(node.scaleX, node.scaleY);
  context.globalAlpha = node.opacity;
  return context.fillText(node.text, 0, 0);
};
xc_init = function() {
  var clear, date, fps, previousTime, update;
  window.canvas = document.getElementById('gameCanvas');
  window.context = canvas.getContext('2d');
  $(canvas).mousedown(_xcHandleMouseDown);
  $(canvas).mousemove(_xcHandleMouseMoved);
  $(canvas).mouseup(_xcHandleMouseUp);
  $(document).keydown(_xcHandleKeyDown);
  $(document).keyup(_xcHandleKeyUp);
  onLoad();
  date = new Date();
  previousTime = date.getTime();
  update = function() {
    var _a, _b, _c, action, currentScene, currentTime, delta;
    currentTime = new Date().getTime();
    delta = (currentTime - previousTime) / 1000;
    previousTime = currentTime;
    currentScene = xc.getCurrentScene();
    _b = xc.actions;
    for (_a = 0, _c = _b.length; _a < _c; _a++) {
      action = _b[_a];
      action.tick(delta);
    }
    clear();
    return _xcDraw(currentScene);
  };
  clear = function() {
    return context.clearRect(0, 0, 640, 480);
  };
  fps = 60;
  return setInterval(update, 1000 / fps);
};
xc = new xc();
xc_init();