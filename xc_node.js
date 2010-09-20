var XCNode, XCScene, XCSpriteNode, XCTextNode;
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
  this.children = new Array();
  this.actions = [];
  return this;
};
XCNode.prototype.update = function(delta) {
  var _a, _b, _c, _d, _e, _f, _g, action, child;
  this.onUpdate(delta);
  _b = this.actions;
  for (_a = 0, _c = _b.length; _a < _c; _a++) {
    action = _b[_a];
    action.tick(delta);
  }
  _d = []; _f = this.children;
  for (_e = 0, _g = _f.length; _e < _g; _e++) {
    child = _f[_e];
    _d.push(child.update(delta));
  }
  return _d;
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
  return (this.rotation = this.rotation + offset);
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
  return (child.parent = this);
};
XCNode.prototype.removeChild = function(child) {
  var pos;
  pos = this.children.indexOf(child);
  if (pos !== -1) {
    this.children = this.children.slice(0, pos).concat(this.children.slice(pos + 1, this.children.length));
    return (child.parent = null);
  }
};
XCNode.prototype.runAction = function(action) {
  action.owner = this;
  return this.actions.push(action);
};
XCNode.prototype.removeAction = function(action) {
  var pos;
  pos = this.actions.indexOf(action);
  return pos !== -1 ? (this.actions = this.actions.slice(0, pos).concat(this.actions.slice(pos + 1, this.actions.length))) : null;
};
XCSpriteNode = function(imageName, _a, _b) {
  this.height = _b;
  this.width = _a;
  this.drawable = true;
  XCSpriteNode.__super__.constructor.call(this);
  this.sprite = xc.loadSprite(imageName);
  this.frame = 0;
  return this;
};
__extends(XCSpriteNode, XCNode);
XCSpriteNode.prototype.draw = function(context) {
  context.translate(this.x - (this.x * this.anchorX), this.y - (this.x * this.anchorY));
  context.rotate(this.rotation * Math.PI / 180);
  return context.drawImage(this.sprite, 0, 0, this.width, this.height, 0, 0, this.width * this.scaleX, this.height * this.scaleY);
};
XCScene = function() {
  XCScene.__super__.constructor.call(this);
  return this;
};
__extends(XCScene, XCNode);
XCScene.prototype.close = function() {};
XCTextNode = function(_a, _b) {
  this.font = _b;
  this.text = _a;
  this.drawable = true;
  XCTextNode.__super__.constructor.call(this);
  return this;
};
__extends(XCTextNode, XCNode);
XCTextNode.prototype.draw = function(context) {
  context.font = this.font;
  context.translate(this.x - (this.x * this.anchorX), this.y - (this.x * this.anchorY));
  context.rotate(this.rotation * Math.PI / 180);
  return context.fillText(this.text, 0, 0);
};