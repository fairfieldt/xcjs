var XCEvent, XCTapDownEvent, XCTapMovedEvent, XCTapUpEvent;
var __extends = function(child, parent) {
    var ctor = function(){};
    ctor.prototype = parent.prototype;
    child.prototype = new ctor();
    child.prototype.constructor = child;
    if (typeof parent.extended === "function") parent.extended(child);
    child.__super__ = parent.prototype;
  };
XCEvent = function(_a) {
  this.name = _a;
  return this;
};
XCTapDownEvent = function(_a, _b, _c) {
  this.tapNumber = _c;
  this.y = _b;
  this.x = _a;
  XCTapDownEvent.__super__.constructor.call(this, "tapDown");
  return this;
};
__extends(XCTapDownEvent, XCEvent);
XCTapMovedEvent = function(_a, _b, _c, _d, _e) {
  this.tapNumber = _e;
  this.moveY = _d;
  this.moveX = _c;
  this.y = _b;
  this.x = _a;
  XCTapMovedEvent.__super__.constructor.call(this, "tapMoved");
  return this;
};
__extends(XCTapMovedEvent, XCEvent);
XCTapUpEvent = function(_a, _b, _c) {
  this.tapNumber = _c;
  this.y = _b;
  this.x = _a;
  XCTapUpEvent.__super__.constructor.call(this, "tapUp");
  return this;
};
__extends(XCTapUpEvent, XCEvent);