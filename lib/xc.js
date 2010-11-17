var XCAction, XCColor, XCCompat, XCEvent, XCKeyDownEvent, XCKeyUpEvent, XCMoveAction, XCMoveBy, XCMoveTo, XCNode, XCRotateAction, XCRotateBy, XCRotateTo, XCScaleAction, XCScaleBy, XCScaleTo, XCScene, XCSpriteNode, XCTapDownEvent, XCTapMovedEvent, XCTapUpEvent, XCTextNode, _xcNodeAnchorX, _xcNodeAnchorY, _xcNodeColor, _xcNodeHeight, _xcNodeLayer, _xcNodeOpacity, _xcNodeRotation, _xcNodeScaleX, _xcNodeScaleY, _xcNodeSetAnchorX, _xcNodeSetAnchorY, _xcNodeSetColor, _xcNodeSetLayer, _xcNodeSetOpacity, _xcNodeSetRotation, _xcNodeSetScaleX, _xcNodeSetScaleY, _xcNodeSetVisible, _xcNodeSetX, _xcNodeSetY, _xcNodeVisible, _xcNodeWidth, _xcNodeX, _xcNodeY, _xcTextNodeHeight, _xcTextNodeText, _xcTextNodeWidth, _xcTextSetText, xc;
var __extends = function(child, parent) {
    var ctor = function(){};
    ctor.prototype = parent.prototype;
    child.prototype = new ctor();
    child.prototype.constructor = child;
    if (typeof parent.extended === "function") parent.extended(child);
    child.__super__ = parent.prototype;
  };
