var MAXSPEED = 200;
var LETTERS = ['a','b','c','d','e','f','g','h','i','j','l',
			'm','n','o','p','q','r','s','t','u','v','w','x','y','z'];

var LETTERCOUNT = 32;

var BRICKSIZE = 24;
var ROWS = 10;
var COLS = 10;
var PADDING = 2;

function main()
{
	var scene = makeBPBScene(xc.getCurrentScene());

	scene.ball = scene.newBall(100, 380);

	scene.playing = false;
	var paddle = scene.newPaddle(160, 470);
	
	scene.addBricks();
	
	scene.newLettersDisplay(10, 10);
	
	var fps = new XCTextNode('', 'Helvetica', 14);
	//scene.addChild(fps);
	var a = new XCAction('FPSAction');
	a.tick = function(dt)
	{
		this.owner.setText('' + 1 / dt);
		return true;
	}
	fps.runAction(a);
	fps.moveTo(305, 15);
	scene.tapDown = function()
	{
		if (!this.playing)
		{
			this.ball.start();
			this.playing = true;
		}
	}
	xc.addEventListener('tapDown', scene);
	
	scene.BallDiedEvent = function(event)
	{
		this.ball = this.newBall(160, 380);
		this.playing = false;
	}
	xc.addEventListener('BallDiedEvent', scene);
	
	scene.LetterAddEvent = function(event)
	{
		this.addLetter(event.letter);
	}
	xc.addEventListener('LetterAddEvent', scene);
}	

function makeBPBScene(scene)
{
	scene.newBall = newBall;
	scene.newPaddle = newPaddle;
	scene.newBrick = newBrick;
	scene.addBricks = addBricks;
	scene.addLetter = addLetter;
	scene.newLettersDisplay = newLettersDisplay;
	scene.letters = []
	

	return scene;
}

function newLettersDisplay(x, y)
{
	this.lettersDisplay = new XCTextNode('', 'Helvetica', 12);
	this.addChild(this.lettersDisplay);
	this.lettersDisplay.moveTo(x, y);
	this.lettersDisplay.setAnchorX(0);

}
function addLetter(letter)
{
	this.letters.push(letter)
	this.lettersDisplay.setText(this.lettersDisplay.text() + ' ' + letter);
}

function addBricks()
{
	var letterSpots = [];
	for (var i = 0; i < LETTERCOUNT; i++)
	{
		letterSpots.push(true);
	}
	for (var i = 0; i < ROWS * COLS - LETTERCOUNT; i++)
	{
		letterSpots.push(false);
	}
	letterSpots.sort(function() {return (Math.round(Math.random())-.5);});
	var letterCount = 0;
	for (var i = 0; i < COLS; i++)
	{
		var y = 109 + (BRICKSIZE * i) + (PADDING * i+1);
		for (var j = 0; j < ROWS; j++)
		{
			var x = 41 + (BRICKSIZE * j) + (PADDING * j+1);
			var isLetter = letterSpots[letterCount++];
			this.newBrick(x, y, isLetter);
		}
	}
}

