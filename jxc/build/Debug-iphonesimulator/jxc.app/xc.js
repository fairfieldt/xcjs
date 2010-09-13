var xc;
xc = function() {
  return this;
};
xc.prototype.loadSprite = function(spriteName) {
  var x =  xc_add_sprite(spriteName, 0);
	return x;
};
xc.prototype.draw = function(node) {
  if (node.visible)
  {
	  xc_draw(node.sprite, node.x, node.y, node.scaleX, node.rotation);
	  
	  if (node.children.length > 0)
	  {
		  for (x = 0; x < node.children.length; x++)
		  {
			  xc.draw(node.children[x]);
		  }
	  }
  }
};
xc.prototype.getSpriteWidth = function(sprite) {
  return xc_get_sprite_width(sprite);
};
xc.prototype.getSpriteHeight = function(sprite) {
  return xc_get_sprite_height(sprite);
};
xc.prototype.addEventListener = function(eventName, listener) {
  if (!this[eventName]) {
    this[eventName] = [];
  }
  return this[eventName].push(listener);
};
xc.prototype.dispatchEvent = function(event) {
  var _a, _b, _c, _d, _e, listener;
  if (typeof (_e = this[event.name]) !== "undefined" && _e !== null) {
    _a = []; _c = this[event.name];
    for (_b = 0, _d = _c.length; _b < _d; _b++) {
      listener = _c[_b];
      if (listener[event.name](event)) {
        break;
      }
    }
    return _a;
  }
};