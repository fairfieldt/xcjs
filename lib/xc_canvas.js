var _xcDraw, _xcHandleKeyDown, _xcHandleKeyUp, _xcHandleMouseDown, _xcHandleMouseMoved, _xcHandleMouseUp, _xcImageHeight, _xcImageWidth, _xcLoadSprite, _xcLoadText, _xcSpriteDraw, _xcTextDraw, itemLoaded, oldX, oldY, sprites, tapDown, xc, xc_init;
sprites = [];
oldX = 0;
oldY = 0;
tapDown = false;
_xcLoadSprite = function(imageName) {
  var _i, _len, _ref, endsWith, image, sprite;
  sprite = null;
  endsWith = new RegExp('/' + imageName + '$');
  _ref = document.images;
  for (_i = 0, _len = _ref.length; _i < _len; _i++) {
    image = _ref[_i];
    if (image.src.match(endsWith)) {
      sprite = image;
    }
  }
  return sprite;
};
_xcImageWidth = function(sprite) {
  return sprite.width;
};
_xcImageHeight = function(sprite) {
  return sprite.height;
};
_xcLoadText = function(node) {
  return null;
};
_xcDraw = function(node) {
  if (node.visible()) {
    context.save();
    node.draw();
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
_xcSpriteDraw = function(node) {
  context.translate(node.X() - (node.width() * node.anchorX()), node.Y() - (node.height() * node.anchorY()));
  context.rotate(node.rotation() * Math.PI / 180);
  context.globalAlpha = node.opacity();
  return context.drawImage(node.sprite, 0, 0, node.width(), node.height(), 0, 0, node.width() * node.scaleX(), node.height() * node.scaleY());
};
_xcTextDraw = function(node) {
  node.font = node.fontSize + "pt " + node.fontName;
  context.font = node.font;
  context.translate(node.X(), node.Y());
  context.rotate(node.rotation() * Math.PI / 180);
  context.scale(node.scaleX(), node.scaleY());
  context.globalAlpha = node.opacity();
  return context.fillText(node.text(), 0, 0);
};
itemLoaded = function(item) {
  console.log('item loaded!');
  if (--itemsToLoad <= 0) {
    console.log('all items loaded');
    return xc_init();
  }
};
xc_init = function() {
  var clear, date, fps, previousTime, update, wasPaused;
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
  wasPaused = false;
  update = function() {
    var _i, _len, _ref, _result, child, currentScene, currentTime, delta;
    currentTime = new Date().getTime();
    delta = (currentTime - previousTime) / 1000;
    previousTime = currentTime;
    currentScene = xc.getCurrentScene();
    if (currentScene.paused()) {
      wasPaused = true;
      return null;
    } else {
      if (wasPaused) {
        delta = 0;
        wasPaused = false;
      }
      currentScene.tick(delta);
      clear();
      _result = []; _ref = currentScene.children();
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        child = _ref[_i];
        _result.push(_xcDraw(child));
      }
      return _result;
    }
  };
  clear = function() {
    return context.clearRect(0, 0, 640, 480);
  };
  fps = 60;
  return setInterval(update, 1000 / fps);
};
$(xc = new xc());