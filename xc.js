var xc;
xc = function() {
  this.scenes = [];
  this.scenes.push(new XCScene());
  return this;
};
xc.prototype.loadSprite = function(imageName) {
  var sprite;
  sprite = new Image();
  sprite.src = imageName;
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
xc.prototype.replaceScene = function(newScene) {
  this.scenes.pop().close();
  return this.scenes.push(newScene);
};
xc.prototype.pushScene = function(scene) {
  return scenes.push(scene);
};
xc.prototype.popScene = function() {
  return this.scenes.pop();
};
xc.prototype.getCurrentScene = function() {
  return this.scenes[this.scenes.length - 1];
};