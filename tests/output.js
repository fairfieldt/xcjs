var onLoad;
onLoad = function() {
  var cs, sprite1, sprite2;
  sprite1 = new XCSpriteNode('resources/man.png', 34, 48);
  sprite2 = new XCSpriteNode('resources/man.png', 34, 48);
  cs = xc.getCurrentScene();
  cs.addChild(sprite1);
  sprite1.addChild(sprite2);
  sprite2.moveTo(60, 0);
  return sprite1.moveTo(160, 240);
};