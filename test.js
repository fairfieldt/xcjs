var BobSprite, bad, bob, canvas, clear, context, date, fps, previousTime, root, update, xc;
var __extends = function(child, parent) {
    var ctor = function(){};
    ctor.prototype = parent.prototype;
    child.prototype = new ctor();
    child.prototype.constructor = child;
    if (typeof parent.extended === "function") parent.extended(child);
    child.__super__ = parent.prototype;
  };
canvas = document.getElementById('gameCanvas');
context = canvas.getContext('2d');
$(canvas).mousedown(_xcHandleMouseDown);
$(canvas).mousemove(_xcHandleMouseMoved);
$(canvas).mouseup(_xcHandleMouseUp);
xc = new xc();
root = xc.getCurrentScene();
BobSprite = function() {
  BobSprite.__super__.constructor.call(this, 'bob.png', 34, 48, 1);
  return this;
};
__extends(BobSprite, XCSpriteNode);
BobSprite.prototype.sayHi = function() {
  this.message = "Hi!";
  return alert(this.message);
};
bob = new BobSprite('bob.png');
bob.tapMoved = function(event) {
  this.moveBy(event.moveX, event.moveY);
  this.rotateBy(1);
  return this.scaleTo(2.0);
};
bob.tapUp = function(event) {
  return this.scaleBy(2.0);
};
console.log('got here');
xc.addEventListener('tapMoved', bob);
bad = new XCEvent('doesntExist');
xc.dispatchEvent(bad);
root.addChild(bob);
bob.moveBy(60, 60);
date = new Date();
previousTime = date.getTime();
update = function() {
  var currentTime, delta;
  currentTime = new Date().getTime();
  delta = currentTime - previousTime;
  previousTime = currentTime;
  root.update(delta);
  clear();
  return xc.draw(root);
};
clear = function() {
  return context.clearRect(0, 0, 640, 480);
};
fps = 60;
setInterval(update, 1000 / fps);