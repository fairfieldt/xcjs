var bob, canvas, clear, context, date, fps, man2, previousTime, root, update, xc;
canvas = document.getElementById('gameCanvas');
context = canvas.getContext('2d');
xc = new xc();
root = new Node();
bob = new SpriteNode('bob.png');
bob.direction = 1;
bob.onUpdate = function(delta) {
  return this.x += .06 * delta;
};
man2 = new SpriteNode('bob.png');
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