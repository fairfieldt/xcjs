var xc;
xc = function() {
  this.scenes = [];
  this.scenes.push(new XCScene());
  return this;
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
  var _i, _len, _ref, _result, listener;
  if (typeof (_ref = this[event.name]) !== "undefined" && _ref !== null) {
    _result = []; _ref = this[event.name];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      listener = _ref[_i];
      if (listener[event.name](event)) {
        break;
      }
    }
    return _result;
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