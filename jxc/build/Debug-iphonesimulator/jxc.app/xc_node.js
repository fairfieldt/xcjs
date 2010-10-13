var XCLayer, XCNode, XCScene, XCSpriteNode, XCTextNode;
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
  this._x = 0;
  this._y = 0;
  this._z = 0;
  this._scaleX = 1.0;
  this._scaleY = 1.0;
  this._rotation = 0.0;
  this._opacity = 1.0;
  this._anchorX = 0.0;
  this._anchorY = 0.0;
  this.setAnchorX(0.0);
  this.setAnchorY(0.0);
  this.parent = null;
  this._color = new XCColor(0, 0, 0);
  this.children = new Array();
  return this;
};
XCNode.prototype.moveBy = function(xOffset, yOffset) {
  this.setX(this.X() + xOffset);
  return this.setY(this.Y() + yOffset);
};
XCNode.prototype.moveTo = function(xPosition, yPosition) {
  console.log('and now x is ' + this.X());
  this.setX(xPosition);
  this.setY(yPosition);
  return console.log('and now x is ' + this.X());
};
XCNode.prototype.X = function() {
  return _xcNodeX(this);
};
XCNode.prototype.Y = function() {
  return _xcNodeY(this);
};
XCNode.prototype.setX = function(newX) {
  return _xcNodeSetX(this, newX);
};
XCNode.prototype.setY = function(newY) {
  return _xcNodeSetY(this, newY);
};
XCNode.prototype.color = function() {
  return _xcNodeColor(this);
};
XCNode.prototype.setColor = function(newColor) {
  return _xcNodeSetColor(this, newColor);
};
XCNode.prototype.scaleXBy = function(factor) {
  return this.setScaleX(this.scaleX() * factor);
};
XCNode.prototype.scaleXTo = function(newScale) {
  return this.setScaleX(newScale);
};
XCNode.prototype.setScaleX = function(newScaleX) {
  return _xcNodeSetScaleX(this, newScaleX);
};
XCNode.prototype.scaleYBy = function(factor) {
  return this.setScaleY(this.scaleY() * factor);
};
XCNode.prototype.scaleYTo = function(newScale) {
  return this.setScaleY(newScale);
};
XCNode.prototype.setScaleY = function(newScaleY) {
  return _xcNodeSetScaleY(this, newScaleY);
};
XCNode.prototype.scaleBy = function(factor) {
  this.setScaleX(this.scaleX() * factor);
  return this.setScaleY(this.scaleY() * factor);
};
XCNode.prototype.scaleTo = function(newScale) {
  this.setScaleX(newScale);
  return this.setScaleY(newScale);
};
XCNode.prototype.scaleX = function() {
  return _xcNodeScaleX(this);
};
XCNode.prototype.scaleY = function() {
  return _xcNodeScaleY(this);
};
XCNode.prototype.rotateBy = function(offset) {
  return this.setRotation(this.rotation() + offset);
};
XCNode.prototype.rotateTo = function(newRotation) {
  return this.setRotation(newRotation);
};
XCNode.prototype.rotation = function() {
  return _xcNodeRotation(this);
};
XCNode.prototype.setRotation = function(newRotation) {
  return _xcNodeSetRotation(this, newRotation);
};
XCNode.prototype.fadeTo = function(newOpacity) {
  return this.setOpacity(newOpacity);
};
XCNode.prototype.fadeBy = function(opacity) {
  return this.setOpacity(Math.max(this.opacity - opacity, 0));
};
XCNode.prototype.opacity = function() {
  return _xcNodeOpacity(this);
};
XCNode.prototype.setOpacity = function(newOpacity) {
  return _xcNodeSetOpacity(this, newOpacity);
};
XCNode.prototype.setAnchorX = function(anchor) {
  return this.setAnchorX(anchor);
};
XCNode.prototype.setAnchorY = function(anchor) {
  return this.setAnchorY(anchor);
};
XCNode.prototype.anchorX = function() {
  return _xcNodeAnchorX(this);
};
XCNode.prototype.anchorY = function() {
  return _xcNodeAnchorY(this);
};
XCNode.prototype.setAnchorX = function(newAnchorX) {
  return _xcNodeSetAnchorX(this, newAnchorX);
};
XCNode.prototype.setAnchorY = function(newAnchorY) {
  return _xcNodeSetAnchorY(this, newAnchorY);
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
  return xc.actions.push(action);
};
XCNode.prototype.removeAction = function(action) {
  var pos;
  pos = xc.actions.indexOf(action);
  return pos !== -1 ? (xc.actions = xc.actions.slice(0, pos).concat(xc.actions.slice(pos + 1, xc.actions.length))) : null;
};
XCSpriteNode = function(imageName, _a, _b) {
  this.height = _b;
  this.width = _a;
  this.drawable = true;
  XCSpriteNode.__super__.constructor.call(this);
  this.sprite = _xcLoadSprite(imageName);
  this.frame = 0;
  return this;
};
__extends(XCSpriteNode, XCNode);
XCSpriteNode.prototype.draw = function() {
  return _xcSpriteDraw(this);
};
XCScene = function() {
  XCScene.__super__.constructor.call(this);
  return this;
};
__extends(XCScene, XCNode);
XCScene.prototype.close = function() {};
XCTextNode = function(_a, _b, _c) {
  this.fontSize = _c;
  this.fontName = _b;
  this.text = _a;
  this.drawable = true;
  this.ref = _xcLoadText(this);
  XCTextNode.__super__.constructor.call(this);
  return this;
};
__extends(XCTextNode, XCNode);
XCTextNode.prototype.setText = function(newText) {
  return _xcTextSetText(this, newText);
};
XCTextNode.prototype.draw = function() {
  return _xcTextDraw(this);
};
XCLayer = function() {
  XCLayer.__super__.constructor.call(this);
  return this;
};
__extends(XCLayer, XCNode);