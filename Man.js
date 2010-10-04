var Man;
var __extends = function(child, parent) {
    var ctor = function(){};
    ctor.prototype = parent.prototype;
    child.prototype = new ctor();
    child.prototype.constructor = child;
    if (typeof parent.extended === "function") parent.extended(child);
    child.__super__ = parent.prototype;
  };
Man = function(map, x, y) {
  Man.__super__.constructor.call(this, 'dude.png', map, "$", x, y);
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
  console.log('I died');
  return this.gridMove(1 - this.gridX, 1 - this.gridY);
};