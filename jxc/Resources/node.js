var Node, SpriteNode;
var __extends = function(child, parent) {
    var ctor = function(){};
    ctor.prototype = parent.prototype;
    child.prototype = new ctor();
    child.prototype.constructor = child;
    if (typeof parent.extended === "function") parent.extended(child);
    child.__super__ = parent.prototype;
  };
Node = function() {
  this.visible = true;
  this.x = 0;
  this.y = 0;
  this.scaleX = 1.0;
  this.scaleY = 1.0;
  this.rotation = 0.0;
  this.anchorX = 0.0;
  this.anchorY = 0.0;
  this.parent = null;
  this.children = [];
  this.index = -1;
  return this;
};
Node.prototype.update = function(delta) {
  var _a, _b, _c, _d, child;
  this.onUpdate(delta);
  _a = []; _c = this.children;
  for (_b = 0, _d = _c.length; _b < _d; _b++) {
    child = _c[_b];
    _a.push(child.update(delta));
  }
  return _a;
};
Node.prototype.onUpdate = function() {};
Node.prototype.moveBy = function(xOffset, yOffset) {
  this.x += xOffset;
  this.y += yOffset;
	xc_update_sprite(this.sprite, this.x, this.y, this.scaleX, this.rotation);

};
Node.prototype.moveTo = function(xPosition, yPosition) {
  this.x = xPosition;
 this.y = yPosition;
xc_update_sprite(this.sprite, this.x, this.y, this.scaleX, this.rotation);

};
Node.prototype.scaleXBy = function(factor) {
  return (this.scaleX = this.scaleX * factor);
};
Node.prototype.scaleXTo = function(newScale) {
  return (this.scaleX = newScale);
};
Node.prototype.scaleYBy = function(factor) {
  return (this.scaleY = this.scaleY * factor);
};
Node.prototype.scaleYTo = function(newScale) {
  return (this.scaleY = newScale);
};
Node.prototype.scaleBy = function(factor) {
  this.scaleX = this.scaleX * factor;
  this.scaleY = this.scaleY * factor;
	xc_update_sprite(this.sprite, this.x, this.y, this.scaleX, this.rotation);
};
Node.prototype.scaleTo = function(newScale) {
  this.scaleX = newScale;
  this.scaleY = newScale;
	xc_update_sprite(this.sprite, this.x, this.y, this.scaleX, this.rotation);
};
Node.prototype.rotateBy = function(offset) {
  return (this.rotation = rotation + offset);
};
Node.prototype.rotateTo = function(newRotation) {
  return (this.rotation = newRotation);
};
Node.prototype.setAnchorX = function(anchor) {
  return (this.anchorX = anchor);
};
Node.prototype.setAnchorY = function(anchor) {
  return (this.anchorY = anchor);
};
Node.prototype.addChild = function(child) {
  this.children.push(child);
  child.index = this.children.length;
  return (child.parent = this);
};
Node.prototype.removeChild = function(child) {
  this.children = this.children.slice(0, child.index).concat(this.children.slice(child.index, this.children.length));
  child.index = -1;
  return (child.parent = null);
};
SpriteNode = function(imageName) {
  SpriteNode.__super__.constructor.call(this);
  this.sprite = xc.loadSprite(imageName);
  this.width = xc.getSpriteWidth(this.sprite);
  this.height = xc.getSpriteHeight(this.sprite);
  return this;
};
__extends(SpriteNode, Node);