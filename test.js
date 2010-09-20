var onLoad;
onLoad = function() {
  var currentScene, man, moveIt, t;
  currentScene = xc.getCurrentScene();
  man = new XCSpriteNode('bob.png', 34, 48);
  currentScene.addChild(man);
  man.tapDown = function(event) {
    var x, y;
    x = event.x;
    y = event.y;
    return this.moveTo(x, y);
  };
  moveIt = new XCMoveBy(1.0, -300, 30);
  man.runAction(moveIt);
  xc.addEventListener("tapDown", man);
  man.moveTo(320, 240);
  t = new XCTextNode("Hello, World!!!", "bold 36px sans-serif");
  man.addChild(t);
  t.moveTo(32, 10);
  return (t.onUpdate = function(dt) {
    return this.rotateBy(.2);
  });
};