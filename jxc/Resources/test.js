xc_init = function()
{
	xc = new xc();
	root = new XCNode();
	bob = new XCSpriteNode('bob.png');
	bob.onUpdate = function(delta) {};
	bob.tapDown = function(event) {
		return true;
	};
	bob.tapMoved = function(event) {
		
		return this.moveBy(event.moveX, event.moveY);
	};
	bob.tapUp = function(event) {
		return this.scaleBy(1.5);
	};
	xc.addEventListener('tapMoved', bob);
	xc.addEventListener('tapDown', bob);
	xc.addEventListener('tapUp', bob);
	bad = new XCEvent('doesntExist');
	xc.dispatchEvent(bad);
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
	man2.moveTo(300, 200);
	root.addChild(bob);
	bob.moveBy(60, 60);

	bob.addChild(man2);
	date = new Date();
	previousTime = date.getTime();
	
	for (i = 0; i < 10; i++)
	{
		for (j = 0; j < 10; j++)
		{
			var m = new XCSpriteNode('bob.png');
			root.addChild(m);
			m.moveTo(i * 32, j * 32);
		}
	}
	xc.draw(root);
}

handle_input = function() {
	var tap = xc_get_tap();
	while (tap != null)
	{
		xc_print(tap.type);
		var t;
		if (tap.type == 0)
		{
			t = new XCTapDownEvent(tap.x, tap.y, tap.number);
		}
		else if (tap.type == 1)
		{
			xc_print(tap.moveX + " " + tap.moveY);
			t = new XCTapMovedEvent(tap.x, tap.y, tap.moveX, tap.moveY, tap.number);
		}
		else
		{
			t = new XCTapUpEvent(tap.x, tap.y, tap.number)
		}
		
		xc.dispatchEvent(t);
		tap = xc_get_tap();
	}
}
	xc_update = function() {
	  var currentTime, delta;
	  currentTime = new Date().getTime();
		delta = 1;//currentTime - previousTime;
	  previousTime = currentTime;
		handle_input();
	  root.update(delta);
	 // return xc.draw(root);
	};
