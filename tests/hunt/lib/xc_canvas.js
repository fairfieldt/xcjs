var _xcDraw, _xcHandleKeyDown, _xcHandleKeyUp, _xcHandleMouseDown, _xcHandleMouseMoved, _xcHandleMouseUp, _xcLoadSprite, _xcLoadText, _xcNodeAnchorX, _xcNodeAnchorY, _xcNodeColor, _xcNodeOpacity, _xcNodeRotation, _xcNodeScaleX, _xcNodeScaleY, _xcNodeSetAnchorX, _xcNodeSetAnchorY, _xcNodeSetColor, _xcNodeSetOpacity, _xcNodeSetRotation, _xcNodeSetScaleX, _xcNodeSetScaleY, _xcNodeSetX, _xcNodeSetY, _xcNodeX, _xcNodeY, _xcSpriteDraw, _xcTextDraw, _xcTextNodeText, _xcTextSetText, oldX, oldY, sprites, tapDown, xc, xc_init;
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
  var _i, _len, _ref, child;
  if (node.visible) {
    context.save();
    if (node.drawable) {
      node.draw();
    }
    _ref = node.children;
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      child = _ref[_i];
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
  return node._x;
};
_xcNodeY = function(node) {
  return node._y;
};
_xcNodeSetX = function(node, newX) {
  return (node._x = newX);
};
_xcNodeSetY = function(node, newY) {
  return (node._y = newY);
};
_xcNodeColor = function(node) {
  return node._color;
};
_xcNodeSetColor = function(node, newColor) {
  return (node._color = newColor);
};
_xcNodeScaleX = function(node) {
  return node._scaleX;
};
_xcNodeScaleY = function(node) {
  return node._scaleY;
};
_xcNodeSetScaleX = function(node, newScaleX) {
  return (node._scaleX = newScaleX);
};
_xcNodeSetScaleY = function(node, newScaleY) {
  return (node._scaleY = newScaleY);
};
_xcNodeRotation = function(node) {
  return node._rotation;
};
_xcNodeSetRotation = function(node, newRotation) {
  return (node._rotation = newRotation);
};
_xcNodeOpacity = function(node) {
  return node._opacity;
};
_xcNodeSetOpacity = function(node, newOpacity) {
  return (node._opacity = newOpacity);
};
_xcNodeAnchorX = function(node) {
  return node._anchorX;
};
_xcNodeAnchorY = function(node) {
  return node._anchorY;
};
_xcNodeSetAnchorX = function(node, newAnchorX) {
  return (node._anchorX = newAnchorX);
};
_xcNodeSetAnchorY = function(node, newAnchorY) {
  return (node._anchorY = newAnchorY);
};
_xcTextNodeText = function(node) {
  return node._text;
};
_xcTextSetText = function(node, newText) {
  return (node._text = newText);
};
_xcSpriteDraw = function(node) {
  context.translate(node.X() - (node.X() * node.anchorX()), node.Y() - (node.Y() * node.anchorY()));
  context.rotate(node.rotation() * Math.PI / 180);
  context.globalAlpha = node.opacity();
  return context.drawImage(node.sprite, 0, 0, node.width, node.height, 0, 0, node.width * node.scaleX(), node.height * node.scaleY());
};
_xcTextDraw = function(node) {
  node.font = node.fontSize + "pt " + node.fontName;
  context.font = node.font;
  context.translate(node.X() - (node.X() * node.anchorX()), node.Y() - (node.Y() * node.anchorY()));
  context.rotate(node.rotation() * Math.PI / 180);
  context.scale(node.scaleX(), node.scaleY());
  context.globalAlpha = node.opacity();
  return context.fillText(node.text(), 0, 0);
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
    var _i, _len, _ref, action, currentScene, currentTime, delta;
    currentTime = new Date().getTime();
    delta = (currentTime - previousTime) / 1000;
    previousTime = currentTime;
    currentScene = xc.getCurrentScene();
    _ref = xc.actions;
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      action = _ref[_i];
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
$(xc = new xc(), xc_init());