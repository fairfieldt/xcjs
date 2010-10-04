var DPad;
var __extends = function(child, parent) {
    var ctor = function(){};
    ctor.prototype = parent.prototype;
    child.prototype = new ctor();
    child.prototype.constructor = child;
    if (typeof parent.extended === "function") parent.extended(child);
    child.__super__ = parent.prototype;
  };
DPad = function() {
  DPad.__super__.constructor.call(this, 'dpad.png', 96, 96);
  xc.addEventListener('tapDown', this);
  return this;
};
__extends(DPad, XCSpriteNode);
DPad.prototype.tapDown = function(event) {
  var x, y;
  x = event.x;
  y = event.y;
  return event.x > 320 - 96 && event.x < 320 && event.y > 384 && event.y < 480 ? console.log('this tap belongs to me') : null;
};