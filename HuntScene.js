var HuntScene;
var __extends = function(child, parent) {
    var ctor = function(){};
    ctor.prototype = parent.prototype;
    child.prototype = new ctor();
    child.prototype.constructor = child;
    if (typeof parent.extended === "function") parent.extended(child);
    child.__super__ = parent.prototype;
  };
HuntScene = function() {
  var alien, bg, dpad, man, map;
  HuntScene.__super__.constructor.call(this);
  bg = new XCSpriteNode('background.png', 320, 480);
  this.addChild(bg);
  map = new Map();
  this.addChild(map);
  man = new Man(map, 6, 2);
  map.man = man;
  man.keyDown = function(event) {
    if (event.key === 37) {
      return man.movedBlocks("left") ? man.gridMove(-1, 0) : null;
    } else if (event.key === 39) {
      return man.movedBlocks("right") ? man.gridMove(1, 0) : null;
    } else if (event.key === 38) {
      return man.movedBlocks("up") ? man.gridMove(0, -1) : null;
    } else if (event.key === 40) {
      return man.movedBlocks("down") ? man.gridMove(0, 1) : null;
    }
  };
  xc.addEventListener('keyDown', man);
  alien = new Alien(map, 10, 15);
  dpad = new DPad();
  this.addChild(dpad);
  dpad.moveTo(320 - 96, 384);
  ({
    update: function(delta) {
      console.log('updating');
      return update.__super__.constructor.call(this, delta);
    }
  });
  return this;
};
__extends(HuntScene, XCScene);