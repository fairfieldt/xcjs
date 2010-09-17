var XCNode, XCScene, XCSpriteNode;
var __extends = function(child, parent) {
    var ctor = function(){};
    ctor.prototype = parent.prototype;
    child.prototype = new ctor();
    child.prototype.constructor = child;
    if (typeof parent.extended === "function") parent.extended(child);
    child.__super__ = parent.prototype;
  };
XCNode = function() {
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
XCNode.prototype.update = function(delta) {
  var _a, _b, _c, _d, child;
  this.onUpdate(delta);
  _a = []; _c = this.children;
  for (_b = 0, _d = _c.length; _b < _d; _b++) {
    child = _c[_b];
    _a.push(child.update(delta));
  }
  return _a;
};
XCNode.prototype.onUpdate = function() {};
XCNode.prototype.moveBy = function(xOffset, yOffset) {
  this.x += xOffset;
  this.y += yOffset;
  return this.sprite.SetPosition(this.x, this.y);
};
XCNode.prototype.moveTo = function(xPosition, yPosition) {
  this.x = xPosition;
  this.y = yPosition;
  return this.sprite.SetPosition(this.x, this.y);
};
XCNode.prototype.scaleXBy = function(factor) {
  this.scaleX = this.scaleX * factor;
  return (this.sprite.xScale = this.scaleX);
};
XCNode.prototype.scaleXTo = function(newScale) {
  this.scaleX = newScale;
  return (this.sprite.xScale = this.scaleX);
};
XCNode.prototype.scaleYBy = function(factor) {
  this.scaleY = this.scaleY * factor;
  return (this.sprite.yScale = this.scaleY);
};
XCNode.prototype.scaleYTo = function(newScale) {
  this.scaleY = newScale;
  return (this.sprite.yScale = this.scaleY);
};
XCNode.prototype.scaleBy = function(factor) {
  this.scaleX = this.scaleX * factor;
  this.scaleY = this.scaleY * factor;
  this.sprite.xScale = this.scaleX;
  return (this.sprite.yScale = this.scaleY);
};
XCNode.prototype.scaleTo = function(newScale) {
  this.scaleX = newScale;
  this.scaleY = newScale;
  this.sprite.xScale = this.scaleX;
  return (this.sprite.yScale = this.scaleY);
};
XCNode.prototype.rotateBy = function(offset) {
  this.rotation = this.rotation + offset;
  return (this.sprite.rotation = this.rotation);
};
XCNode.prototype.rotateTo = function(newRotation) {
  this.rotation = newRotation;
  return (this.sprite.rotation = this.rotation);
};
XCNode.prototype.setAnchorX = function(anchor) {
  return (this.anchorX = anchor);
};
XCNode.prototype.setAnchorY = function(anchor) {
  return (this.anchorY = anchor);
};
XCNode.prototype.addChild = function(child) {
  this.children.push(child);
  child.index = this.children.length;
  return (child.parent = this);
};
XCNode.prototype.removeChild = function(child) {
  this.children = this.children.slice(0, child.index).concat(this.children.slice(child.index, this.children.length));
  child.index = -1;
  return (child.parent = null);
};
XCSpriteNode = function(imageName, _a, _b) {
  this.height = _b;
  this.width = _a;
  XCSpriteNode.__super__.constructor.call(this);
  this.sprite = xc.loadSprite(imageName, this.width, this.height, 1, 1);
  this.frame = 0;
  return this;
};
__extends(XCSpriteNode, XCNode);
XCScene = function() {
  return this;
};
__extends(XCScene, XCNode);
XCScene.prototype.close = function() {};