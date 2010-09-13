var XCNode, XCSpriteNode;
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
  return this.y += yOffset;
};
XCNode.prototype.moveTo = function(xPosition, yPosition) {
  this.x = xPosition;
  return (this.y = yPosition);
};
XCNode.prototype.scaleXBy = function(factor) {
  return (this.scaleX = this.scaleX * factor);
};
XCNode.prototype.scaleXTo = function(newScale) {
  return (this.scaleX = newScale);
};
XCNode.prototype.scaleYBy = function(factor) {
  return (this.scaleY = this.scaleY * factor);
};
XCNode.prototype.scaleYTo = function(newScale) {
  return (this.scaleY = newScale);
};
XCNode.prototype.scaleBy = function(factor) {
  this.scaleX = this.scaleX * factor;
  return (this.scaleY = this.scaleY * factor);
};
XCNode.prototype.scaleTo = function(newScale) {
  this.scaleX = newScale;
  return (this.scaleY = newScale);
};
XCNode.prototype.rotateBy = function(offset) {
  return (this.rotation = rotation + offset);
};
XCNode.prototype.rotateTo = function(newRotation) {
  return (this.rotation = newRotation);
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
XCSpriteNode = function(imageName) {
  XCSpriteNode.__super__.constructor.call(this);
  this.sprite = xc.loadSprite(imageName);
  this.width = xc.getSpriteWidth(this.sprite);
  this.height = xc.getSpriteHeight(this.sprite);
  return this;
};
__extends(XCSpriteNode, XCNode);