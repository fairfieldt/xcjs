var XC, XCAction, XCAnimateAction, XCAnimatedSpriteNode, XCButtonNode, XCCallFuncAction, XCColor, XCDelayAction, XCEvent, XCIntervalAction, XCKeyDownEvent, XCKeyUpEvent, XCMoveAction, XCMoveByAction, XCMoveToAction, XCNode, XCRotateAction, XCRotateByAction, XCRotateToAction, XCRunForeverAction, XCScaleAction, XCScaleByAction, XCScaleToAction, XCScene, XCSequenceAction, XCSpriteNode, XCTapDownEvent, XCTapMovedEvent, XCTapUpEvent, XCTextNode;
var __hasProp = Object.prototype.hasOwnProperty, __extends = function(child, parent) {
  for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; }
  function ctor() { this.constructor = child; }
  ctor.prototype = parent.prototype;
  child.prototype = new ctor;
  child.__super__ = parent.prototype;
  return child;
}, __slice = Array.prototype.slice;
XCColor = function() {
  function XCColor(r, g, b) {
    this.r = r;
    this.g = g;
    this.b = b;
  }
  return XCColor;
}();
XCNode = function() {
  function XCNode() {
    this._visible = true;
    this._x = 0;
    this._y = 0;
    this._layer = 0;
    this._scaleX = 1.0;
    this._scaleY = 1.0;
    this._rotation = 0.0;
    this._opacity = 1.0;
    this._anchorX = 0;
    this._anchorY = 0;
    this._parent = null;
    this._color = new XCColor(0xFF, 0xFF, 0xFF);
    this._actions = [];
    this.setAnchorX(0.5);
    this.setAnchorY(0.5);
  }
  XCNode.prototype.parent = function() {
    return this._parent;
  };
  XCNode.prototype.setParent = function(scene) {
    return this._parent = scene;
  };
  XCNode.prototype.open = function(scene) {
    this.setParent(scene);
    return this.show();
  };
  XCNode.prototype.close = function() {
    xc.removeAllEventListeners(this);
    this.setParent(null);
    return this.hide();
  };
  XCNode.prototype.width = function() {
    return _xcNodeWidth(this);
  };
  XCNode.prototype.height = function() {
    return _xcNodeHeight(this);
  };
  XCNode.prototype.rect = function() {
    return {
      x: this.X() - (this.anchorX() * this.width()),
      y: this.Y() - (this.anchorY() * this.height()),
      w: this.width(),
      h: this.height()
    };
  };
  XCNode.prototype.moveBy = function(xOffset, yOffset) {
    this.setX(this.X() + xOffset);
    return this.setY(this.Y() + yOffset);
  };
  XCNode.prototype.moveTo = function(xPosition, yPosition) {
    this.setX(xPosition);
    return this.setY(yPosition);
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
  XCNode.prototype.layer = function() {
    return _xcNodeLayer(this);
  };
  XCNode.prototype.setLayer = function(newLayer) {
    return _xcNodeSetLayer(this, newLayer);
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
  XCNode.prototype.opacity = function() {
    return _xcNodeOpacity(this);
  };
  XCNode.prototype.setOpacity = function(newOpacity) {
    return _xcNodeSetOpacity(this, newOpacity);
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
  XCNode.prototype.visible = function() {
    return _xcNodeVisible(this);
  };
  XCNode.prototype.hide = function() {
    return _xcNodeSetVisible(this, false);
  };
  XCNode.prototype.show = function() {
    return _xcNodeSetVisible(this, true);
  };
  XCNode.prototype.actions = function() {
    return this._actions;
  };
  XCNode.prototype.tick = function(dt) {
    var action, _i, _len, _ref, _results;
    _ref = this.actions();
    _results = [];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      action = _ref[_i];
      _results.push(!action.tick(dt) ? this.removeAction(action) : void 0);
    }
    return _results;
  };
  XCNode.prototype.runAction = function(action) {
    if (this._actions.indexOf(action) === -1 && action.owner === null) {
      action.setOwner(this);
      return this._actions.push(action);
    } else {
      throw {
        name: "RunDuplicateActionError",
        message: "Tried to add action " + action + " to " + this + " twice"
      };
    }
  };
  XCNode.prototype.removeAction = function(action) {
    var pos;
    pos = this._actions.indexOf(action);
    if (pos !== -1) {
      return this._actions = this._actions.slice(0, pos).concat(this._actions.slice(pos + 1, this._actions.length));
    } else {
      throw {
        name: "RemoveActionError",
        message: "Tried to remove action " + action.name + " when it was not added"
      };
    }
  };
  XCNode.prototype.removeActionByTag = function(tag) {
    var action, _i, _len, _ref, _results;
    _ref = this._actions;
    _results = [];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      action = _ref[_i];
      _results.push(action.tag === tag ? removeAction(action) : void 0);
    }
    return _results;
  };
  return XCNode;
}();
XCTextNode = function() {
  function XCTextNode(_text, fontName, fontSize) {
    this._text = _text;
    this.fontName = fontName;
    this.fontSize = fontSize;
    this.drawable = true;
    this.sprite = _xcLoadText(this);
    this.font = this.fontSize + "pt " + this.fontName;
    XCTextNode.__super__.constructor.call(this);
    this.setColor(new XCColor(0, 0, 0));
  }
  __extends(XCTextNode, XCNode);
  XCTextNode.prototype.width = function() {
    return _xcTextNodeWidth(this);
  };
  XCTextNode.prototype.height = function() {
    return _xcTextNodeHeight(this);
  };
  XCTextNode.prototype.text = function() {
    return _xcTextNodeText(this);
  };
  XCTextNode.prototype.setText = function(newText) {
    return _xcTextSetText(this, newText);
  };
  XCTextNode.prototype.draw = function() {
    return _xcTextDraw(this);
  };
  return XCTextNode;
}();
XCAction = function() {
  function XCAction(name, tag) {
    var _ref;
    this.name = name;
    this.tag = tag;
    this.owner = null;
    (_ref = this.tag) != null ? _ref : this.tag = "";
  }
  XCAction.prototype.tick = function(dt) {
    return false;
  };
  XCAction.prototype.setOwner = function(owner) {
    return this.owner = owner;
  };
  return XCAction;
}();
XCCallFuncAction = function() {
  function XCCallFuncAction(fn, tag) {
    this.fn = fn;
    XCCallFuncAction.__super__.constructor.call(this, "XCCallFuncAction", tag);
  }
  __extends(XCCallFuncAction, XCAction);
  XCCallFuncAction.prototype.tick = function(dt) {
    this.fn();
    return false;
  };
  return XCCallFuncAction;
}();
XCSpriteNode = function() {
  function XCSpriteNode(imageName) {
    this.drawable = true;
    this.sprite = _xcLoadImage(imageName);
    XCSpriteNode.__super__.constructor.call(this);
    this._width = _xcImageWidth(this);
    this._height = _xcImageHeight(this);
    this._frame = 0;
  }
  __extends(XCSpriteNode, XCNode);
  XCSpriteNode.prototype.draw = function() {
    return _xcSpriteDraw(this);
  };
  XCSpriteNode.prototype.frameHeight = function() {
    return _xcSpriteFrameHeight(this);
  };
  XCSpriteNode.prototype.frameWidth = function() {
    return _xcSpriteFrameWidth(this);
  };
  XCSpriteNode.prototype.frame = function() {
    return _xcSpriteFrame(this);
  };
  XCSpriteNode.prototype.setFrame = function(newFrame) {
    return _xcSpriteSetFrame(this, newFrame);
  };
  return XCSpriteNode;
}();
XCScene = function() {
  function XCScene(name) {
    this.name = name;
    this._paused = false;
    this._children = [];
    this._scheduledFunctions = [];
    this._collisionNodes = [];
  }
  XCScene.prototype.pause = function() {
    return this._paused = true;
  };
  XCScene.prototype.paused = function() {
    return this._paused;
  };
  XCScene.prototype.resume = function() {
    return this._paused = false;
  };
  XCScene.prototype.close = function() {};
  XCScene.prototype.collisionNodes = function() {
    return this._collisionNodes;
  };
  XCScene.prototype.addCollisionNode = function(node, target) {
    this._collisionNodes.push({
      node: node,
      target: target
    });
    return xc.addEventListener('CollisionEvent', node);
  };
  XCScene.prototype.removeCollisionNode = function(node, target) {
    var entry, _i, _len, _ref;
    _ref = this._collisionNodes;
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      entry = _ref[_i];
      if (entry.node === node && entry.target === target) {
        this._collisionNodes = this._collisionNodes.slice(0, i).concat(this._collisionNodes.slice(i + 1));
        break;
      }
    }
  };
  XCScene.prototype.tick = function(dt) {
    var child, collisionEvent, entry, node, scheduled, target, _i, _j, _k, _l, _len, _len2, _len3, _len4, _ref, _ref2, _ref3, _ref4, _results;
    _ref = this.collisionNodes();
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      entry = _ref[_i];
      node = entry.node;
      target = entry.target;
      if (typeof target === 'string') {
        _ref2 = this.children();
        for (_j = 0, _len2 = _ref2.length; _j < _len2; _j++) {
          child = _ref2[_j];
          if (child.tag === target && xc.rectContainsRect(child.rect(), node.rect())) {
            collisionEvent = new XCEvent('CollisionEvent');
            collisionEvent.node = child;
            xc.dispatchEvent(collisionEvent, node);
          }
        }
      } else {
        if (xc.rectContainsRect(node.rect(), target.rect())) {
          collisionEvent = new XCEvent('CollisionEvent');
          collisionEvent.node = target;
          xc.dispatchEvent(collisionEvent, node);
        }
      }
    }
    _ref3 = this.children();
    for (_k = 0, _len3 = _ref3.length; _k < _len3; _k++) {
      child = _ref3[_k];
      child.tick(dt);
    }
    _ref4 = this._scheduledFunctions;
    _results = [];
    for (_l = 0, _len4 = _ref4.length; _l < _len4; _l++) {
      scheduled = _ref4[_l];
      scheduled.et += dt;
      _results.push(scheduled.et >= scheduled.interval ? (scheduled["function"](scheduled.et), scheduled.et = 0) : void 0);
    }
    return _results;
  };
  XCScene.prototype.addChild = function(child) {
    if (child.parent() !== null) {
      throw {
        name: 'DuplicateChildError',
        message: 'Node already a child of another scene'
      };
    }
    if (this._children.indexOf(child) === -1) {
      this._children.push(child);
      child.open();
      return child.setParent(this);
    } else {
      throw {
        name: 'DuplicateChildError',
        message: 'Can\'t add the same child twice'
      };
    }
  };
  XCScene.prototype.removeChild = function(child) {
    var pos;
    pos = this._children.indexOf(child);
    if (pos !== -1) {
      this._children = this._children.slice(0, pos).concat(this._children.slice(pos + 1, this._children.length));
      child.close();
      return this.removeCollisionNode(child);
    } else {
      throw {
        name: 'NodeNotChildError',
        message: 'Can\'t remove a node that is not a child'
      };
    }
  };
  XCScene.prototype.children = function() {
    return this._children;
  };
  XCScene.prototype.scheduledFunctions = function() {
    return this._scheduledFunctions;
  };
  XCScene.prototype.schedule = function(fn, interval) {
    interval != null ? interval : interval = 0;
    return this.scheduledFunctions().push({
      "function": fn,
      interval: interval,
      et: 0
    });
  };
  XCScene.prototype.unschedule = function(fn) {
    var fnObject, i, scheduled, _i, _len, _ref;
    fnObject = null;
    _ref = this.scheduledFunctions();
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      scheduled = _ref[_i];
      if (scheduled["function"] === fn) {
        fnObject = scheduled;
        break;
      }
    }
    i = this.scheduledFunctions().indexOf(fnObject);
    if (i !== -1) {
      return this._scheduledFunctions = this._scheduledFunctions.slice(0, i).concat(this._scheduledFunctions.slice(i + 1, this.scheduledFunctions.length - 1 + 1));
    } else {
      ;
    }
  };
  return XCScene;
}();
XC = function() {
  function XC() {
    this._scenes = [];
    this._scenes.push(new XCScene('DefaultScene'));
    this._events = [];
  }
  XC.prototype.addEventListener = function(eventName, listener) {
    var message;
    if (!this._events[eventName]) {
      this._events[eventName] = [];
    }
    if (this._events[eventName].indexOf(listener) === -1) {
      return this._events[eventName].push(listener);
    } else {
      message = 'The event listener for ' + eventName + ' ' + listener + ' was already added';
      throw {
        name: 'EventListenerAlreadyAddedError',
        message: message
      };
    }
  };
  XC.prototype.removeEventListener = function(eventName, listener) {
    var message, pos;
    if ((this._events[eventName] != null) && (pos = this._events[eventName].indexOf(listener)) !== -1) {
      return this._events[eventName] = this._events[eventName].slice(0, pos).concat(this._events[eventName].slice(pos + 1, this._events[eventName].length - 1 + 1));
    } else {
      message = 'There is no listener for ' + eventName + ' ' + listener;
      throw {
        name: 'NoSuchEventListenerError',
        message: message
      };
    }
  };
  XC.prototype.clearEvents = function() {
    return this._events = [];
  };
  XC.prototype.removeAllEventListeners = function(listener) {
    var eventList, pos, _i, _len, _ref, _results;
    _ref = this._events;
    _results = [];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      eventList = _ref[_i];
      pos = eventList.indexOf(listener);
      _results.push(pos !== -1 ? eventList = eventList.slice(0, pos).concat(eventList.slice(pos + 1, eventList.length - 1 + 1)) : void 0);
    }
    return _results;
  };
  XC.prototype.dispatchEvent = function(event, target) {
    var listener, _i, _len, _ref, _results;
    if (target) {
      return target[event.name](event);
    } else {
      if (this._events[event.name] != null) {
        _ref = this._events[event.name];
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          listener = _ref[_i];
          _results.push(listener[event.name](event));
        }
        return _results;
      }
    }
  };
  XC.prototype.replaceScene = function(newScene) {
    var oldScene;
    if (this._scenes.indexOf(newScene) === -1) {
      oldScene = this._scenes.pop().close();
      this._scenes.push(newScene);
      return oldScene;
    } else {
      throw {
        name: 'DuplicateSceneError',
        message: 'Cannot replace a scene with itself'
      };
    }
  };
  XC.prototype.pushScene = function(newScene) {
    if (this._scenes.indexOf(newScene) === -1) {
      return this._scenes.push(newScene);
    } else {
      throw {
        name: 'DuplicateSceneError',
        message: 'Cannot put a scene on the stack twice'
      };
    }
  };
  XC.prototype.popScene = function() {
    var oldScene;
    if (this._scenes.length > 1) {
      oldScene = this._scenes.pop();
      oldScene.close();
      return oldScene;
    } else {
      throw {
        name: 'PoppedLastSceneError',
        message: 'Can\'t pop with one scene left'
      };
    }
  };
  XC.prototype.getCurrentScene = function() {
    return this._scenes[this._scenes.length - 1];
  };
  XC.prototype.rectContainsPoint = function(rect, point) {
    return (point.x > rect.x) && (point.x < (rect.x + rect.w)) && (point.y > rect.y) && (point.y < (rect.y + rect.h));
  };
  XC.prototype.rectContainsRect = function(rect1, rect2) {
    return !((rect1.x + rect1.w) <= rect2.x) && !(rect1.x >= (rect2.x + rect2.w)) && !((rect1.y + rect1.h) <= rect2.y) && !(rect1.y >= (rect2.y + rect2.h));
  };
  XC.prototype.circleContainsPoint = function(circle, point) {
    var xSquared, ySquared;
    xSquared = Math.pow(2, circle.x - point.x);
    ySquared = Math.pow(2, circle.y - point.y);
    return Math.sqrt(xSquared + ySquared) > circle.r;
  };
  return XC;
}();
XCIntervalAction = function() {
  function XCIntervalAction(duration, name, tag) {
    this.duration = duration;
    XCIntervalAction.__super__.constructor.call(this, name, tag);
  }
  __extends(XCIntervalAction, XCAction);
  XCIntervalAction.prototype.tick = function(dt) {
    this.duration -= dt;
    return this.duration > 0;
  };
  return XCIntervalAction;
}();
XCMoveAction = function() {
  function XCMoveAction(duration, name, tag) {
    XCMoveAction.__super__.constructor.call(this, duration, name, tag);
    this.etX = 0;
    this.etY = 0;
  }
  __extends(XCMoveAction, XCIntervalAction);
  XCMoveAction.prototype.tick = function(dt) {
    var moveX, moveY;
    this.etX += dt;
    this.etY += dt;
    moveX = this.etX * this.stepX;
    moveY = this.etY * this.stepY;
    if (Math.abs(moveX) > 0) {
      this.etX = 0;
    }
    if (Math.abs(moveY) > 0) {
      this.etY = 0;
    }
    if (this.positiveX && (this.x - moveX < 0)) {
      moveX = this.x;
    } else if ((!this.positiveX) && (this.x - moveX > 0)) {
      moveX = this.x;
    }
    if (this.positiveY && (this.y - moveY < 0)) {
      moveY = this.y;
    } else if ((!this.positiveY) && (this.y - moveY > 0)) {
      moveY = this.y;
    }
    this.x -= moveX;
    this.y -= moveY;
    this.owner.moveBy(moveX, moveY);
    return XCMoveAction.__super__.tick.call(this, dt);
  };
  return XCMoveAction;
}();
XCMoveToAction = function() {
  function XCMoveToAction(duration, x, y, tag) {
    this.x = x;
    this.y = y;
    XCMoveToAction.__super__.constructor.call(this, duration, "XCMoveTo", tag);
    this.firstTick = true;
  }
  __extends(XCMoveToAction, XCMoveAction);
  XCMoveToAction.prototype.tick = function(dt) {
    if (this.firstTick) {
      this.x -= this.owner.X();
      this.y -= this.owner.Y();
      this.stepX = this.x / this.duration;
      this.stepY = this.y / this.duration;
      this.positiveX = this.stepX > 0;
      this.positiveY = this.stepY > 0;
      this.firstTick = false;
    }
    return XCMoveToAction.__super__.tick.call(this, dt);
  };
  return XCMoveToAction;
}();
XCMoveByAction = function() {
  function XCMoveByAction(duration, x, y, tag) {
    this.x = x;
    this.y = y;
    XCMoveByAction.__super__.constructor.call(this, duration, "XCMoveBy", tag);
    this.stepX = this.x / this.duration;
    this.stepY = this.y / this.duration;
    this.positiveX = this.stepX > 0;
    this.positiveY = this.stepY > 0;
  }
  __extends(XCMoveByAction, XCMoveAction);
  return XCMoveByAction;
}();
XCScaleAction = function() {
  function XCScaleAction(duration, name, tag) {
    XCScaleAction.__super__.constructor.call(this, duration, name, tag);
    this.etX = 0;
    this.etY = 0;
    this.firstTick = true;
  }
  __extends(XCScaleAction, XCIntervalAction);
  XCScaleAction.prototype.tick = function(dt) {
    var newScaleX, newScaleY;
    this.etX += dt;
    this.etY += dt;
    newScaleX = this.etX * this.stepScaleX;
    newScaleY = this.etY * this.stepScaleY;
    if (Math.abs(newScaleX) > 0) {
      this.etX = 0;
    }
    if (Math.abs(newScaleY) > 0) {
      this.etY = 0;
    }
    if (Math.abs(this.scale.x) - Math.abs(newScaleX) <= 0) {
      newScaleX = this.scale.x;
    }
    if (Math.abs(this.scale.y) - Math.abs(newScaleY) <= 0) {
      newScaleY = this.scale.y;
    }
    this.scale.x -= newScaleY;
    this.scale.y -= newScaleY;
    this.owner.scaleXTo(this.owner.scaleX() + newScaleX);
    this.owner.scaleYTo(this.owner.scaleY() + newScaleY);
    return XCScaleAction.__super__.tick.call(this, dt);
  };
  return XCScaleAction;
}();
XCScaleToAction = function() {
  function XCScaleToAction(duration, scale, tag) {
    this.scale = scale;
    XCScaleToAction.__super__.constructor.call(this, duration, "XCScaleTo", tag);
  }
  __extends(XCScaleToAction, XCScaleAction);
  XCScaleToAction.prototype.tick = function(dt) {
    if (this.firstTick) {
      this.scale.x -= this.owner.scaleX();
      this.scale.y -= this.owner.scaleY();
      this.stepScaleX = this.scale.x / this.duration;
      this.stepScaleY = this.scale.y / this.duration;
      this.firstTick = false;
    }
    return XCScaleToAction.__super__.tick.call(this, dt);
  };
  return XCScaleToAction;
}();
XCScaleByAction = function() {
  function XCScaleByAction(duration, scale, tag) {
    this.scale = scale;
    XCScaleByAction.__super__.constructor.call(this, duration, "XCScaleTo", tag);
  }
  __extends(XCScaleByAction, XCScaleAction);
  XCScaleByAction.prototype.tick = function(dt) {
    if (this.firstTick) {
      this.scale.x = (this.scale.x * this.owner.scaleX()) - this.owner.scaleX();
      this.scale.y = (this.scale.y * this.owner.scaleY()) - this.owner.scaleX();
      this.stepScaleX = this.scale.x / this.duration;
      this.stepScaleY = this.scale.y / this.duration;
      this.firstTick = false;
    }
    return XCScaleByAction.__super__.tick.call(this, dt);
  };
  return XCScaleByAction;
}();
XCButtonNode = function() {
  function XCButtonNode(imageName) {
    XCButtonNode.__super__.constructor.call(this, imageName);
    xc.addEventListener('tapDown', this);
    xc.addEventListener('tapUp', this);
    xc.addEventListener('tapMoved', this);
  }
  __extends(XCButtonNode, XCSpriteNode);
  XCButtonNode.prototype.tapDown = function(event) {
    if (xc.rectContainsPoint(this.rect(), event.point)) {
      this.tapStarted = true;
      return this.onTapStart(event.point);
    }
  };
  XCButtonNode.prototype.tapMoved = function(event) {
    if (!xc.rectContainsPoint(this.rect(), event.point)) {
      return this.onTapLeave(event.point);
    }
  };
  XCButtonNode.prototype.tapUp = function(event) {
    if (this.tapStarted && xc.rectContainsPoint(this.rect(), event.point)) {
      this.onHit(event.point);
    }
    return this.tapStarted = false;
  };
  XCButtonNode.prototype.onTapStart = function(point) {};
  XCButtonNode.prototype.onTapLeave = function(point) {};
  XCButtonNode.prototype.onHit = function(point) {};
  return XCButtonNode;
}();
XCAnimateAction = function() {
  function XCAnimateAction(delay, frames, repeat, tag) {
    this.delay = delay;
    this.frames = frames;
    this.repeat = repeat;
    repeat != null ? repeat : repeat = false;
    XCAnimateAction.__super__.constructor.call(this, 'XCAnimationAction', tag);
    this.currentFrame = 0;
    this.et = 0;
  }
  __extends(XCAnimateAction, XCAction);
  XCAnimateAction.prototype.tick = function(dt) {
    this.et -= dt;
    if (this.et <= 0) {
      this.et = this.delay;
      this.owner.setFrame(this.frames[this.currentFrame++]);
      if (this.currentFrame === this.frames.length) {
        if (this.repeat) {
          this.currentFrame = 0;
        } else {
          console.log('done animating');
          return false;
        }
      }
    }
    return true;
  };
  return XCAnimateAction;
}();
XCAnimatedSpriteNode = function() {
  function XCAnimatedSpriteNode(imageName, width, height, _padding) {
    this._padding = _padding;
    XCAnimatedSpriteNode.__super__.constructor.call(this, imageName);
    this._width = width;
    this._height = height;
    this._frameWidth = width;
    this._frameHeight = height;
  }
  __extends(XCAnimatedSpriteNode, XCSpriteNode);
  return XCAnimatedSpriteNode;
}();
XCDelayAction = function() {
  function XCDelayAction(duration, tag) {
    XCDelayAction.__super__.constructor.call(this, duration, 'XCDelayAction', tag);
  }
  __extends(XCDelayAction, XCIntervalAction);
  return XCDelayAction;
}();
XCSequenceAction = function() {
  function XCSequenceAction() {
    var actions, tag, _i;
    actions = 2 <= arguments.length ? __slice.call(arguments, 0, _i = arguments.length - 1) : (_i = 0, []), tag = arguments[_i++];
    this.actions = actions;
    XCSequenceAction.__super__.constructor.call(this, "XCSequenceAction", tag);
  }
  __extends(XCSequenceAction, XCAction);
  XCSequenceAction.prototype.tick = function(dt) {
    var currentAction;
    if (this.actions.length === 0) {
      return false;
    }
    currentAction = this.actions[0];
    if (!currentAction.tick(dt)) {
      this.actions = this.actions.slice(1, this.actions.length + 1);
    }
    return true;
  };
  XCSequenceAction.prototype.setOwner = function(owner) {
    var action, _i, _len, _ref, _results;
    XCSequenceAction.__super__.setOwner.call(this, owner);
    _ref = this.actions;
    _results = [];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      action = _ref[_i];
      _results.push(action.setOwner(this.owner));
    }
    return _results;
  };
  return XCSequenceAction;
}();
XCRunForeverAction = function() {
  function XCRunForeverAction(action, tag) {
    this.action = action;
    XCRunForeverAction.__super__.constructor.call(this, 'XCRunForeverAction', tag);
  }
  __extends(XCRunForeverAction, XCAction);
  XCRunForeverAction.prototype.tick = function(dt) {
    return this.action.tick(dt);
  };
  XCRunForeverAction.prototype.setOwner = function(owner) {
    XCRunForeverAction.__super__.setOwner.call(this, owner);
    return this.action.setOwner(this.owner);
  };
  return XCRunForeverAction;
}();
XCRotateAction = function() {
  function XCRotateAction(duration, name, tag) {
    XCRotateAction.__super__.constructor.call(this, duration, name, tag);
    this.et = 0;
  }
  __extends(XCRotateAction, XCIntervalAction);
  XCRotateAction.prototype.tick = function(dt) {
    var rotation;
    this.et += dt;
    rotation = this.et * this.stepAngle;
    if (Math.abs(rotation) > 0) {
      this.et = 0;
    }
    if (this.positiveRotation && (this.angle - rotation <= 0)) {
      rotation = this.angle;
    } else if ((!this.positiveRotation) && this.angle - rotation >= 0) {
      rotation = this.angle;
    }
    this.angle -= rotation;
    this.owner.rotateBy(rotation);
    return XCRotateAction.__super__.tick.call(this, dt);
  };
  return XCRotateAction;
}();
XCRotateToAction = function() {
  function XCRotateToAction(duration, angle, tag) {
    this.angle = angle;
    XCRotateToAction.__super__.constructor.call(this, duration, "XCRotateTo", tag);
    this.firstTick = true;
  }
  __extends(XCRotateToAction, XCRotateAction);
  XCRotateToAction.prototype.tick = function(dt) {
    if (this.firstTick) {
      this.angle -= this.owner.rotation();
      this.stepAngle = this.angle / this.duration;
      this.positiveRotation = this.angle > 0;
      this.firstTick = false;
    }
    return XCRotateToAction.__super__.tick.call(this, dt);
  };
  return XCRotateToAction;
}();
XCRotateByAction = function() {
  function XCRotateByAction(duration, angle, tag) {
    this.angle = angle;
    XCRotateByAction.__super__.constructor.call(this, duration, "XCRotateBy", tag);
    this.stepAngle = this.angle / this.duration;
    this.positiveRotation = this.angle > 0;
  }
  __extends(XCRotateByAction, XCRotateAction);
  return XCRotateByAction;
}();
XCEvent = function() {
  function XCEvent(name) {
    this.name = name;
  }
  return XCEvent;
}();
XCTapDownEvent = function() {
  function XCTapDownEvent(x, y, tapNumber) {
    this.tapNumber = tapNumber;
    this.point = {
      x: x,
      y: y
    };
    XCTapDownEvent.__super__.constructor.call(this, "tapDown");
  }
  __extends(XCTapDownEvent, XCEvent);
  return XCTapDownEvent;
}();
XCTapMovedEvent = function() {
  function XCTapMovedEvent(x, y, moveX, moveY, tapNumber) {
    this.tapNumber = tapNumber;
    this.point = {
      x: x,
      y: y
    };
    this.move = {
      x: moveX,
      y: moveY
    };
    XCTapMovedEvent.__super__.constructor.call(this, "tapMoved");
  }
  __extends(XCTapMovedEvent, XCEvent);
  return XCTapMovedEvent;
}();
XCTapUpEvent = function() {
  function XCTapUpEvent(x, y, tapNumber) {
    this.tapNumber = tapNumber;
    this.point = {
      x: x,
      y: y
    };
    XCTapUpEvent.__super__.constructor.call(this, "tapUp");
  }
  __extends(XCTapUpEvent, XCEvent);
  return XCTapUpEvent;
}();
XCKeyDownEvent = function() {
  function XCKeyDownEvent(key) {
    this.key = key;
    XCKeyDownEvent.__super__.constructor.call(this, "keyDown");
  }
  __extends(XCKeyDownEvent, XCEvent);
  return XCKeyDownEvent;
}();
XCKeyUpEvent = function() {
  function XCKeyUpEvent(key) {
    this.key = key;
    XCKeyUpEvent.__super__.constructor.call(this, "keyUp");
  }
  __extends(XCKeyUpEvent, XCEvent);
  return XCKeyUpEvent;
}();