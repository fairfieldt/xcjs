function main()
{
	var scene = xc.getCurrentScene();

	var x = new XCSpriteNode('man.png');
	scene.addChild(x);

	x.moveTo(160, 240);
}	
