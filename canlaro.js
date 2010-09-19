function Sprite(src, spriteWidth, spriteHeight, columns, rows) {
  this.img = new Image();
  this.img.src = src;
  this.frame = 0;
  this.animation = 0;
  this.animationFrame = 0;
  this.animationData = {};
  this.spriteWidth = spriteWidth;
  this.spriteHeight = spriteHeight;
  this.columns = columns;
  this.rows = rows;
  this.x = 0;
  this.y = 0;
  this.drawWidth = spriteWidth;
  this.drawHeight = spriteHeight;
  this.isXFlipped = false;
  this.isYFlipped = false;
  this.xScale = 1;
  this.yScale = 1;
  this.rotation = 0;
  this.alpha = 1;
  this.isAnimating = true;

  this.SetPosition = function(x, y) {
    this.x = x;
    this.y = y;
  };
  
  this.AddAnimation = function(id, frames, isLooping) { 
    this.animationData[id] = {
      frames: frames,
      isLooping: isLooping
    };
  };
  
  this.SetAnimation = function(id) {
    if (this.animation != id) {
        this.animationFrame = 0;
        this.animation = id;
    }
  }
  
  this.SetNextFrame = function() {
    this.frame = 0; //default;
    var nextFrame = this.animationFrame + 1;
    for(var animationId in this.animationData)
    {
      if (animationId == this.animation)
      {
        var currentAnimation = this.animationData[animationId];      
        if (nextFrame < currentAnimation.frames.length) {
          this.animationFrame++;
        }
        else {
          if (currentAnimation.isLooping) {
            this.animationFrame = 0;
          }
          //else do nothing
        }
        this.frame = currentAnimation.frames[this.animationFrame];
        break;
      }
    }    
    //if none set, then do nothing
  };
  
  this.Draw = function(context) {
    context.save();
    var centerX = this.spriteWidth * this.xScale / 2;
    var centerY = this.spriteHeight * this.yScale / 2;
    
    context.translate(
      this.isXFlipped ? (this.spriteWidth * this.xScale) + this.x - centerX: this.x + centerX,
      this.isYFlipped ? (this.spriteHeight * this.yScale) + this.y - centerY: this.y + centerY);
    context.scale(this.isXFlipped ? -1 : 1, this.isYFlipped ? -1 : 1);
    context.rotate(this.rotation * Math.PI / 180);
    
    context.globalAlpha = this.alpha;
    
    context.drawImage(this.img, 
      (Math.floor(this.frame % this.columns)) * this.spriteWidth,
      (Math.floor(frameY = this.frame / this.columns)) * this.spriteHeight,
      this.spriteWidth, this.spriteHeight,
      - centerX, - centerY,
    this.drawWidth * this.xScale, this.drawHeight * this.yScale);
    
    context.restore();
    
    if (this.isAnimating)
      this.SetNextFrame();
  };
}

function Tile(src, tileWidth, tileHeight, columns, rows) {
  this.img = new Image();
  this.img.src = src;
  this.tileIndex = 0;
  this.tileData = new Array();

  this.tileWidth = tileWidth;
  this.tileHeight = tileHeight;
  this.columns = columns;
  this.rows = rows;
  this.drawWidth = tileWidth;
  this.drawHeight = tileHeight;

  this.isXFlipped = false;
  this.isYFlipped = false;

  this.xScale = 1;
  this.yScale = 1;
  this.alpha = 1;

  this.AddTileId = function(id, tileNumber) {    
    this.tileData[id] = tileNumber;
  };
  
  this.SetTileId = function(tileId) {
    this.tileIndex = this.tileData[tileId];
  };
  
  this.SetTileIndex = function(tileIndex) {
    this.tileIndex = tileIndex;
  };
  
  this.Draw = function(context, x, y) {
    context.save();
    
    context.translate(
      this.isXFlipped ? (this.tileWidth * this.xScale) + x: x,
      this.isYFlipped ? (this.tileHeight * this.yScale) + y: y);
    context.scale(this.isXFlipped ? -1 : 1, this.isYFlipped ? -1 : 1);
    
    context.globalAlpha = this.alpha;    
    
    context.drawImage(this.img, 
      (Math.floor(this.tileIndex % this.columns)) * this.tileWidth,
      (Math.floor(this.tileIndex / this.columns)) * this.tileHeight,
      this.tileWidth, this.tileHeight,
      0, 0,
      this.drawWidth * this.xScale, this.drawHeight * this.yScale);
    
    context.restore();
  };
  
  this.DrawTile = function(context, tileId, x, y) {
    var temp = this.tileIndex;
    this.SetTileId(tileId);
    this.Draw(context, x, y);
    this.tileIndex = temp;
  };
}

