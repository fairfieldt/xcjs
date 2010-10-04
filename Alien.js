var Alien;
var __extends = function(child, parent) {
    var ctor = function(){};
    ctor.prototype = parent.prototype;
    child.prototype = new ctor();
    child.prototype.constructor = child;
    if (typeof parent.extended === "function") parent.extended(child);
    child.__super__ = parent.prototype;
  };
Alien = function(map, x, y) {
  var moveAction;
  Alien.__super__.constructor.call(this, 'ghost.png', map, 'x', x, y);
  this.asleep = false;
  moveAction = XCAction("AlienMoveAction");
  moveAction.et = 0;
  moveAction.tick = function(dt) {
    this.et += dt;
    if (this.et > 1.0) {
      this.owner.move();
      return (this.et = 0);
    }
  };
  this.runAction(moveAction);
  return this;
};
__extends(Alien, GridEntity);
Alien.prototype.move = function() {
  var _i, _len, _ref, move, moved, orderedMoves, s, x, y;
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
    console.log('asleep');
    this.asleep = true;
    s = XCScaleTo(1.0, .8);
    return this.runAction(s);
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