function newBall(x, y)
{
	var ball = new XCSpriteNode('ball.png');
	this.addChild(ball);
	this.addCollisionNode(ball, 'brick');
	ball.moveTo(x, y);
	
	
	ball.dX =  MAXSPEED * .8;
	ball.dY = -MAXSPEED;
	var action = getBallMoveAction();

	
	ball.tag = 'ball';
	
	ball.start = function()
	{
		this.runAction(action);
	}
	
	ball.collidesWith = function(rect)
	{
		var point1 = {x:rect.x, y:rect.y};
		var point2 = {x:rect.x + rect.w, y:rect.y};
		var point3 = {x:rect.x + rect.w, y:rect.y + rect.h};
		var point4 = {x:rect.x, y:rect.y + rect.h};
		
		var circle = {x:this.X(), y:this.Y(), r:this.width()/2.1};
		
		var collided =  xc.circleContainsPoint(circle, point1)  ||
				xc.circleContainsPoint(circle, point2) ||
				xc.circleContainsPoint(circle, point3) ||
				xc.circleContainsPoint(circle, point4);
		return collided;
	}
	
	ball.movingTowards = function(rect)
	{
		var directionX = this.dX > 0 ? 1 : -1;
		var directionY = this.dY > 0 ? 1 : -1;

		var farCornerX = directionX == 1 ? rect.x + rect.w : rect.x;
		var farCornerY = directionY == 1 ? rect.y + rect.h : rect.y;
		var movingToward = (this.X()-farCornerX)/directionX < 0 && (this.Y()-farCornerY)/directionY < 0;

		
		return movingToward;
	}
	
	ball.CollisionEvent = function(event)
	{
		var brick = event.node;
		if (this.movingTowards(brick.rect()) && this.collidesWith(brick.rect()))
		{
			if (brick.isLetter)
			{
				this.parent().removeChild(brick.letter);
				var letterAddEvent = new XCEvent('LetterAddEvent');
				letterAddEvent.letter = brick.l;
				xc.dispatchEvent(letterAddEvent);
			}
			this.parent().removeChild(brick);
			//now figure out whether to reverse the x or y direction of the ball
			var rect = brick.rect();
			var directionY = ball.dY > 0 ? 1 : -1;

			var nearCornerY = directionY == -1 ? rect.y + rect.h : rect.y;
			//fudge it a little by adding/subtracting 2
			nearCornerY += 2 * directionY;
			//if the ball is hitting the side, reverse x	
			//otherwise reverse y
			if ((this.Y() - nearCornerY) * directionY < 0)
			{
				this.dY = -this.dY
			}
			else
			{
				this.dX = -this.dX;
			}
		}
	}
	ball.die = function()
	{
		this.parent().removeChild(this);
	}
	
	return ball;
}

function newBrick(x, y, isLetter)
{
	var brick = new XCSpriteNode('brick.png');
	brick.isLetter = isLetter;
	brick.tag = 'brick'
	brick.moveTo(x, y);

	this.addChild(brick);
	if (isLetter)
	{
		var choice = Math.floor((Math.random() * 1000) % 25)
		var l = LETTERS[choice];
		var letter = new XCTextNode(l, 'Arial', 12);
		letter.setColor(new XCColor(0xFF, 0xFF, 0xFF));
		letter.moveTo(x, y);
		this.addChild(letter);
		brick.letter = letter;
		brick.l = l;
	}
	return brick;
}

function newPaddle(x, y)
{
	var paddle = new XCSpriteNode('paddle.png');
	this.addChild(paddle);
	paddle.moveTo(x, y);
	this.addCollisionNode(paddle, 'ball')
	paddle.tapMoved = function(event)
	{
		var x = event.move.x;
		
		if (this.X() + x > 0 && this.X() + x < 320)
		{
			this.moveBy(x, 0);
		}
	}
	xc.addEventListener('tapMoved', paddle);
	
	paddle.CollisionEvent = function(event)
	{
		console.log('a hit');
		var ball = event.node;
		if (ball.collidesWith(this.rect()))
		{
			console.log('bam');
			ball.dY = 0 - ball.dY;

			
			//if the ball is in the middle of the paddle,
			// make dx 0.  The biggest dx it can have is 200,
			// which is at the end of the paddle that it's moving 
			//away from.
			var distanceFromCenter = ball.X() - this.X();

			//positive to the left, negative to the right.
			var ratio = distanceFromCenter / this.width() * 2;
			
			var velocity = ball.dX;
			
			var newVelocity = velocity + (ratio * MAXSPEED);

			if (newVelocity > MAXSPEED)
			{
				newVelocity = MAXSPEED;
			}
			if (newVelocity < -MAXSPEED)
			{
				newVelocity = -MAXSPEED;
			}

			ball.dX = newVelocity;
		}

	}
	return paddle;
}

function getBallMoveAction()
{
	var moveAction = new XCAction('BallMoveAction');

	moveAction.tick = function(dt)
	{
		var moveX = this.owner.dX * dt;
		var moveY = this.owner.dY * dt;
				
		if (this.owner.X() + moveX > 320 && moveX > 0 ||
		 (this.owner.X() - moveX < 1 && moveX < 0))
		{
			moveX = 0 - moveX;
			this.owner.dX = 0 - this.owner.dX;
		}
		
		if (this.owner.Y() - moveY < 1 && moveY < 0) 
		{
			moveY = 0 - moveY;
			this.owner.dY = 0 - this.owner.dY;
		}
		else if (this.owner.Y() + moveY > 480 && moveY > 0)
		{
			//die
			xc.dispatchEvent(new XCEvent('BallDiedEvent'));
			this.owner.die();
		}
		this.owner.moveBy(moveX, moveY);
		return true;
	}
	
	return moveAction;
}