XCCompat = function() {
  return this;
};
_xcNodeWidth = function(node) {
  return node._width;
};
_xcNodeHeight = function(node) {
  return node._height;
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
  height = context.measureText('m').width;
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
  return (node._x = newX);
};
_xcNodeSetY = function(node, newY) {
  return (node._y = newY);
};
_xcNodeLayer = function(node) {
  return node._layer;
};
_xcNodeSetLayer = function(node, newLayer) {
  return (node._layer = newLayer);
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
  while (newRotation > 360) {
    newRotation = newRotation - 360;
  }
  while (newRotation < 0) {
    newRotation = 360 + newRotation;
  }
  return (node._rotation = newRotation);
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
_xcNodeVisible = function(node) {
  return node._visible;
};
_xcNodeSetVisible = function(node, visible) {
  return (node._visible = visible);
};
_xcTextNodeText = function(node) {
  return node._text;
};
_xcTextSetText = function(node, newText) {
  return (node._text = newText);
};
XCColor = function(_arg, _arg2, _arg3) {
  this.b = _arg3;
  this.g = _arg2;
  this.r = _arg;
  return this;
};
XCNode = function() {
  this._visible = true;
  this._x = 0;
  this._y = 0;
  this._layer = 0;
  this._scaleX = 1.0;
  this._scaleY = 1.0;
  this._rotation = 0.0;
  this._opacity = 1.0;
  this._anchorX = .5;
  this._anchorY = .5;
  this.parent = null;
  this._color = new XCColor(0, 0, 0);
  this._actions = [];
  return this;
};
XCNode.prototype.width = function() {
  return _xcNodeWidth(this);
};
XCNode.prototype.height = function() {
  return _xcNodeHeight(this);
};
XCNode.prototype.rect = function() {
  return {
    x: this.X() - (this.anchorX() * this.width()),
    y: this.Y() - (this.anchorY() * this.height()),
    w: this.width(),
    h: this.height()
  };
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
XCNode.prototype.layer = function() {
  return _xcNodeLayer(this);
};
XCNode.prototype.setLayer = function(newLayer) {
  return _xcNodeSetLayer(this, newLayer);
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
XCNode.prototype.opacity = function() {
  return _xcNodeOpacity(this);
};
XCNode.prototype.setOpacity = function(newOpacity) {
  return _xcNodeSetOpacity(this, newOpacity);
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
XCNode.prototype.visible = function() {
  return _xcNodeVisible(this);
};
XCNode.prototype.hide = function() {
  return _xcNodeSetVisible(this, false);
};
XCNode.prototype.show = function() {
  return _xcNodeSetVisible(this, true);
};
XCNode.prototype.actions = function() {
  return this._actions;
};
XCNode.prototype.runAction = function(action) {
  if (this._actions.indexOf(action) === -1 && action.owner === null) {
    action.owner = this;
    return this._actions.push(action);
  } else {
    throw {
      name: "RunDuplicateActionError",
      message: "Tried to add action " + action + " to " + this + " twice"
    };
  }
};
XCNode.prototype.removeAction = function(action) {
  var pos;
  pos = this._actions.indexOf(action);
  if (pos !== -1) {
    return (this._actions = this._actions.slice(0, pos).concat(this._actions.slice(pos + 1, this._actions.length)));
  } else {
    throw {
      name: "RemoveActionError",
      message: "Tried to remove action " + action.name + " when it was not added"
    };
  }
};
XCTextNode = function(_arg, _arg2, _arg3) {
  this.fontSize = _arg3;
  this.fontName = _arg2;
  this._text = _arg;
  this.drawable = true;
  this.ref = _xcLoadText(this);
  this.font = this.fontSize + "pt " + this.fontName;
  XCTextNode.__super__.constructor.call(this);
  return this;
};
__extends(XCTextNode, XCNode);
XCTextNode.prototype.width = function() {
  return _xcTextNodeWidth(this);
};
XCTextNode.prototype.height = function() {
  return _xcTextNodeHeight(this);
};
XCTextNode.prototype.text = function() {
  return _xcTextNodeText(this);
};
XCTextNode.prototype.setText = function(newText) {
  return _xcTextSetText(this, newText);
};
XCTextNode.prototype.draw = function() {
  return _xcTextDraw(this);
};
XCSpriteNode = function(imageName) {
  this.drawable = true;
  XCSpriteNode.__super__.constructor.call(this);
  this.sprite = _xcLoadSprite(imageName);
  this._width = _xcImageWidth(this.sprite);
  this._height = _xcImageHeight(this.sprite);
  this.frame = 0;
  return this;
};
__extends(XCSpriteNode, XCNode);
XCSpriteNode.prototype.draw = function() {
  return _xcSpriteDraw(this);
};
XCScene = function(_arg) {
  this.name = _arg;
  this._paused = false;
  this._children = [];
  this._scheduledFunctions = [];
  return this;
};
XCScene.prototype.pause = function() {
  return (this._paused = true);
};
XCScene.prototype.paused = function() {
  return this._paused;
};
XCScene.prototype.resume = function() {
  return (this._paused = false);
};
XCScene.prototype.close = function() {};
XCScene.prototype.tick = function(dt) {
  var _i, _j, _len, _len2, _ref, _ref2, _result, action, child, scheduled;
  _ref = this.children();
  for (_i = 0, _len = _ref.length; _i < _len; _i++) {
    child = _ref[_i];
    _ref2 = child.actions();
    for (_j = 0, _len2 = _ref2.length; _j < _len2; _j++) {
      action = _ref2[_j];
      action.tick(delta);
    }
  }
  _result = []; _ref = this._scheduledFunctions;
  for (_i = 0, _len = _ref.length; _i < _len; _i++) {
    scheduled = _ref[_i];
    _result.push((function() {
      scheduled.et += dt;
      if (scheduled.et >= scheduled.interval) {
        scheduled["function"](scheduled.et);
        return (scheduled.et = 0);
      }
    })());
  }
  return _result;
};
XCScene.prototype.addChild = function(child) {
  if (child.parent !== null) {
    throw {
      name: 'DuplicateChildError',
      message: 'Node already a child of another scene'
    };
  }
  if (this._children.indexOf(child) === -1) {
    this._children.push(child);
    return (child.parent = this);
  } else {
    throw {
      name: 'DuplicateChildError',
      message: 'Can\'t add the same child twice'
    };
  }
};
XCScene.prototype.removeChild = function(child) {
  var pos;
  pos = this._children.indexOf(child);
  if (pos !== -1) {
    this._children = this._children.slice(0, pos).concat(this._children.slice(pos + 1, this._children.length));
    return (child.parent = null);
  } else {
    throw {
      name: 'NodeNotChildError',
      message: 'Can\'t remove a node that is not a child'
    };
  }
};
XCScene.prototype.children = function() {
  return this._children;
};
XCScene.prototype.scheduledFunctions = function() {
  return this._scheduledFunctions;
};
XCScene.prototype.schedule = function(fn, interval) {
  interval = (typeof interval !== "undefined" && interval !== null) ? interval : 0;
  return this._scheduledFunctions.push({
    "function": fn,
    interval: interval,
    et: 0
  });
};
XCScene.prototype.unschedule = function(fn) {
  var i;
  i = this._scheduledFunctions.indexOf(fn);
  return !(i === -1) ? (this._scheduledFunctions = this._scheduledFunctions.slice(0, i + 1).concat(this._scheduledFunctions.slice(i + 1, this.scheduledFunctions.length + 1))) : null;
};
xc = function() {
  this._scenes = [];
  this._scenes.push(new XCScene('DefaultScene'));
  return this;
};
xc.prototype.addEventListener = function(eventName, listener) {
  if (!this[eventName]) {
    this[eventName] = [];
  }
  if (this[eventName].indexOf(listener) === -1) {
    return this[eventName].push(listener);
  } else {
    throw {
      name: 'EventListenerAlreadyAddedError',
      message: 'The event listener for ' + eventName + ' ' + listener + ' was already added'
    };
  }
};
xc.prototype.removeEventListener = function(eventName, listener) {
  var _ref, pos;
  if ((typeof (_ref = this[eventName]) !== "undefined" && _ref !== null) && (pos = this[eventName].indexOf(listener)) !== -1) {
    return (this[eventName] = this[eventName].slice(0, pos).concat(this[eventName].slice(pos + 1, this[eventName].length - 1 + 1)));
  } else {
    throw {
      name: 'NoSuchEventListenerError',
      message: 'There is no listener for ' + eventName + ' ' + listener
    };
  }
};
xc.prototype.dispatchEvent = function(event) {
  var _i, _len, _ref, _result, listener;
  if (typeof (_ref = this[event.name]) !== "undefined" && _ref !== null) {
    _result = []; _ref = this[event.name];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      listener = _ref[_i];
      _result.push(listener[event.name](event));
    }
    return _result;
  }
};
xc.prototype.replaceScene = function(newScene) {
  if (newScene !== this.getCurrentScene()) {
    this._scenes.pop().close();
    return this._scenes.push(newScene);
  } else {
    throw {
      name: 'DuplicateSceneError',
      message: 'Cannot replace a scene with itself'
    };
  }
};
xc.prototype.pushScene = function(scene) {
  if (this._scenes.indexOf(scene) === -1) {
    return this._scenes.push(scene);
  } else {
    throw {
      name: 'DuplicateSceneError',
      message: 'Cannot put a scene on the stack twice'
    };
  }
};
xc.prototype.popScene = function() {
  if (this._scenes.length > 1) {
    return this._scenes.pop().close();
  } else {
    throw {
      name: 'PoppedLastSceneError',
      message: 'Can\'t pop with one scene left'
    };
  }
};
xc.prototype.getCurrentScene = function() {
  return this._scenes[this._scenes.length - 1];
};
xc.prototype.rectContainsPoint = function(rect, point) {
  console.log('checking ' + point.x + ',' + point.y + ' ' + rect.x + ',' + rect.y + ': ' + rect.w + ',' + rect.h);
  return (point.x > rect.x) && (point.x < (rect.x + rect.w)) && (point.y > rect.y) && (point.y < (rect.y + rect.h));
};
XCAction = function(_arg) {
  this.name = _arg;
  this.owner = null;
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