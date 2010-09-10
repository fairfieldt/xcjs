var xc;
xc = function() {
  return this;
};
xc.prototype.loadSprite = function(spriteName) {
  return _loadSprite(spriteName);
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