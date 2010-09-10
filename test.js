var bad, bob, canvas, clear, context, date, event, fps, man2, previousTime, root, update, xc;
canvas = document.getElementById('gameCanvas');
context = canvas.getContext('2d');
$(canvas).mousedown(_xcHandleMouseDown);
$(canvas).mousemove(_xcHandleMouseMoved);
$(canvas).mouseup(_xcHandleMouseUp);
xc = new xc();
root = new XCNode();
bob = new XCSpriteNode('bob.png');
bob.onUpdate = function(delta) {};
bob.tapDown = function(event) {
  return true;
};
bob.tapMoved = function(event) {
  return this.moveBy(event.moveX, event.moveY);
};
bob.tapUp = function(event) {
  return this.scaleBy(1.5);
};
xc.addEventListener('tapMoved', bob);
xc.addEventListener('tapDown', bob);
xc.addEventListener('tapUp', bob);
bad = new XCEvent('doesntExist');
xc.dispatchEvent(bad);
man2 = new XCSpriteNode('bob.png');
man2.testEvent = function(event) {
  this.scaleBy(.5);
  return false;
};
xc.addEventListener('testEvent', man2);
event = [];
event.name = 'testEvent';
xc.dispatchEvent(event);
root.addChild(man2);
man2.moveTo(300, 400);
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