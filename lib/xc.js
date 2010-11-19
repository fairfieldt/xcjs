var XCAction, XCButtonNode, XCCallFuncAction, XCColor, XCCompat, XCDelayAction, XCEvent, XCIntervalAction, XCKeyDownEvent, XCKeyUpEvent, XCMoveAction, XCMoveByAction, XCMoveToAction, XCNode, XCRotateAction, XCRotateByAction, XCRotateToAction, XCScaleAction, XCScaleByAction, XCScaleToAction, XCScene, XCSequenceAction, XCSpriteNode, XCTapDownEvent, XCTapMovedEvent, XCTapUpEvent, XCTextNode, _xcNodeAnchorX, _xcNodeAnchorY, _xcNodeColor, _xcNodeHeight, _xcNodeLayer, _xcNodeOpacity, _xcNodeRotation, _xcNodeScaleX, _xcNodeScaleY, _xcNodeSetAnchorX, _xcNodeSetAnchorY, _xcNodeSetColor, _xcNodeSetLayer, _xcNodeSetOpacity, _xcNodeSetRotation, _xcNodeSetScaleX, _xcNodeSetScaleY, _xcNodeSetVisible, _xcNodeSetX, _xcNodeSetY, _xcNodeVisible, _xcNodeWidth, _xcNodeX, _xcNodeY, _xcTextNodeHeight, _xcTextNodeText, _xcTextNodeWidth, _xcTextSetText, xc;
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
XCNode.prototype.tick = function(dt) {
  var _i, _len, _ref, _result, action;
  _result = []; _ref = this.actions();
  for (_i = 0, _len = _ref.length; _i < _len; _i++) {
    action = _ref[_i];
    _result.push(!action.tick(dt) ? this.removeAction(action) : null);
  }
  return _result;
};
XCNode.prototype.runAction = function(action) {
  if (this._actions.indexOf(action) === -1 && action.owner === null) {
    action.setOwner(this);
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
XCAction = function(_arg) {
  this.name = _arg;
  this.owner = null;
  return this;
};
XCAction.prototype.tick = function(dt) {
  return false;
};
XCAction.prototype.setOwner = function(owner) {
  return (this.owner = owner);
};
XCSequenceAction = function(_arg) {
  this.actions = _arg;
  XCSequenceAction.__super__.constructor.call(this, "XCSequenceAction");
  return this;
};
__extends(XCSequenceAction, XCAction);
XCSequenceAction.prototype.tick = function(dt) {
  var currentAction;
  if (this.actions.length === 0) {
    return false;
  }
  currentAction = this.actions[0];
  if (!currentAction.tick(dt)) {
    this.actions = this.actions.slice(1, this.actions.length + 1);
  }
  return true;
};
XCSequenceAction.prototype.removeAction = function(action) {
  var position;
  position = this.actions.indexOf(action);
  return position !== -1 ? (this.actions = this.actions.slice(0, position).concat(this.actions.slice(position + 1, this.actions.length - 1 + 1))) : null;
};
XCSequenceAction.prototype.setOwner = function(owner) {
  var _i, _len, _ref, _result, action;
  XCSequenceAction.__super__.setOwner.call(this, owner);
  _result = []; _ref = this.actions;
  for (_i = 0, _len = _ref.length; _i < _len; _i++) {
    action = _ref[_i];
    _result.push(action.setOwner(this.owner));
  }
  return _result;
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
  var _i, _len, _ref, _result, child, scheduled;
  _ref = this.children();
  for (_i = 0, _len = _ref.length; _i < _len; _i++) {
    child = _ref[_i];
    child.tick(dt);
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
XCIntervalAction = function(_arg, name) {
  this.duration = _arg;
  XCIntervalAction.__super__.constructor.call(this, name);
  return this;
};
__extends(XCIntervalAction, XCAction);
XCIntervalAction.prototype.tick = function(dt) {
  this.duration -= dt;
  return this.duration > 0;
};
XCScaleAction = function(duration, name) {
  XCScaleAction.__super__.constructor.call(this, duration, name);
  this.etX = 0;
  this.etY = 0;
  this.firstTick = true;
  return this;
};
__extends(XCScaleAction, XCIntervalAction);
XCScaleAction.prototype.tick = function(dt) {
  var newScaleX, newScaleY;
  this.etX += dt;
  this.etY += dt;
  newScaleX = this.etX * this.stepScaleX;
  newScaleY = this.etY * this.stepScaleY;
  if (Math.abs(newScaleX) > 0) {
    this.etX = 0;
  }
  if (Math.abs(newScaleY) > 0) {
    this.etY = 0;
  }
  if (Math.abs(this.scale.x) - Math.abs(newScaleX) <= 0) {
    newScaleX = this.scale.x;
  }
  if (Math.abs(this.scale.y) - Math.abs(newScaleY) <= 0) {
    newScaleY = this.scale.y;
  }
  this.scale.x -= newScaleY;
  this.scale.y -= newScaleY;
  this.owner.scaleXTo(this.owner.scaleX() + newScaleX);
  this.owner.scaleYTo(this.owner.scaleY() + newScaleY);
  return XCScaleAction.__super__.tick.call(this, dt);
};
XCScaleToAction = function(duration, _arg) {
  this.scale = _arg;
  XCScaleToAction.__super__.constructor.call(this, duration, "XCScaleTo");
  return this;
};
__extends(XCScaleToAction, XCScaleAction);
XCScaleToAction.prototype.tick = function(dt) {
  if (this.firstTick) {
    this.scale.x -= this.owner.scaleX();
    this.scale.y -= this.owner.scaleY();
    this.stepScaleX = this.scale.x / this.duration;
    this.stepScaleY = this.scale.y / this.duration;
    this.firstTick = false;
  }
  return XCScaleToAction.__super__.tick.call(this, dt);
};
XCScaleByAction = function(duration, _arg) {
  this.scale = _arg;
  XCScaleByAction.__super__.constructor.call(this, duration, "XCScaleTo");
  return this;
};
__extends(XCScaleByAction, XCScaleAction);
XCScaleByAction.prototype.tick = function(dt) {
  if (this.firstTick) {
    this.scale = (this.scale * this.owner.scaleX) - this.owner.scaleX();
    this.stepScaleX = this.scale.x / this.duration;
    this.stepScaleY = this.scale.y / this.duration;
    this.firstTick = false;
  }
  return XCScaleByAction.__super__.tick.call(this, dt);
};
XCRotateAction = function(duration, name) {
  XCRotateAction.__super__.constructor.call(this, duration, name);
  this.et = 0;
  return this;
};
__extends(XCRotateAction, XCIntervalAction);
XCRotateAction.prototype.tick = function(dt) {
  var rotation;
  this.et += dt;
  rotation = this.et * this.stepAngle;
  if (Math.abs(rotation) > 0) {
    this.et = 0;
  }
  if (this.positiveRotation && (this.angle - rotation <= 0)) {
    rotation = this.angle;
  } else if ((!this.positiveRotation) && (this.angle - rotation >= 0)) {
    rotation = this.angle;
  }
  this.angle -= rotation;
  this.owner.rotateBy(rotation);
  return XCRotateAction.__super__.tick.call(this, dt);
};
XCRotateToAction = function(duration, _arg) {
  this.angle = _arg;
  XCRotateToAction.__super__.constructor.call(this, duration, "XCRotateTo");
  this.firstTick = true;
  return this;
};
__extends(XCRotateToAction, XCRotateAction);
XCRotateToAction.prototype.tick = function(dt) {
  if (this.firstTick) {
    this.angle -= this.owner.rotation();
    this.stepAngle = this.angle / this.duration;
    this.positiveRotation = this.angle > 0;
    this.firstTick = false;
  }
  return XCRotateToAction.__super__.tick.call(this, dt);
};
XCRotateByAction = function(duration, _arg) {
  this.angle = _arg;
  XCRotateByAction.__super__.constructor.call(this, duration, "XCRotateBy");
  this.stepAngle = this.angle / this.duration;
  this.positiveRotation = this.angle > 0;
  return this;
};
__extends(XCRotateByAction, XCRotateAction);
XCMoveAction = function(duration, name) {
  XCMoveAction.__super__.constructor.call(this, duration, name);
  this.etX = 0;
  this.etY = 0;
  return this;
};
__extends(XCMoveAction, XCIntervalAction);
XCMoveAction.prototype.tick = function(dt) {
  var moveX, moveY;
  this.etX += dt;
  this.etY += dt;
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
  this.owner.moveBy(moveX, moveY);
  return XCMoveAction.__super__.tick.call(this, dt);
};
XCMoveToAction = function(duration, _arg, _arg2) {
  this.y = _arg2;
  this.x = _arg;
  XCMoveToAction.__super__.constructor.call(this, duration, "XCMoveTo");
  this.firstTick = true;
  return this;
};
__extends(XCMoveToAction, XCMoveAction);
XCMoveToAction.prototype.tick = function(dt) {
  if (this.firstTick) {
    this.x -= this.owner.X();
    this.y -= this.owner.Y();
    this.stepX = this.x / this.duration;
    this.stepY = this.y / this.duration;
    this.positiveX = this.stepX > 0;
    this.positiveY = this.stepY > 0;
    this.firstTick = false;
  }
  return XCMoveToAction.__super__.tick.call(this, dt);
};
XCMoveByAction = function(duration, _arg, _arg2) {
  this.y = _arg2;
  this.x = _arg;
  XCMoveByAction.__super__.constructor.call(this, duration, "XCMoveBy");
  this.stepX = this.x / this.duration;
  this.stepY = this.y / this.duration;
  this.positiveX = this.stepX > 0;
  this.positiveY = this.stepY > 0;
  return this;
};
__extends(XCMoveByAction, XCMoveAction);
XCEvent = function(_arg) {
  this.name = _arg;
  return this;
};
XCTapDownEvent = function(x, y, _arg) {
  this.tapNumber = _arg;
  this.point = {
    x: x,
    y: y
  };
  XCTapDownEvent.__super__.constructor.call(this, "tapDown");
  return this;
};
__extends(XCTapDownEvent, XCEvent);
XCTapMovedEvent = function(x, y, moveX, moveY, _arg) {
  this.tapNumber = _arg;
  this.point = {
    x: x,
    y: y
  };
  this.move = {
    x: moveX,
    y: moveY
  };
  XCTapMovedEvent.__super__.constructor.call(this, "tapMoved");
  return this;
};
__extends(XCTapMovedEvent, XCEvent);
XCTapUpEvent = function(x, y, _arg) {
  this.tapNumber = _arg;
  this.point = {
    x: x,
    y: y
  };
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
XCDelayAction = function(duration) {
  XCDelayAction.__super__.constructor.call(this, duration, 'XCDelayAction');
  return this;
};
__extends(XCDelayAction, XCIntervalAction);
XCCallFuncAction = function(_arg) {
  this.fn = _arg;
  XCCallFuncAction.__super__.constructor.call(this, "XCCallFuncAction");
  return this;
};
__extends(XCCallFuncAction, XCAction);
XCCallFuncAction.prototype.tick = function(dt) {
  return this.fn();
};
XCButtonNode = function(imageName) {
  XCButtonNode.__super__.constructor.call(this, imageName);
  xc.addEventListener('tapDown', this);
  xc.addEventListener('tapUp', this);
  xc.addEventListener('tapMoved', this);
  return this;
};
__extends(XCButtonNode, XCSpriteNode);
XCButtonNode.prototype.tapDown = function(event) {
  if (xc.rectContainsPoint(this.rect(), event.point)) {
    this.tapStarted = true;
    return this.scaleTo(1.1);
  }
};
XCButtonNode.prototype.tapMoved = function(event) {
  if (!xc.rectContainsPoint(this.rect(), event.point)) {
    this.tapStarted = false;
    return this.scaleTo(1.0);
  }
};
XCButtonNode.prototype.tapUp = function(event) {
  if (this.tapStarted && xc.rectContainsPoint(this.rect(), event.point)) {
    if (this.onHit) {
      this.onHit();
      this.scaleTo(1.0);
    }
  }
  return (this.tapStarted = false);
};
xc = function() {
  this._scenes = [];
  this._scenes.push(new XCScene('DefaultScene'));
  return this;
};
xc.prototype.addEventListener = function(eventName, listener) {
  var message;
  if (!this[eventName]) {
    this[eventName] = [];
  }
  if (this[eventName].indexOf(listener) === -1) {
    return this[eventName].push(listener);
  } else {
    message = 'The event listener for ' + eventName + ' ' + listener + ' was already added';
    throw {
      name: 'EventListenerAlreadyAddedError',
      message: message
    };
  }
};
xc.prototype.removeEventListener = function(eventName, listener) {
  var _ref, message, pos;
  if ((typeof (_ref = this[eventName]) !== "undefined" && _ref !== null) && (pos = this[eventName].indexOf(listener)) !== -1) {
    return (this[eventName] = this[eventName].slice(0, pos).concat(this[eventName].slice(pos + 1, this[eventName].length - 1 + 1)));
  } else {
    message = 'There is no listener for ' + eventName + ' ' + listener;
    throw {
      name: 'NoSuchEventListenerError',
      message: message
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
  var oldScene;
  if (!(this._scenes.indexOf(newScene) !== -1)) {
    oldScene = this._scenes.pop().close();
    this._scenes.push(newScene);
    return oldScene;
  } else {
    throw {
      name: 'DuplicateSceneError',
      message: 'Cannot replace a scene with itself'
    };
  }
};
xc.prototype.pushScene = function(newScene) {
  if (this._scenes.indexOf(newScene) === -1) {
    return this._scenes.push(newScene);
  } else {
    throw {
      name: 'DuplicateSceneError',
      message: 'Cannot put a scene on the stack twice'
    };
  }
};
xc.prototype.popScene = function() {
  var oldScene;
  if (this._scenes.length > 1) {
    oldScene = this._scenes.pop();
    oldScene.close();
    return oldScene;
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
  return (point.x > rect.x) && (point.x < (rect.x + rect.w)) && (point.y > rect.y) && (point.y < (rect.y + rect.h));
};