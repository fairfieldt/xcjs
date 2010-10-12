class GridEntity extends XCSpriteNode
	constructor: (imageName, @map, @type, @gridX, @gridY) ->

		super(imageName, @map.gridSize, @map.gridSize)
		this.setX( @gridX * @map.gridSize)
		this.setY(@gridY * @map.gridSize)
		
		@map.addChild(this)
		
	gridMove: (x, y) ->
		@map.tiles[@gridX][@gridY] = "empty"
		@map.tiles[@gridX+x][@gridY+y] = this
		this.moveBy(x * @map.gridSize, y * @map.gridSize)
		this.gridX += x
		this.gridY += y
