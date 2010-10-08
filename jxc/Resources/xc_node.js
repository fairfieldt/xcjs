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
  this.x = 0;
  this.y = 0;
  this.z = 0;
  this.scaleX = 1.0;
  this.scaleY = 1.0;
  this.rotation = 0.0;
  this.opacity = 1.0;
  this.anchorX = 0.0;
  this.anchorY = 0.0;
  this.parent = null;
  this.color = new XCColor(0, 0, 0);
  this.children = new Array();
  this.dirty = true;
  return this;
};
XCNode.prototype.moveBy = function(xOffset, yOffset) {
  this.dirty = true;
  this.x += xOffset;
  return this.y += yOffset;
};
XCNode.prototype.moveTo = function(xPosition, yPosition) {
  this.dirty = true;
  this.x = xPosition;
  return (this.y = yPosition);
};
XCNode.prototype.x = function() {
  return _xcNodeX(this);
};
XCNode.prototype.y = function() {
  return _xcNodeY(this);
};
XCNode.prototype.color = function() {
  return _xcNodeColor(this);
};
XCNode.prototype.scaleXBy = function(factor) {
  this.dirty = true;
  return (this.scaleX = this.scaleX * factor);
};
XCNode.prototype.scaleXTo = function(newScale) {
  this.dirty = true;
  return (this.scaleX = newScale);
};
XCNode.prototype.scaleYBy = function(factor) {
  this.dirty = true;
  return (this.scaleY = this.scaleY * factor);
};
XCNode.prototype.scaleYTo = function(newScale) {
  this.dirty = true;
  return (this.scaleY = newScale);
};
XCNode.prototype.scaleBy = function(factor) {
  this.dirty = true;
  this.scaleX = this.scaleX * factor;
  return (this.scaleY = this.scaleY * factor);
};
XCNode.prototype.scaleTo = function(newScale) {
  this.dirty = true;
  this.scaleX = newScale;
  return (this.scaleY = newScale);
};
XCNode.prototype.scaleX = function() {
  return _xcNodeScaleX(this);
};
XCNode.prototype.scaleY = function() {
  return _xcNodeScaleY(this);
};
XCNode.prototype.rotateBy = function(offset) {
  this.dirty = true;
  return (this.rotation = this.rotation + offset);
};
XCNode.prototype.rotateTo = function(newRotation) {
  this.dirty = true;
  return (this.rotation = newRotation);
};
XCNode.prototype.rotation = function() {
  return _xcNodeRotation(this);
};
XCNode.prototype.fadeTo = function(newOpacity) {
  this.dirty = true;
  return (this.opacity = newOpacity);
};
XCNode.prototype.fadeBy = function(opacity) {
  this.dirty = true;
  return (this.opacity = Math.max(this.opacity + newOpacity, 0));
};
XCNode.prototype.opacity = function() {
  return _xcNodeOpacity(this);
};
XCNode.prototype.setAnchorX = function(anchor) {
  this.dirty = true;
  return (this.anchorX = anchor);
};
XCNode.prototype.setAnchorY = function(anchor) {
  this.dirty = true;
  return (this.anchorY = anchor);
};
XCNode.prototype.anchorX = function() {
  return _xcNodeAnchorX(this);
};
XCNode.prototype.anchorY = function() {
  return _xcNodeAnchorY(this);
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
  _xcSpriteDraw(this);
  return (this.dirty = false);
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
  this.dirty = true;
  return (this.text = newText);
};
XCTextNode.prototype.draw = function() {
  _xcTextDraw(this);
  return (this.dirty = false);
};
XCLayer = function() {
  XCLayer.__super__.constructor.call(this);
  return this;
};
__extends(XCLayer, XCNode);