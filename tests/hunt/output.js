var Alien, DPad, GridEntity, HuntScene, LifeCounter, Man, Map, ScoreCounter, Timer, addDPad, addLifeCounter, addScoreCounter, addTimer, onLoad;
var __extends = function(child, parent) {
    var ctor = function(){};
    ctor.prototype = parent.prototype;
    child.prototype = new ctor();
    child.prototype.constructor = child;
    if (typeof parent.extended === "function") parent.extended(child);
    child.__super__ = parent.prototype;
  };
Timer = function(startTime) {
  var minuteString, minutes, secondString, seconds, timerAction;
  Timer.__super__.constructor.call(this);
  this.time = startTime;
  minutes = this.time / 60;
  seconds = this.time % 60;
  minuteString = minutes >= 10 ? '' + minutes : '0' + minutes;
  secondString = seconds >= 10 ? '' + seconds : '0' + seconds;
  this.text = new XCTextNode(minuteString + ':' + secondString, 'Helvetica', 14);
  this.addChild(this.text);
  this.text.moveTo(10, 340);
  timerAction = new XCAction('TimerActin');
  timerAction.time = this.time;
  timerAction.tick = function(dt) {
    var displayTime;
    this.time -= dt;
    if (Math.ceil(this.time) < 0) {
      this.time = this.owner.time;
      xc.dispatchEvent(new XCEvent('TimerEvent'));
    }
    displayTime = Math.ceil(this.time) >= 10 ? Math.ceil(this.time) : '0' + Math.ceil(this.time);
    minutes = Math.floor(displayTime / 60);
    seconds = displayTime % 60;
    minuteString = minutes >= 10 ? '' + minutes : '0' + minutes;
    secondString = seconds >= 10 ? '' + seconds : '0' + seconds;
    return this.owner.text.setText(minuteString + ':' + secondString);
  };
  this.runAction(timerAction);
  return this;
};
__extends(Timer, XCNode);
onLoad = function() {
  var currentScene;
  xc.replaceScene(new HuntScene());
  currentScene = xc.getCurrentScene();
  addTimer(currentScene);
  addDPad(currentScene);
  addLifeCounter(currentScene);
  return addScoreCounter(currentScene);
};
addLifeCounter = function(scene) {
  var lifeCounter;
  lifeCounter = new LifeCounter(3);
  lifeCounter.ManDied = function(event) {
    console.log('man died');
    return this.removeLife();
  };
  xc.addEventListener('ManDied', lifeCounter);
  return scene.addChild(lifeCounter);
};
addScoreCounter = function(scene) {
  var scoreCounter;
  scoreCounter = new ScoreCounter();
  xc.addEventListener('ScoredPoints', scoreCounter);
  return scene.addChild(scoreCounter);
};
addTimer = function(scene) {
  var timer;
  timer = new Timer(700);
  return scene.addChild(timer);
};
addDPad = function(scene) {
  var dpad;
  dpad = new DPad();
  scene.addChild(dpad);
  dpad.moveTo(320 - 96, 384);
  dpad.tapUp = function(event) {
    var moveInput;
    moveInput = new XCAction('MoveEvent');
    moveInput.direction = 'none';
    return xc.dispatchEvent(moveInput);
  };
  dpad.tapDown = function(event) {
    return this.handleTap(event);
  };
  dpad.tapMoved = function(event) {
    return this.handleTap(event);
  };
  dpad.handleTap = function(event) {
    var direction, moveInput;
    direction = this.directionPushed(event.x, event.y);
    moveInput = new XCAction('MoveEvent');
    moveInput.direction = direction;
    return xc.dispatchEvent(moveInput);
  };
  xc.addEventListener('tapUp', dpad);
  xc.addEventListener('tapDown', dpad);
  return xc.addEventListener('tapMoved', dpad);
};
ScoreCounter = function() {
  ScoreCounter.__super__.constructor.call(this);
  this.scoreLabel = new XCTextNode('Score: 0', 'Helvetica', 12);
  this.score = 0;
  this.addChild(this.scoreLabel);
  this.scoreLabel.moveTo(10, 390);
  return this;
};
__extends(ScoreCounter, XCNode);
ScoreCounter.prototype.addScore = function(amount) {
  var newText;
  this.score += amount;
  newText = 'Score: ' + this.score;
  return this.scoreLabel.setText(newText);
};
ScoreCounter.prototype.ScoredPoints = function(event) {
  return this.addScore(event.points);
};
Timer = function(startTime) {
  var minuteString, minutes, secondString, seconds, timerAction;
  Timer.__super__.constructor.call(this);
  this.time = startTime;
  minutes = this.time / 60;
  seconds = this.time % 60;
  minuteString = minutes >= 10 ? '' + minutes : '0' + minutes;
  secondString = seconds >= 10 ? '' + seconds : '0' + seconds;
  this.text = new XCTextNode(minuteString + ':' + secondString, 'Helvetica', 14);
  this.addChild(this.text);
  this.text.moveTo(10, 340);
  timerAction = new XCAction('TimerActin');
  timerAction.time = this.time;
  timerAction.tick = function(dt) {
    var displayTime;
    this.time -= dt;
    if (Math.ceil(this.time) < 0) {
      this.time = this.owner.time;
      xc.dispatchEvent(new XCEvent('TimerEvent'));
    }
    displayTime = Math.ceil(this.time) >= 10 ? Math.ceil(this.time) : '0' + Math.ceil(this.time);
    minutes = Math.floor(displayTime / 60);
    seconds = displayTime % 60;
    minuteString = minutes >= 10 ? '' + minutes : '0' + minutes;
    secondString = seconds >= 10 ? '' + seconds : '0' + seconds;
    return this.owner.text.setText(minuteString + ':' + secondString);
  };
  this.runAction(timerAction);
  return this;
};
__extends(Timer, XCNode);
ScoreCounter = function() {
  ScoreCounter.__super__.constructor.call(this);
  this.scoreLabel = new XCTextNode('Score: 0', 'Helvetica', 12);
  this.score = 0;
  this.addChild(this.scoreLabel);
  this.scoreLabel.moveTo(10, 390);
  return this;
};
__extends(ScoreCounter, XCNode);
ScoreCounter.prototype.addScore = function(amount) {
  var newText;
  this.score += amount;
  newText = 'Score: ' + this.score;
  return this.scoreLabel.setText(newText);
};
ScoreCounter.prototype.ScoredPoints = function(event) {
  return this.addScore(event.points);
};
Map = function() {
  Map.__super__.constructor.call(this);
  this.loadMap();
  return this;
};
__extends(Map, XCNode);
Map.prototype.loadMap = function() {
  var _ref, _ref2, _result, _result2, empty, fileName, i, map, type, x, y;
  map = [];

		map.width = 20
		map.height = 20
		map.tileSize = 16
		map.tiles= [
			['#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#',],
			['#','.','.','.','.','.','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','@','@','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','@','@','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','@','@','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','@','@','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','@','@','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','.','.','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','.','.','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','.','.','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','.','.','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','@','@','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','@','@','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','.','.','.','.','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','@','@','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','@','@','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','@','@','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','@','@','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','@','@','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#',],
			]
	;
  this.width = map.width;
  this.height = map.height;
  this.gridSize = 16;
  this.tiles = new Array(this.width);
  _ref = this.width;
  for (i = 0; (0 <= _ref ? i <= _ref : i >= _ref); (0 <= _ref ? i += 1 : i -= 1)) {
    this.tiles[i] = new Array(this.height);
  }
  _result = []; _ref = this.width;
  for (x = 0; (0 <= _ref ? x < _ref : x > _ref); (0 <= _ref ? x += 1 : x -= 1)) {
    _result.push((function() {
      _result2 = []; _ref2 = this.height;
      for (y = 0; (0 <= _ref2 ? y < _ref2 : y > _ref2); (0 <= _ref2 ? y += 1 : y -= 1)) {
        _result2.push((function() {
          type = map.tiles[y][x];
          fileName = "";
          if (type === "#") {
            console.log('a wall');
            fileName = "resources/grave.png";
          } else if (type === "@") {
            fileName = "resources/pumpkin.png";
          }
          if (fileName !== "") {
            console.log(x + ' ' + y);
            return (this.tiles[x][y] = new GridEntity(fileName, this, type, x, y));
          } else {
            empty = [];
            empty.type = "empty";
            return (this.tiles[x][y] = "empty");
          }
        }).call(this));
      }
      return _result2;
    }).call(this));
  }
  return _result;
};
Map.prototype.moveableBlock = function(block) {
  return block.type !== '#';
};
Map.prototype.getFreeSpace = function() {
  var x, y;
  x = Math.floor(Math.random() * this.width);
  y = Math.floor(Math.random() * this.height);
  console.log(x + ' ' + y);
  while (this.tiles[x][y] !== 'empty') {
    x = Math.floor(Math.random() * this.width);
    y = Math.floor(Math.random() * this.height);
  }
  return {
    x: x,
    y: y
  };
};
GridEntity = function(imageName, _arg, _arg2, _arg3, _arg4) {
  this.gridY = _arg4;
  this.gridX = _arg3;
  this.type = _arg2;
  this.map = _arg;
  GridEntity.__super__.constructor.call(this, imageName, this.map.gridSize, this.map.gridSize);
  this.setX(this.gridX * this.map.gridSize);
  this.setY(this.gridY * this.map.gridSize);
  this.map.addChild(this);
  return this;
};
__extends(GridEntity, XCSpriteNode);
GridEntity.prototype.gridMove = function(x, y) {
  this.map.tiles[this.gridX][this.gridY] = "empty";
  this.map.tiles[this.gridX + x][this.gridY + y] = this;
  this.moveBy(x * this.map.gridSize, y * this.map.gridSize);
  this.gridX += x;
  return this.gridY += y;
};
Man = function(map, x, y) {
  var moveAction;
  Man.__super__.constructor.call(this, 'resources/dude.png', map, "$", x, y);
  this.direction = {
    'up': [-0, -1],
    down: [0, 1],
    'left': [-1, 0],
    'right': [1, 0]
  };
  this.moveDirection = 'none';
  moveAction = new XCAction('ManMoveAction');
  moveAction.delay = 0;
  moveAction.tick = function(dt) {
    this.delay -= dt;
    if (this.owner.moveDirection !== 'none' && (this.delay <= 0)) {
      if (this.owner.movedBlocks(this.owner.moveDirection)) {
        this.owner.gridMove(this.owner.direction[this.owner.moveDirection][0], this.owner.direction[this.owner.moveDirection][1]);
        return (this.delay = .2);
      }
    }
  };
  this.runAction(moveAction);
  xc.addEventListener('MoveEvent', this);
  return this;
};
__extends(Man, GridEntity);
Man.prototype.movedBlocks = function(direction) {
  if (direction === "left") {
    return this.horizontalMove(-1);
  } else if (direction === "right") {
    return this.horizontalMove(1);
  } else if (direction === "up") {
    return this.verticalMove(-1);
  } else if (direction === "down") {
    return this.verticalMove(1);
  }
};
Man.prototype.horizontalMove = function(direction) {
  var block, currentX, y;
  currentX = this.gridX;
  y = this.gridY;
  block = this.map.tiles[currentX + direction][y];
  while (block !== "empty") {
    if (!this.map.moveableBlock(block)) {
      return false;
    } else {
      currentX += direction;
      block = this.map.tiles[currentX + direction][y];
    }
  }
  while ((currentX < this.gridX && direction === -1) || (currentX > this.gridX && direction === 1)) {
    if (this.map.tiles[currentX + direction][y] !== "empty") {
      console.log("BAD LOGIC");
    }
    this.map.tiles[currentX][y].gridMove(direction, 0);
    currentX -= direction;
  }
  return true;
};
Man.prototype.verticalMove = function(direction) {
  var block, currentY, x;
  currentY = this.gridY;
  x = this.gridX;
  block = this.map.tiles[x][currentY + direction];
  while (block !== "empty") {
    if (!this.map.moveableBlock(block)) {
      return false;
    } else {
      currentY += direction;
      block = this.map.tiles[x][currentY + direction];
    }
  }
  while ((currentY < this.gridY && direction === -1) || (currentY > this.gridY && direction === 1)) {
    if (this.map.tiles[x][currentY + direction] !== "empty") {
      console.log("BAD LOGIC");
    }
    this.map.tiles[x][currentY].gridMove(0, direction);
    currentY -= direction;
  }
  return true;
};
Man.prototype.die = function() {
  var newPos;
  xc.dispatchEvent(new XCEvent('ManDied'));
  newPos = this.map.getFreeSpace();
  return this.gridMove(newPos.x - this.gridX, newPos.y - this.gridY);
};
Man.prototype.MoveEvent = function(event) {
  return (this.moveDirection = event.direction);
};
LifeCounter = function(_arg) {
  var lifeString;
  this.lifeCount = _arg;
  LifeCounter.__super__.constructor.call(this);
  this.man = new XCSpriteNode('resources/dude.png', 16, 16);
  this.addChild(this.man);
  this.man.moveTo(10, 352);
  lifeString = 'x' + this.lifeCount;
  this.lifeCounter = new XCTextNode(lifeString, 'Helvetica', 12);
  this.addChild(this.lifeCounter);
  this.lifeCounter.moveTo(30, 365);
  return this;
};
__extends(LifeCounter, XCNode);
LifeCounter.prototype.addLife = function() {
  this.lifeCount += 1;
  return this.update();
};
LifeCounter.prototype.removeLife = function() {
  this.lifeCount -= 1;
  this.update();
  return this.lifeCount <= 0 ? xc.dispatchEvent(new XCEvent('GameOver')) : null;
};
LifeCounter.prototype.update = function() {
  var lifeString;
  lifeString = 'x' + this.lifeCount;
  return this.lifeCounter.setText(lifeString);
};
HuntScene = function() {
  var bg, man, monsterTick;
  this.i = 1;
  HuntScene.__super__.constructor.call(this);
  bg = new XCSpriteNode('resources/background.png', 320, 480);
  this.addChild(bg);
  bg.moveTo(0, 0);
  this.map = new Map();
  this.addChild(this.map);
  this.monsters = [];
  man = new Man(this.map, 6, 2);
  this.map.man = man;
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
  xc.addEventListener("TimerEvent", this);
  xc.addEventListener('GameOver', this);
  xc.addEventListener('MonsterSleep', this);
  monsterTick = new XCAction("MonsterTick");
  monsterTick.et = 0;
  monsterTick.tick = function(dt) {
    this.et += dt;
    if (this.et >= 1.0) {
      xc.dispatchEvent(new XCEvent('MonsterTick'));
      return (this.et = 0);
    }
  };
  this.runAction(monsterTick);
  this.spawnMonster();
  return this;
};
__extends(HuntScene, XCSceneNode);
HuntScene.prototype.TimerEvent = function(event) {
  return this.spawnMonster();
};
HuntScene.prototype.spawnMonster = function() {
  var coordinates, monster;
  coordinates = this.map.getFreeSpace();
  monster = new Alien(this.map, coordinates.x, coordinates.y);
  monster.name = this.i++;
  return this.monsters.push(monster);
};
HuntScene.prototype.GameOver = function(event) {
  var gameOverMessage;
  xc.getCurrentScene().pause();
  gameOverMessage = new XCTextNode('Game Over', 'Helvetica', 16);
  gameOverMessage.setColor(new XCColor(0, 0, 0));
  gameOverMessage.setAnchorX(.5);
  gameOverMessage.setAnchorY(.5);
  this.addChild(gameOverMessage);
  return gameOverMessage.moveTo(160, 240);
};
HuntScene.prototype.MonsterSleep = function(event) {
  var _i, _len, _ref, _result, allAsleep, candy, monster, x, y;
  allAsleep = true;
  _ref = this.monsters;
  for (_i = 0, _len = _ref.length; _i < _len; _i++) {
    monster = _ref[_i];
    if (!monster.asleep) {
      allAsleep = false;
      break;
    }
  }
  if (allAsleep) {
    xc.dispatchEvent(new XCEvent('SpawnMonstersEvent'));
    _result = []; _ref = this.monsters;
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      monster = _ref[_i];
      _result.push((function() {
        x = monster.gridX;
        y = monster.gridY;
        this.map.removeChild(monster);
        candy = new GridEntity('resources/candy.png', this.map, 'candy', x, y);
        return candy.gridMove(0, 0);
      }).call(this));
    }
    return _result;
  }
};
DPad = function() {
  DPad.__super__.constructor.call(this, 'resources/dpad.png', 96, 96);
  xc.addEventListener('tapDown', this);
  return this;
};
__extends(DPad, XCSpriteNode);
DPad.prototype.tapDown = function(event) {
  var x, y;
  x = event.x;
  y = event.y;
  return event.x > 320 - 96 && event.x < 320 && event.y > 384 && event.y < 480 ? console.log('this tap belongs to me') : null;
};
DPad.prototype.directionPushed = function(x, y) {
  var direction;
  x = x - this.X();
  y = y - this.Y();
  console.log(this.X() + ' ' + this.Y());
  console.log(x + ' ' + y);
  direction = "none";
  if (x > 0 && x < 48 && y > 24 && y < 72) {
    direction = "left";
  } else if (x > 48 && x < 96 && y > 24 && y < 72) {
    direction = "right";
  } else if (x > 24 && x < 72 && y > 0 && y < 48) {
    direction = "up";
  } else if (x > 24 && x < 72 && y > 48 && y < 96) {
    direction = "down";
  }
  return direction;
};
Alien = function(map, x, y) {
  Alien.__super__.constructor.call(this, 'resources/ghost.png', map, 'x', x, y);
  this.asleep = false;
  xc.addEventListener('MonsterTick', this);
  return this;
};
__extends(Alien, GridEntity);
Alien.prototype.move = function() {
  var _i, _len, _ref, move, moved, orderedMoves, x, y;
  x = this.map.man.gridX - this.gridX;
  y = this.map.man.gridY - this.gridY;
  if (x > 0) {
    x = 1;
  } else if (x < 0) {
    x = -1;
  }
  if (y > 0) {
    y = 1;
  } else if (y < 0) {
    y = -1;
  }
  orderedMoves = this.getOrderedMoves(x, y);
  moved = false;
  _ref = orderedMoves;
  for (_i = 0, _len = _ref.length; _i < _len; _i++) {
    move = _ref[_i];
    x = move[0];
    y = move[1];
    if (this.validMove(x, y)) {
      this.gridMove(x, y);
      moved = true;
      this.alseep = false;
      if (this.gridX === this.map.man.gridX && this.gridY === this.map.man.gridY) {
        this.map.man.die();
      }
      break;
    }
  }
  if (!moved && !this.alseep) {
    xc.dispatchEvent(new XCEvent("MonsterSleep"));
    return (this.asleep = true);
  }
};
Alien.prototype.getOrderedMoves = function(x, y) {
  var moves;
  if (x === -1 && y === -1) {
    moves = [[-1, -1], [-1, 0], [0, -1], [-1, 1], [1, -1], [0, 0]];
  } else if (x === 0 && y === -1) {
    moves = [[0, -1], [1, -1], [-1, -1], [-1, 0], [1, 0], [0, 0]];
  } else if (x === 1 && y === -1) {
    moves = [[1, -1], [1, 0], [0, -1], [1, 1], [-1, -1], [0, 0]];
  } else if (x === 1 && y === 0) {
    moves = [[1, 0], [1, 1], [1, -1], [0, 1], [0, -1], [0, 0]];
  } else if (x === -1 && y === 0) {
    moves = [[-1, 0], [-1, 1], [-1, -1], [0, -1], [0, 1], [0, 0]];
  } else if (x === 1 && y === 0) {
    moves = [[1, 0], [1, 1], [1, -1], [0, 1], [0, -1], [0, 0]];
  } else if (x === -1 && y === 1) {
    moves = [[-1, 1], [0, 1], [-1, 0], [1, 1], [-1, -1], [0, 0]];
  } else if (x === 0 && y === 1) {
    moves = [[0, 1], [1, 1], [-1, 1], [-1, 0], [0, 1], [0, 0]];
  } else if (x === 1 && y === 1) {
    moves = [[1, 1], [0, 1], [1, 0], [-1, 1], [1, -1], [0, 0]];
  } else {
    moves = [[0, 0]];
  }
  return moves;
};
Alien.prototype.validMove = function(x, y) {
  if (this.map.tiles[this.gridX + x][this.gridY + y] === "empty" || this.map.tiles[this.gridX + x][this.gridY + y].type === "$") {
    return true;
  } else {
    return false;
  }
};
Alien.prototype.MonsterTick = function(event) {
  console.log('Monster ' + this.name + ' moving!');
  this.move();
  return false;
};
Map = function() {
  Map.__super__.constructor.call(this);
  this.loadMap();
  return this;
};
__extends(Map, XCNode);
Map.prototype.loadMap = function() {
  var _ref, _ref2, _result, _result2, empty, fileName, i, map, type, x, y;
  map = [];

		map.width = 20
		map.height = 20
		map.tileSize = 16
		map.tiles= [
			['#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#',],
			['#','.','.','.','.','.','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','@','@','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','@','@','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','@','@','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','@','@','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','@','@','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','.','.','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','.','.','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','.','.','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','.','.','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','@','@','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','@','@','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','.','.','.','.','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','@','@','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','@','@','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','@','@','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','@','@','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','.','@','@','@','@','.','.','.','.','.','.','.','.','.','.','.','.','.','#',],
			['#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#','#',],
			]
	;
  this.width = map.width;
  this.height = map.height;
  this.gridSize = 16;
  this.tiles = new Array(this.width);
  _ref = this.width;
  for (i = 0; (0 <= _ref ? i <= _ref : i >= _ref); (0 <= _ref ? i += 1 : i -= 1)) {
    this.tiles[i] = new Array(this.height);
  }
  _result = []; _ref = this.width;
  for (x = 0; (0 <= _ref ? x < _ref : x > _ref); (0 <= _ref ? x += 1 : x -= 1)) {
    _result.push((function() {
      _result2 = []; _ref2 = this.height;
      for (y = 0; (0 <= _ref2 ? y < _ref2 : y > _ref2); (0 <= _ref2 ? y += 1 : y -= 1)) {
        _result2.push((function() {
          type = map.tiles[y][x];
          fileName = "";
          if (type === "#") {
            console.log('a wall');
            fileName = "resources/grave.png";
          } else if (type === "@") {
            fileName = "resources/pumpkin.png";
          }
          if (fileName !== "") {
            console.log(x + ' ' + y);
            return (this.tiles[x][y] = new GridEntity(fileName, this, type, x, y));
          } else {
            empty = [];
            empty.type = "empty";
            return (this.tiles[x][y] = "empty");
          }
        }).call(this));
      }
      return _result2;
    }).call(this));
  }
  return _result;
};
Map.prototype.moveableBlock = function(block) {
  return block.type !== '#';
};
Map.prototype.getFreeSpace = function() {
  var x, y;
  x = Math.floor(Math.random() * this.width);
  y = Math.floor(Math.random() * this.height);
  console.log(x + ' ' + y);
  while (this.tiles[x][y] !== 'empty') {
    x = Math.floor(Math.random() * this.width);
    y = Math.floor(Math.random() * this.height);
  }
  return {
    x: x,
    y: y
  };
};
GridEntity = function(imageName, _arg, _arg2, _arg3, _arg4) {
  this.gridY = _arg4;
  this.gridX = _arg3;
  this.type = _arg2;
  this.map = _arg;
  GridEntity.__super__.constructor.call(this, imageName, this.map.gridSize, this.map.gridSize);
  this.setX(this.gridX * this.map.gridSize);
  this.setY(this.gridY * this.map.gridSize);
  this.map.addChild(this);
  return this;
};
__extends(GridEntity, XCSpriteNode);
GridEntity.prototype.gridMove = function(x, y) {
  this.map.tiles[this.gridX][this.gridY] = "empty";
  this.map.tiles[this.gridX + x][this.gridY + y] = this;
  this.moveBy(x * this.map.gridSize, y * this.map.gridSize);
  this.gridX += x;
  return this.gridY += y;
};
Man = function(map, x, y) {
  var moveAction;
  Man.__super__.constructor.call(this, 'resources/dude.png', map, "$", x, y);
  this.direction = {
    'up': [-0, -1],
    down: [0, 1],
    'left': [-1, 0],
    'right': [1, 0]
  };
  this.moveDirection = 'none';
  moveAction = new XCAction('ManMoveAction');
  moveAction.delay = 0;
  moveAction.tick = function(dt) {
    this.delay -= dt;
    if (this.owner.moveDirection !== 'none' && (this.delay <= 0)) {
      if (this.owner.movedBlocks(this.owner.moveDirection)) {
        this.owner.gridMove(this.owner.direction[this.owner.moveDirection][0], this.owner.direction[this.owner.moveDirection][1]);
        return (this.delay = .2);
      }
    }
  };
  this.runAction(moveAction);
  xc.addEventListener('MoveEvent', this);
  return this;
};
__extends(Man, GridEntity);
Man.prototype.movedBlocks = function(direction) {
  if (direction === "left") {
    return this.horizontalMove(-1);
  } else if (direction === "right") {
    return this.horizontalMove(1);
  } else if (direction === "up") {
    return this.verticalMove(-1);
  } else if (direction === "down") {
    return this.verticalMove(1);
  }
};
Man.prototype.horizontalMove = function(direction) {
  var block, currentX, y;
  currentX = this.gridX;
  y = this.gridY;
  block = this.map.tiles[currentX + direction][y];
  while (block !== "empty") {
    if (!this.map.moveableBlock(block)) {
      return false;
    } else {
      currentX += direction;
      block = this.map.tiles[currentX + direction][y];
    }
  }
  while ((currentX < this.gridX && direction === -1) || (currentX > this.gridX && direction === 1)) {
    if (this.map.tiles[currentX + direction][y] !== "empty") {
      console.log("BAD LOGIC");
    }
    this.map.tiles[currentX][y].gridMove(direction, 0);
    currentX -= direction;
  }
  return true;
};
Man.prototype.verticalMove = function(direction) {
  var block, currentY, x;
  currentY = this.gridY;
  x = this.gridX;
  block = this.map.tiles[x][currentY + direction];
  while (block !== "empty") {
    if (!this.map.moveableBlock(block)) {
      return false;
    } else {
      currentY += direction;
      block = this.map.tiles[x][currentY + direction];
    }
  }
  while ((currentY < this.gridY && direction === -1) || (currentY > this.gridY && direction === 1)) {
    if (this.map.tiles[x][currentY + direction] !== "empty") {
      console.log("BAD LOGIC");
    }
    this.map.tiles[x][currentY].gridMove(0, direction);
    currentY -= direction;
  }
  return true;
};
Man.prototype.die = function() {
  var newPos;
  xc.dispatchEvent(new XCEvent('ManDied'));
  newPos = this.map.getFreeSpace();
  return this.gridMove(newPos.x - this.gridX, newPos.y - this.gridY);
};
Man.prototype.MoveEvent = function(event) {
  return (this.moveDirection = event.direction);
};
LifeCounter = function(_arg) {
  var lifeString;
  this.lifeCount = _arg;
  LifeCounter.__super__.constructor.call(this);
  this.man = new XCSpriteNode('resources/dude.png', 16, 16);
  this.addChild(this.man);
  this.man.moveTo(10, 352);
  lifeString = 'x' + this.lifeCount;
  this.lifeCounter = new XCTextNode(lifeString, 'Helvetica', 12);
  this.addChild(this.lifeCounter);
  this.lifeCounter.moveTo(30, 365);
  return this;
};
__extends(LifeCounter, XCNode);
LifeCounter.prototype.addLife = function() {
  this.lifeCount += 1;
  return this.update();
};
LifeCounter.prototype.removeLife = function() {
  this.lifeCount -= 1;
  this.update();
  return this.lifeCount <= 0 ? xc.dispatchEvent(new XCEvent('GameOver')) : null;
};
LifeCounter.prototype.update = function() {
  var lifeString;
  lifeString = 'x' + this.lifeCount;
  return this.lifeCounter.setText(lifeString);
};
HuntScene = function() {
  var bg, man, monsterTick;
  this.i = 1;
  HuntScene.__super__.constructor.call(this);
  bg = new XCSpriteNode('resources/background.png', 320, 480);
  this.addChild(bg);
  bg.moveTo(0, 0);
  this.map = new Map();
  this.addChild(this.map);
  this.monsters = [];
  man = new Man(this.map, 6, 2);
  this.map.man = man;
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
  xc.addEventListener("TimerEvent", this);
  xc.addEventListener('GameOver', this);
  xc.addEventListener('MonsterSleep', this);
  monsterTick = new XCAction("MonsterTick");
  monsterTick.et = 0;
  monsterTick.tick = function(dt) {
    this.et += dt;
    if (this.et >= 1.0) {
      xc.dispatchEvent(new XCEvent('MonsterTick'));
      return (this.et = 0);
    }
  };
  this.runAction(monsterTick);
  this.spawnMonster();
  return this;
};
__extends(HuntScene, XCSceneNode);
HuntScene.prototype.TimerEvent = function(event) {
  return this.spawnMonster();
};
HuntScene.prototype.spawnMonster = function() {
  var coordinates, monster;
  coordinates = this.map.getFreeSpace();
  monster = new Alien(this.map, coordinates.x, coordinates.y);
  monster.name = this.i++;
  return this.monsters.push(monster);
};
HuntScene.prototype.GameOver = function(event) {
  var gameOverMessage;
  xc.getCurrentScene().pause();
  gameOverMessage = new XCTextNode('Game Over', 'Helvetica', 16);
  gameOverMessage.setColor(new XCColor(0, 0, 0));
  gameOverMessage.setAnchorX(.5);
  gameOverMessage.setAnchorY(.5);
  this.addChild(gameOverMessage);
  return gameOverMessage.moveTo(160, 240);
};
HuntScene.prototype.MonsterSleep = function(event) {
  var _i, _len, _ref, _result, allAsleep, candy, monster, x, y;
  allAsleep = true;
  _ref = this.monsters;
  for (_i = 0, _len = _ref.length; _i < _len; _i++) {
    monster = _ref[_i];
    if (!monster.asleep) {
      allAsleep = false;
      break;
    }
  }
  if (allAsleep) {
    xc.dispatchEvent(new XCEvent('SpawnMonstersEvent'));
    _result = []; _ref = this.monsters;
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      monster = _ref[_i];
      _result.push((function() {
        x = monster.gridX;
        y = monster.gridY;
        this.map.removeChild(monster);
        candy = new GridEntity('resources/candy.png', this.map, 'candy', x, y);
        return candy.gridMove(0, 0);
      }).call(this));
    }
    return _result;
  }
};
DPad = function() {
  DPad.__super__.constructor.call(this, 'resources/dpad.png', 96, 96);
  xc.addEventListener('tapDown', this);
  return this;
};
__extends(DPad, XCSpriteNode);
DPad.prototype.tapDown = function(event) {
  var x, y;
  x = event.x;
  y = event.y;
  return event.x > 320 - 96 && event.x < 320 && event.y > 384 && event.y < 480 ? console.log('this tap belongs to me') : null;
};
DPad.prototype.directionPushed = function(x, y) {
  var direction;
  x = x - this.X();
  y = y - this.Y();
  console.log(this.X() + ' ' + this.Y());
  console.log(x + ' ' + y);
  direction = "none";
  if (x > 0 && x < 48 && y > 24 && y < 72) {
    direction = "left";
  } else if (x > 48 && x < 96 && y > 24 && y < 72) {
    direction = "right";
  } else if (x > 24 && x < 72 && y > 0 && y < 48) {
    direction = "up";
  } else if (x > 24 && x < 72 && y > 48 && y < 96) {
    direction = "down";
  }
  return direction;
};
Alien = function(map, x, y) {
  Alien.__super__.constructor.call(this, 'resources/ghost.png', map, 'x', x, y);
  this.asleep = false;
  xc.addEventListener('MonsterTick', this);
  return this;
};
__extends(Alien, GridEntity);
Alien.prototype.move = function() {
  var _i, _len, _ref, move, moved, orderedMoves, x, y;
  x = this.map.man.gridX - this.gridX;
  y = this.map.man.gridY - this.gridY;
  if (x > 0) {
    x = 1;
  } else if (x < 0) {
    x = -1;
  }
  if (y > 0) {
    y = 1;
  } else if (y < 0) {
    y = -1;
  }
  orderedMoves = this.getOrderedMoves(x, y);
  moved = false;
  _ref = orderedMoves;
  for (_i = 0, _len = _ref.length; _i < _len; _i++) {
    move = _ref[_i];
    x = move[0];
    y = move[1];
    if (this.validMove(x, y)) {
      this.gridMove(x, y);
      moved = true;
      this.alseep = false;
      if (this.gridX === this.map.man.gridX && this.gridY === this.map.man.gridY) {
        this.map.man.die();
      }
      break;
    }
  }
  if (!moved && !this.alseep) {
    xc.dispatchEvent(new XCEvent("MonsterSleep"));
    return (this.asleep = true);
  }
};
Alien.prototype.getOrderedMoves = function(x, y) {
  var moves;
  if (x === -1 && y === -1) {
    moves = [[-1, -1], [-1, 0], [0, -1], [-1, 1], [1, -1], [0, 0]];
  } else if (x === 0 && y === -1) {
    moves = [[0, -1], [1, -1], [-1, -1], [-1, 0], [1, 0], [0, 0]];
  } else if (x === 1 && y === -1) {
    moves = [[1, -1], [1, 0], [0, -1], [1, 1], [-1, -1], [0, 0]];
  } else if (x === 1 && y === 0) {
    moves = [[1, 0], [1, 1], [1, -1], [0, 1], [0, -1], [0, 0]];
  } else if (x === -1 && y === 0) {
    moves = [[-1, 0], [-1, 1], [-1, -1], [0, -1], [0, 1], [0, 0]];
  } else if (x === 1 && y === 0) {
    moves = [[1, 0], [1, 1], [1, -1], [0, 1], [0, -1], [0, 0]];
  } else if (x === -1 && y === 1) {
    moves = [[-1, 1], [0, 1], [-1, 0], [1, 1], [-1, -1], [0, 0]];
  } else if (x === 0 && y === 1) {
    moves = [[0, 1], [1, 1], [-1, 1], [-1, 0], [0, 1], [0, 0]];
  } else if (x === 1 && y === 1) {
    moves = [[1, 1], [0, 1], [1, 0], [-1, 1], [1, -1], [0, 0]];
  } else {
    moves = [[0, 0]];
  }
  return moves;
};
Alien.prototype.validMove = function(x, y) {
  if (this.map.tiles[this.gridX + x][this.gridY + y] === "empty" || this.map.tiles[this.gridX + x][this.gridY + y].type === "$") {
    return true;
  } else {
    return false;
  }
};
Alien.prototype.MonsterTick = function(event) {
  console.log('Monster ' + this.name + ' moving!');
  this.move();
  return false;
};