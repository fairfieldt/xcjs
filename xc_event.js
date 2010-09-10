var XCEvent, XCTapDownEvent;
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