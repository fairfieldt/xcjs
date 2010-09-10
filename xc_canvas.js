var _draw;
_draw = function(node) {
  var _a, _b, _c, _d, child, destinationX, destinationY, parentX, parentY, sizeX, sizeY;
  if (node.visible) {
    context.save();
    if (node.sprite) {
      parentX = node.parent ? node.parent.x : 0;
      parentY = node.parent ? node.parent.y : 0;
      destinationX = Math.floor((node.width * node.anchorX) + node.x + parentX);
      destinationY = Math.floor((node.height * node.anchorY) + node.y + parentY);
      sizeX = Math.floor(node.scaleX * node.width);
      sizeY = Math.floor(node.scaleY * node.height);
      context.drawImage(node.sprite, destinationX, destinationY, sizeX, sizeY);
    }
    _a = []; _c = node.children;
    for (_b = 0, _d = _c.length; _b < _d; _b++) {
      child = _c[_b];
      _a.push(_draw(child));
    }
    return _a;
  }
};