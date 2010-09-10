var xc;
xc = function() {
  return this;
};
xc.prototype.loadSprite = function(spriteName) {
  var sprite;
  sprite = new Image();
  sprite.src = spriteName;
  return sprite;
};
xc.prototype.draw = function(node) {
  return _draw(node);
};
xc.prototype.getSpriteWidth = function(sprite) {
  return sprite.width;
};
xc.prototype.getSpriteHeight = function(sprite) {
  return sprite.height;
};