var JazzScene;
var __extends = function(child, parent) {
    var ctor = function(){};
    ctor.prototype = parent.prototype;
    child.prototype = new ctor();
    child.prototype.constructor = child;
    if (typeof parent.extended === "function") parent.extended(child);
    child.__super__ = parent.prototype;
  };
JazzScene = function() {
  var action, ball, t1;
  JazzScene.__super__.constructor.call(this);
  ball = new XCSpriteNode("walltile.png", 16, 16);
  this.addChild(ball);
  ball.vX = 60;
  ball.vY = 60;
  action = new XCAction();
  action.tick = function(dt) {
    var dX, dY;
    dX = this.owner.vX * dt;
    dY = this.owner.vY * dt;
    if (this.owner.x + dX > 320 || this.owner.x + dX < 0) {
      console.log("ran aground");
      dX = 0 - dX;
      this.owner.vX = 0 - this.owner.vX;
    }
    if (this.owner.y + dY > 480 || this.owner.y + dY < 0) {
      dY = 0 - dY;
      this.owner.vY = 0 - this.owner.vY;
    }
    this.owner.x += dX;
    return this.owner.y += dY;
  };
  ball.runAction(action);
  t1 = new XCTextNode("This text rocks", "arial", 18);
  this.addChild(t1);
  t1.moveTo(160, 80);
  t1.color = new XCColor(200, 200, 0);
  return this;
};
__extends(JazzScene, XCScene);