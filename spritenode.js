var SpriteNode;
var __extends = function(child, parent) {
    var ctor = function(){};
    ctor.prototype = parent.prototype;
    child.prototype = new ctor();
    child.prototype.constructor = child;
    if (typeof parent.extended === "function") parent.extended(child);
    child.__super__ = parent.prototype;
  };
SpriteNode = function(imageName) {
  SpriteNode.__super__.constructor.call(this);
  this.sprite = xc.loadSprite(imageName);
  this.width = xc.getSpriteWidth(this.sprite);
  this.height = xc.getSpriteHeight(this.sprite);
  return this;
};
__extends(SpriteNode, Node);