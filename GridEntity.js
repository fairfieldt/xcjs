var GridEntity;
var __extends = function(child, parent) {
    var ctor = function(){};
    ctor.prototype = parent.prototype;
    child.prototype = new ctor();
    child.prototype.constructor = child;
    if (typeof parent.extended === "function") parent.extended(child);
    child.__super__ = parent.prototype;
  };
GridEntity = function(imageName, _arg, _arg2, _arg3, _arg4) {
  this.gridY = _arg4;
  this.gridX = _arg3;
  this.type = _arg2;
  this.map = _arg;
  GridEntity.__super__.constructor.call(this, imageName, this.map.gridSize, this.map.gridSize);
  this.x = this.gridX * this.map.gridSize;
  this.y = this.gridY * this.map.gridSize;
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