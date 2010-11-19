
function onLoad() 
{
  var sprite1 = new XCSpriteNode('man.png');
  var scene = xc.getCurrentScene();
  scene.addChild(sprite1);
  sprite1.moveTo(160, 240);
  var moveBy = new XCMoveByAction(2.0, 160, -40);
  sprite1.runAction(moveBy);
  xc.addEventListener('tapDown', scene);

  var s = new XCScaleToAction(2.0, {x:2.0, y:1.0});
  sprite1.runAction(s);
  var t = new XCRotateByAction(2.0, 45.0);
  sprite1.runAction(t);
};