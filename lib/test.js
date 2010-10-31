
function onLoad() 
{
  var sprite1 = new XCSpriteNode('man.png');
  var scene = xc.getCurrentScene();
  scene.addChild(sprite1);
  sprite1.moveTo(160, 240);
  var moveBy = new XCMoveBy(2.0, 160, -40);
  sprite1.runAction(moveBy);
  xc.addEventListener('tapDown', scene);
};