function KeyboardInput() {
  this.keyState = new Array();
  this.keyDict = new Array();
  this.opposingKeys = new Array();

  this.AddKey = function(keyName, keyCode) {
    this.keyState[keyName] = false;
    this.keyDict[keyCode] = keyName;
  };
  
  this.RemoveKey = function(keyName) {
    //delete from keyState
    if (this.keyState.indexOf(keyName) != -1) {
      delete this.keyState(keyName);
    }
    //delete from keyDict    
    var idx = -1;
    for(var key in this.keyDict) {
      if (this.keyDict[key] == keyName) {
        idx = key;
        break;
      }
    }
    if (idx != -1) {
      delete this.keyDict[idx];
    }
  };
  
  this.AddOpposingKeys = function(keyName0, keyName1) {
    this.opposingKeys[keyName0] = keyName1;
    this.opposingKeys[keyName1] = keyName0;
  };
  
  this.RemoveOpposingKeys = function(keyName0, keyName1) {
    delete this.opposingKeys[keyName0];
    delete this.opposingKeys[keyName1];
  };
  
  this.OnKeyDown = function(evt) {
    var key = this.keyDict[evt.keyCode];
    if (key) {
      evt.preventDefault();
      this.keyState[key] = true;
      if (this.opposingKeys[key]) {
        this.keyState[this.opposingKeys[key]] = false;
      }
    }
  }
  
  this.OnKeyUp = function(evt) {
    var key = this.keyDict[evt.keyCode];
    if(key) {
      evt.preventDefault();
      this.keyState[key] = false;
    }
  }
}

function ResourceLoader() {
  this.Resources = {};
  
  this.AddImageResource = function(id , src) {
    var img = new Image();
    img.src = src;
    this.Resources[id] = {
      object:  img,
      type: "image"
    };
  };
  
  this.AddAudioResource = function(id, src) {
    this.Resources[id] = {
      object: new Audio(src),
      type: "audio"
    };
  };
  
  this.CopyResource = function(srcId, newId) {
    if (!this.Resources[srcId])
      return false;
    var type = this.Resources[srcId].type;
    var object;
    switch(type)
    {
      case "audio":
        object = new Audio(); break;
      case "image":
        object = new Image(); break;
    }
    object.src = this.Resources[srcId].object.src;
    this.Resources[newId] = {
      object: object,
      type: type
    };
    return true;
  };
  
  this.GetResource = function(id) {
    return this.Resources[id].object;
  };
  
  this.LoadAll = function() {
    var failCount = 0;
    for(var key in this.Resources)
    {
      var item = this.Resources[key];
      var obj = item.object;
      console.log(item);
      console.log(item.type);
      switch(item.type)
      {
        case "audio":
          if (obj.duration == 0) //something might have happened
          {
            obj.load();
            obj.muted = true;
            obj.play();
            if (obj.duration == 0)
              failCount++;
          }
          else
          {
            obj.muted = false;
          }
          break;
        case "image":
          if (!obj.complete) {
            obj.src = obj.src;
            failCount++;
          }
          break;
      }
    }
    if (failCount == 0)
      return true;
    else
      return false;
  };
}