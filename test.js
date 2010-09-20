var onLoad;
onLoad = function() {
  var currentScene, i, man, man2, men, moveIt, t, x, x2, y, y2;
  currentScene = xc.getCurrentScene();
  i = 1;
  men = [];
  while (i > 0) {
    x = Math.floor(Math.random() * 640);
    y = Math.floor(Math.random() * 480);
    x2 = Math.floor(Math.random() * 640);
    y2 = Math.floor(Math.random() * 480);
    man = new XCSpriteNode('bob.png', 34, 48);
    console.log(x2 + ' ' + y2);
    currentScene.addChild(man);
    man.moveTo(320, 240);
    men.push(man);
    i--;
  }
  t = new XCTextNode("Hello, World!!!", "bold 36px sans-serif");
  man.addChild(t);
  t.moveTo(32, 10);
  man2 = new XCSpriteNode('bob.png', 34, 48);
  man2.moveTo(50, 50);
  currentScene.addChild(man2);
  t.onUpdate = function(dt) {
    return this.rotateBy(.2);
  };
  moveIt = new XCMoveTo(2.0, 320, 240);
  man2.runAction(moveIt);
  currentScene.keyDown = function(event) {};
  return xc.addEventListener("keyDown", currentScene);
};