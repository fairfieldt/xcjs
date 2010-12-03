/*
Copyright 2010 Tom Fairfield. All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are
permitted provided that the following conditions are met:

   1. Redistributions of source code must retain the above copyright notice, this list of
      conditions and the following disclaimer.

   2. Redistributions in binary form must reproduce the above copyright notice, this list
      of conditions and the following disclaimer in the documentation and/or other materials
      provided with the distribution.

THIS SOFTWARE IS PROVIDED BY TOM FAIRFIELD ``AS IS'' AND ANY EXPRESS OR IMPLIED
WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> OR
CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

The views and conclusions contained in the software and documentation are those of the
authors and should not be interpreted as representing official policies, either expressed
or implied, of Tom Fairfield.
*/var XCCompat, handleKeyDown, handleKeyUp, handleMouseDown, handleMouseMoved, handleMouseUp, itemLoaded, oldX, oldY, tapDown, xc, xc_init, _xcImageHeight, _xcImageWidth, _xcLoadImage, _xcLoadText, _xcNodeAnchorX, _xcNodeAnchorY, _xcNodeColor, _xcNodeHeight, _xcNodeLayer, _xcNodeOpacity, _xcNodeRotation, _xcNodeScaleX, _xcNodeScaleY, _xcNodeSetAnchorX, _xcNodeSetAnchorY, _xcNodeSetColor, _xcNodeSetLayer, _xcNodeSetOpacity, _xcNodeSetRotation, _xcNodeSetScaleX, _xcNodeSetScaleY, _xcNodeSetVisible, _xcNodeSetX, _xcNodeSetY, _xcNodeVisible, _xcNodeWidth, _xcNodeX, _xcNodeY, _xcSpriteDraw, _xcSpriteFrame, _xcSpriteFrameHeight, _xcSpriteFrameWidth, _xcSpriteSetFrame, _xcTextDraw, _xcTextNodeHeight, _xcTextNodeText, _xcTextNodeWidth, _xcTextSetText;
oldX = 0;
oldY = 0;
tapDown = false;
XCCompat = function() {
  function XCCompat() {}
  return XCCompat;
}();
_xcNodeWidth = function(node) {
  return node._width * node._scaleX;
};
_xcNodeHeight = function(node) {
  return node._height * node._scaleY;
};
_xcTextNodeWidth = function(node) {
  var width;
  context.save();
  context.font = node.font;
  width = context.measureText(node._text).width;
  context.restore();
  return node.scaleX() * width;
};
_xcTextNodeHeight = function(node) {
  var height;
  context.save();
  context.font = node.font;
  height = context.measureText('e').width;
  context.restore();
  return node.scaleY() * height;
};
_xcNodeX = function(node) {
  return node._x;
};
_xcNodeY = function(node) {
  return node._y;
};
_xcNodeSetX = function(node, newX) {
  return node._x = newX;
};
_xcNodeSetY = function(node, newY) {
  return node._y = newY;
};
_xcNodeLayer = function(node) {
  return node._layer;
};
_xcNodeSetLayer = function(node, newLayer) {
  return node._layer = newLayer;
};
_xcNodeColor = function(node) {
  return node._color;
};
_xcNodeSetColor = function(node, newColor) {
  return node._color = newColor;
};
_xcNodeScaleX = function(node) {
  return node._scaleX;
};
_xcNodeScaleY = function(node) {
  return node._scaleY;
};
_xcNodeSetScaleX = function(node, newScaleX) {
  return node._scaleX = newScaleX;
};
_xcNodeSetScaleY = function(node, newScaleY) {
  return node._scaleY = newScaleY;
};
_xcNodeRotation = function(node) {
  return node._rotation;
};
_xcNodeSetRotation = function(node, newRotation) {
  while (newRotation > 360) {
    newRotation = newRotation - 360;
  }
  while (newRotation < 0) {
    newRotation = 360 + newRotation;
  }
  return node._rotation = newRotation;
};
_xcNodeOpacity = function(node) {
  return node._opacity;
};
_xcNodeSetOpacity = function(node, newOpacity) {
  if (newOpacity < 0) {
    newOpacity = 0;
  } else if (newOpacity > 1.0) {
    newOpacity = 1.0;
  }
  return node._opacity = newOpacity;
};
_xcNodeAnchorX = function(node) {
  return node._anchorX;
};
_xcNodeAnchorY = function(node) {
  return node._anchorY;
};
_xcNodeSetAnchorX = function(node, newAnchorX) {
  return node._anchorX = newAnchorX;
};
_xcNodeSetAnchorY = function(node, newAnchorY) {
  return node._anchorY = newAnchorY;
};
_xcNodeVisible = function(node) {
  return node._visible;
};
_xcNodeSetVisible = function(node, visible) {
  return node._visible = visible;
};
_xcTextNodeText = function(node) {
  return node._text;
};
_xcTextSetText = function(node, newText) {
  return node._text = newText;
};
_xcSpriteFrameHeight = function(node) {
  if (node._frameHeight) {
    return node._frameHeight;
  } else {
    return node.sprite.height;
  }
};
_xcSpriteFrameWidth = function(node) {
  if (node._frameWidth != null) {
    return node._frameWidth;
  } else {
    return node.sprite.width;
  }
};
_xcSpriteFrame = function(node) {
  return node._frame;
};
_xcSpriteSetFrame = function(node, newFrame) {
  return node._frame = newFrame;
};
_xcLoadImage = function(imageName) {
  var endsWith, image, _i, _len, _ref;
  endsWith = new RegExp('/' + imageName + '$');
  _ref = document.images;
  for (_i = 0, _len = _ref.length; _i < _len; _i++) {
    image = _ref[_i];
    if (image.src.match(endsWith)) {
      return image;
    }
  }
  return image;
};
_xcImageWidth = function(node) {
  return node.sprite.width;
};
_xcImageHeight = function(node) {
  return node.sprite.height;
};
_xcLoadText = function(node) {
  return null;
};
_xcSpriteDraw = function(node) {
  var frameHeight, frameWidth, height, offsetX, offsetY, w, width;
  context.translate(node.X(), node.Y());
  context.rotate(node.rotation() * Math.PI / 180);
  context.globalAlpha = node.opacity();
  if (node instanceof XCSpriteNode) {
    w = 0;
  } else {
    w = node.frame() * (node.frameWidth() + node._padding);
  }
  frameWidth = node.frameWidth();
  frameHeight = node.frameHeight();
  width = node.width();
  height = node.height();
  offsetX = 0 - (node.width() * node.anchorX());
  offsetY = 0 - (node.height() * node.anchorY());
  return context.drawImage(node.sprite, w, 0, frameWidth, frameHeight, offsetX, offsetY, width, height);
};
_xcTextDraw = function(node) {
  var color, fillStyle;
  node.font = node.fontSize + "pt " + node.fontName;
  context.font = node.font;
  color = node.color();
  fillStyle = 'rgb(' + color.r + ',' + color.g + ',' + color.b + ')';
  context.fillStyle = fillStyle;
  context.translate(node.X(), node.Y());
  context.rotate(node.rotation() * Math.PI / 180);
  context.scale(node.scaleX(), node.scaleY());
  context.globalAlpha = node.opacity();
  return context.fillText(node.text(), 0 - (node.width() * node.anchorX() / node.scaleX()), node.height() * node.anchorY() / node.scaleY());
};
handleMouseDown = function(event) {
  var e, x, y;
  x = event.pageX - canvas.offsetLeft;
  y = event.pageY - canvas.offsetTop;
  oldX = x;
  oldY = y;
  tapDown = true;
  e = new XCTapDownEvent(x, y, 0);
  return xc.dispatchEvent(e);
};
handleMouseUp = function(event) {
  var e, x, y;
  if (tapDown) {
    tapDown = false;
    x = event.pageX - canvas.offsetLeft;
    y = event.pageY - canvas.offsetTop;
    if (x > canvasWidth) {
      x = canvasWidth;
    }
    if (x < 0) {
      x = 0;
    }
    if (y > canvasHeight) {
      x = canvasHeight;
    }
    if (y < 0) {
      y = 0;
    }
    e = new XCTapUpEvent(x, y, 0);
    return xc.dispatchEvent(e);
  }
};
handleMouseMoved = function(event) {
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
handleKeyDown = function(event) {
  var e, key;
  key = event.which;
  e = new XCKeyDownEvent(key);
  return xc.dispatchEvent(e);
};
handleKeyUp = function(event) {
  var e, key;
  key = event.which;
  e = new XCKeyUpEvent(key);
  return xc.dispatchEvent(e);
};
itemLoaded = function(item) {
  if (--itemsToLoad <= 0) {
    return xc_init();
  }
};
xc_init = function() {
  var previousTime, update, wasPaused;
  window.canvas = document.getElementById('xcCanvas');
  window.context = canvas.getContext('2d');
  $(canvas).mousedown(handleMouseDown);
  $(canvas).mousemove(handleMouseMoved);
  $(document).mouseup(handleMouseUp);
  $(document).keydown(handleKeyDown);
  $(document).keyup(handleKeyUp);
  main();
  previousTime = (new Date()).getTime();
  wasPaused = false;
  update = function() {
    var child, currentScene, currentTime, delta, _i, _len, _ref, _results;
    currentTime = new Date().getTime();
    delta = (currentTime - previousTime) / 1000;
    previousTime = currentTime;
    currentScene = xc.getCurrentScene();
    if (currentScene.paused()) {
      wasPaused = true;
      return;
    } else {
      if (wasPaused) {
        delta = 0;
        wasPaused = false;
      }
      currentScene.tick(delta);
      context.clearRect(0, 0, canvasWidth, canvasHeight);
      _ref = currentScene.children();
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        child = _ref[_i];
        _results.push(child.visible() ? (context.save(), child.draw(), context.restore()) : void 0);
      }
      return _results;
    }
  };
  return setInterval(update, 1000 / 60);
};
$(xc = new XC());