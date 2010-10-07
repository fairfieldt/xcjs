var XCEvent, XCKeyDownEvent, XCKeyUpEvent, XCTapDownEvent, XCTapMovedEvent, XCTapUpEvent;
var __extends = function(child, parent) {
    var ctor = function(){};
    ctor.prototype = parent.prototype;
    child.prototype = new ctor();
    child.prototype.constructor = child;
    if (typeof parent.extended === "function") parent.extended(child);
    child.__super__ = parent.prototype;
  };
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