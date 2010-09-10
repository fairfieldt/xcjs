var bob, canvas, clear, context, date, event, fps, man2, mouseHandler, previousTime, root, update, xc;
canvas = document.getElementById('gameCanvas');
context = canvas.getContext('2d');
mouseHandler = function(event) {
  return _xcHandleMouseDown(event);
};
$(canvas).mousedown(mouseHandler);
xc = new xc();
root = new XCNode();
bob = new XCSpriteNode('bob.png');
bob.onUpdate = function(delta) {
  return this.x += .06 * delta;
};
bob.tapDown = function(event) {
  this.scaleTo(2.0);
  return false;
};
xc.addEventListener('tapDown', bob);
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