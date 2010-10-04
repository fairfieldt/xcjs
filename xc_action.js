var XCAction, XCMoveAction, XCMoveBy, XCMoveTo, XCRotateAction, XCRotateBy, XCRotateTo, XCScaleAction, XCScaleBy, XCScaleTo;
var __extends = function(child, parent) {
    var ctor = function(){};
    ctor.prototype = parent.prototype;
    child.prototype = new ctor();
    child.prototype.constructor = child;
    if (typeof parent.extended === "function") parent.extended(child);
    child.__super__ = parent.prototype;
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
    this.x -= this.owner.x;
    this.y -= this.owner.y;
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
    this.angle -= this.owner.rotation;
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
    this.scale -= this.owner.scaleX;
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
    this.scale = (this.scale * this.owner.scaleX) - this.owner.scaleX;
    this.stepScale = this.scale / this.duration;
    console.log('new scale ' + this.scale + ' stepScale ' + this.stepScale);
    this.firstTick = false;
  }
  return XCScaleBy.__super__.tick.call(this, dt);
};