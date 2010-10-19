var XCAction, XCColor, XCEvent, XCKeyDownEvent, XCKeyUpEvent, XCMoveAction, XCMoveBy, XCMoveTo, XCNode, XCRotateAction, XCRotateBy, XCRotateTo, XCScaleAction, XCScaleBy, XCScaleTo, XCSceneNode, XCSpriteNode, XCTapDownEvent, XCTapMovedEvent, XCTapUpEvent, XCTextNode, xc;
var __extends = function(child, parent) {
    var ctor = function(){};
    ctor.prototype = parent.prototype;
    child.prototype = new ctor();
    child.prototype.constructor = child;
    if (typeof parent.extended === "function") parent.extended(child);
    child.__super__ = parent.prototype;
  };
xc = function() {
  this.scenes = [];
  this.scenes.push(new XCSceneNode());
  this.actions = [];
  return this;
};
xc.prototype.addEventListener = function(eventName, listener) {
  if (!this[eventName]) {
    this[eventName] = [];
  }
  return this[eventName].push(listener);
};
xc.prototype.dispatchEvent = function(event) {
  var _i, _len, _ref, _result, listener;
  if (typeof (_ref = this[event.name]) !== "undefined" && _ref !== null) {
    _result = []; _ref = this[event.name];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      listener = _ref[_i];
      if (listener[event.name](event)) {
        break;
      }
    }
    return _result;
  }
};
xc.prototype.replaceScene = function(newScene) {
  this.scenes.pop().close();
  return this.scenes.push(newScene);
};
xc.prototype.pushScene = function(scene) {
  return scenes.push(scene);
};
xc.prototype.popScene = function() {
  return this.scenes.pop();
};
xc.prototype.getCurrentScene = function() {
  return this.scenes[this.scenes.length - 1];
};
XCNode = function() {
  this.visible = true;
  this._x = 0;
  this._y = 0;
  this._z = 0;
  this._scaleX = 1.0;
  this._scaleY = 1.0;
  this._rotation = 0.0;
  this._opacity = 1.0;
  this._anchorX = 0.0;
  this._anchorY = 0.0;
  this.setAnchorX(0.0);
  this.setAnchorY(0.0);
  this.parent = null;
  this._color = new XCColor(0, 0, 0);
  this.children = new Array();
  return this;
};
XCNode.prototype.moveBy = function(xOffset, yOffset) {
  this.setX(this.X() + xOffset);
  return this.setY(this.Y() + yOffset);
};
XCNode.prototype.moveTo = function(xPosition, yPosition) {
  this.setX(xPosition);
  return this.setY(yPosition);
};
XCNode.prototype.X = function() {
  return _xcNodeX(this);
};
XCNode.prototype.Y = function() {
  return _xcNodeY(this);
};
XCNode.prototype.setX = function(newX) {
  return _xcNodeSetX(this, newX);
};
XCNode.prototype.setY = function(newY) {
  return _xcNodeSetY(this, newY);
};
XCNode.prototype.color = function() {
  return _xcNodeColor(this);
};
XCNode.prototype.setColor = function(newColor) {
  return _xcNodeSetColor(this, newColor);
};
XCNode.prototype.scaleXBy = function(factor) {
  return this.setScaleX(this.scaleX() * factor);
};
XCNode.prototype.scaleXTo = function(newScale) {
  return this.setScaleX(newScale);
};
XCNode.prototype.setScaleX = function(newScaleX) {
  return _xcNodeSetScaleX(this, newScaleX);
};
XCNode.prototype.scaleYBy = function(factor) {
  return this.setScaleY(this.scaleY() * factor);
};
XCNode.prototype.scaleYTo = function(newScale) {
  return this.setScaleY(newScale);
};
XCNode.prototype.setScaleY = function(newScaleY) {
  return _xcNodeSetScaleY(this, newScaleY);
};
XCNode.prototype.scaleBy = function(factor) {
  this.setScaleX(this.scaleX() * factor);
  return this.setScaleY(this.scaleY() * factor);
};
XCNode.prototype.scaleTo = function(newScale) {
  this.setScaleX(newScale);
  return this.setScaleY(newScale);
};
XCNode.prototype.scaleX = function() {
  return _xcNodeScaleX(this);
};
XCNode.prototype.scaleY = function() {
  return _xcNodeScaleY(this);
};
XCNode.prototype.rotateBy = function(offset) {
  return this.setRotation(this.rotation() + offset);
};
XCNode.prototype.rotateTo = function(newRotation) {
  return this.setRotation(newRotation);
};
XCNode.prototype.rotation = function() {
  return _xcNodeRotation(this);
};
XCNode.prototype.setRotation = function(newRotation) {
  return _xcNodeSetRotation(this, newRotation);
};
XCNode.prototype.fadeTo = function(newOpacity) {
  return this.setOpacity(newOpacity);
};
XCNode.prototype.fadeBy = function(opacity) {
  return this.setOpacity(Math.max(this.opacity - opacity, 0));
};
XCNode.prototype.opacity = function() {
  return _xcNodeOpacity(this);
};
XCNode.prototype.setOpacity = function(newOpacity) {
  return _xcNodeSetOpacity(this, newOpacity);
};
XCNode.prototype.setAnchorX = function(anchor) {
  return this.setAnchorX(anchor);
};
XCNode.prototype.setAnchorY = function(anchor) {
  return this.setAnchorY(anchor);
};
XCNode.prototype.anchorX = function() {
  return _xcNodeAnchorX(this);
};
XCNode.prototype.anchorY = function() {
  return _xcNodeAnchorY(this);
};
XCNode.prototype.setAnchorX = function(newAnchorX) {
  return _xcNodeSetAnchorX(this, newAnchorX);
};
XCNode.prototype.setAnchorY = function(newAnchorY) {
  return _xcNodeSetAnchorY(this, newAnchorY);
};
XCNode.prototype.addChild = function(child) {
  this.children.push(child);
  return (child.parent = this);
};
XCNode.prototype.removeChild = function(child) {
  var pos;
  pos = this.children.indexOf(child);
  if (pos !== -1) {
    this.children = this.children.slice(0, pos).concat(this.children.slice(pos + 1, this.children.length));
    return (child.parent = null);
  }
};
XCNode.prototype.runAction = function(action) {
  action.owner = this;
  return xc.actions.push(action);
};
XCNode.prototype.removeAction = function(action) {
  var pos;
  pos = xc.actions.indexOf(action);
  return pos !== -1 ? (xc.actions = xc.actions.slice(0, pos).concat(xc.actions.slice(pos + 1, xc.actions.length))) : null;
};
XCSpriteNode = function(imageName, _arg, _arg2) {
  this.height = _arg2;
  this.width = _arg;
  this.drawable = true;
  XCSpriteNode.__super__.constructor.call(this);
  this.sprite = _xcLoadSprite(imageName);
  this.frame = 0;
  return this;
};
__extends(XCSpriteNode, XCNode);
XCSpriteNode.prototype.draw = function() {
  return _xcSpriteDraw(this);
};
XCTextNode = function(_arg, _arg2, _arg3) {
  this.fontSize = _arg3;
  this.fontName = _arg2;
  this._text = _arg;
  this.drawable = true;
  this.ref = _xcLoadText(this);
  XCTextNode.__super__.constructor.call(this);
  return this;
};
__extends(XCTextNode, XCNode);
XCTextNode.prototype.text = function() {
  return _xcTextNodeText(this);
};
XCTextNode.prototype.setText = function(newText) {
  return _xcTextSetText(this, newText);
};
XCTextNode.prototype.draw = function() {
  return _xcTextDraw(this);
};
XCSceneNode = function() {
  this._paused = false;
  XCSceneNode.__super__.constructor.call(this);
  return this;
};
__extends(XCSceneNode, XCNode);
XCSceneNode.prototype.pause = function() {
  return (this._paused = true);
};
XCSceneNode.prototype.paused = function() {
  return this._paused;
};
XCSceneNode.prototype.resume = function() {
  return (this._paused = false);
};
XCSceneNode.prototype.close = function() {};
XCEvent = function(_arg) {
  this.name = _arg;
  return this;
};
XCTapDownEvent = function(_arg, _arg2, _arg3) {
  this.tapNumber = _arg3;
  this.y = _arg2;
  this.x = _arg;
  XCTapDownEvent.__super__.constructor.call(this, "tapDown");
  return this;
};
__extends(XCTapDownEvent, XCEvent);
XCTapMovedEvent = function(_arg, _arg2, _arg3, _arg4, _arg5) {
  this.tapNumber = _arg5;
  this.moveY = _arg4;
  this.moveX = _arg3;
  this.y = _arg2;
  this.x = _arg;
  XCTapMovedEvent.__super__.constructor.call(this, "tapMoved");
  return this;
};
__extends(XCTapMovedEvent, XCEvent);
XCTapUpEvent = function(_arg, _arg2, _arg3) {
  this.tapNumber = _arg3;
  this.y = _arg2;
  this.x = _arg;
  XCTapUpEvent.__super__.constructor.call(this, "tapUp");
  return this;
};
__extends(XCTapUpEvent, XCEvent);
XCKeyDownEvent = function(_arg) {
  this.key = _arg;
  XCKeyDownEvent.__super__.constructor.call(this, "keyDown");
  return this;
};
__extends(XCKeyDownEvent, XCEvent);
XCKeyUpEvent = function(_arg) {
  this.key = _arg;
  XCKeyUpEvent.__super__.constructor.call(this, "keyUp");
  return this;
};
__extends(XCKeyUpEvent, XCEvent);
XCColor = function(_arg, _arg2, _arg3) {
  this.b = _arg3;
  this.g = _arg2;
  this.r = _arg;
  return this;
};
XCAction = function(_arg) {
  this.name = _arg;
  return this;
};
XCAction.prototype.tick = function(dt) {};
XCMoveAction = function(name) {
  XCMoveAction.__super__.constructor.call(this, name);
  this.etX = 0;
  this.etY = 0;
  return this;
};
__extends(XCMoveAction, XCAction);
XCMoveAction.prototype.tick = function(dt) {
  var moveX, moveY;
  this.etX += dt;
  this.etY += dt;
  if (this.x === 0 && this.y === 0) {
    return this.owner.removeAction(this);
  } else {
    moveX = this.etX * this.stepX;
    moveY = this.etY * this.stepY;
    if (Math.abs(moveX) > 0) {
      this.etX = 0;
    }
    if (Math.abs(moveY) > 0) {
      this.etY = 0;
    }
    if (this.positiveX && (this.x - moveX < 0)) {
      moveX = this.x;
    } else if ((!this.positiveX) && (this.x - moveX > 0)) {
      moveX = this.x;
    }
    if (this.positiveY && (this.y - moveY < 0)) {
      moveY = this.y;
    } else if ((!this.positiveY) && (this.y - moveY > 0)) {
      moveY = this.y;
    }
    this.x -= moveX;
    this.y -= moveY;
    return this.owner.moveBy(moveX, moveY);
  }
};
XCMoveTo = function(_arg, _arg2, _arg3) {
  this.y = _arg3;
  this.x = _arg2;
  this.duration = _arg;
  XCMoveTo.__super__.constructor.call(this, "XCMoveTo");
  this.firstTick = true;
  return this;
};
__extends(XCMoveTo, XCMoveAction);
XCMoveTo.prototype.tick = function(dt) {
  if (this.firstTick) {
    this.x -= this.owner.X();
    this.y -= this.owner.Y();
    this.stepX = this.x / this.duration;
    this.stepY = this.y / this.duration;
    this.positiveX = this.stepX > 0;
    this.positiveY = this.stepY > 0;
    this.firstTick = false;
  }
  return XCMoveTo.__super__.tick.call(this, dt);
};
XCMoveBy = function(_arg, _arg2, _arg3) {
  this.y = _arg3;
  this.x = _arg2;
  this.duration = _arg;
  XCMoveBy.__super__.constructor.call(this, "XCMoveBy");
  this.stepX = this.x / this.duration;
  this.stepY = this.y / this.duration;
  this.positiveX = this.stepX > 0;
  this.positiveY = this.stepY > 0;
  return this;
};
__extends(XCMoveBy, XCMoveAction);
XCRotateAction = function(name) {
  XCRotateAction.__super__.constructor.call(this, name);
  this.et = 0;
  return this;
};
__extends(XCRotateAction, XCAction);
XCRotateAction.prototype.tick = function(dt) {
  var rotation;
  this.et += dt;
  rotation = this.et * this.stepAngle;
  if (Math.abs(rotation) > 0) {
    this.et = 0;
  }
  if (this.positiveRotation && (this.angle - rotation <= 0)) {
    rotation = this.angle;
    this.owner.removeAction(this);
  } else if ((!this.positiveRotation) && (this.angle - rotation >= 0)) {
    rotation = this.angle;
    this.owner.removeAction(this);
  }
  this.angle -= rotation;
  return this.owner.rotateBy(rotation);
};
XCRotateTo = function(_arg, _arg2) {
  this.angle = _arg2;
  this.duration = _arg;
  XCRotateTo.__super__.constructor.call(this, "XCRotateTo");
  this.firstTick = true;
  return this;
};
__extends(XCRotateTo, XCRotateAction);
XCRotateTo.prototype.tick = function(dt) {
  if (this.firstTick) {
    this.angle -= this.owner.rotation();
    this.stepAngle = this.angle / this.duration;
    this.positiveRotation = this.angle > 0;
    this.firstTick = false;
  }
  return XCRotateTo.__super__.tick.call(this, dt);
};
XCRotateBy = function(_arg, _arg2) {
  this.angle = _arg2;
  this.duration = _arg;
  XCRotateBy.__super__.constructor.call(this, "XCRotateBy");
  this.stepAngle = this.angle / this.duration;
  this.positiveRotation = this.angle > 0;
  return this;
};
__extends(XCRotateBy, XCRotateAction);
XCScaleAction = function(name) {
  XCScaleAction.__super__.constructor.call(this, name);
  this.et = 0;
  this.firstTick = true;
  return this;
};
__extends(XCScaleAction, XCAction);
XCScaleAction.prototype.tick = function(dt) {
  var newScale;
  if (this.scale === 0) {
    this.owner.removeAction(this);
  }
  this.et += dt;
  newScale = this.et * this.stepScale;
  if (Math.abs(newScale) > 0) {
    this.et = 0;
  }
  if (Math.abs(this.scale) - Math.abs(newScale) <= 0) {
    newScale = this.scale;
  }
  this.scale -= newScale;
  return this.owner.scaleTo(this.owner.scaleX + newScale);
};
XCScaleTo = function(_arg, _arg2) {
  this.scale = _arg2;
  this.duration = _arg;
  XCScaleTo.__super__.constructor.call(this, "XCScaleTo");
  return this;
};
__extends(XCScaleTo, XCScaleAction);
XCScaleTo.prototype.tick = function(dt) {
  if (this.firstTick) {
    this.scale -= this.owner.scaleX();
    this.stepScale = this.scale / this.duration;
    this.firstTick = false;
  }
  return XCScaleTo.__super__.tick.call(this, dt);
};
XCScaleBy = function(_arg, _arg2) {
  this.scale = _arg2;
  this.duration = _arg;
  XCScaleBy.__super__.constructor.call(this, "XCScaleTo");
  return this;
};
__extends(XCScaleBy, XCScaleAction);
XCScaleBy.prototype.tick = function(dt) {
  if (this.firstTick) {
    this.scale = (this.scale * this.owner.scaleX) - this.owner.scaleX();
    this.stepScale = this.scale / this.duration;
    this.firstTick = false;
  }
  return XCScaleBy.__super__.tick.call(this, dt);
};