#include "xc_node.h"
extern id the_scene;

CCNode *getInternalNodeFromNode(JSContext *cx, jsval node)
{
	JSObject *pNode;

	if (!JSVAL_IS_OBJECT(node))
	{
		return JS_FALSE;
	}
	if (! JS_ValueToObject(cx, node, &pNode))
	{
		return JS_FALSE;
	}
	
	jsval tag;
	if (!JS_GetProperty(cx, pNode, "sprite", &tag))
		return JS_FALSE;

	int id;

	if (!JS_ValueToInt32(cx, tag, &id))
		return JS_FALSE;

	id internalNode = [the_scene getChildByTag:id];
		return internalNode;
}

JSBool _xcNodeX(JSContext *cx, JSObject *obj, uintN argc, jsval *argv, jsval *rval)
{
	jsval node;

	if (!JS_ConvertArguments(cx, argc, argv, "o", &node))
			return JS_FALSE;

	CCNode *internalNode = getInternalNodeFromNode(cx, node);

	return JS_NewNumberValue(cx, internalNode.position.x, rval);
}

JSBool _xcNodeY(JSContext *cx, JSObject *obj, uintN argc, jsval *argv, jsval *rval)
{
	jsval node;

	if (!JS_ConvertArguments(cx, argc, argv, "o", &node))
			return JS_FALSE;

	CCNode *internalNode = getInternalNodeFromNode(cx, node);

	return JS_NewNumberValue(cx, 480 - internalNode.position.y, rval);
}
		
JSBool _xcNodeSetX(JSContext *cx, JSObject *obj, uintN argc, jsval *argv, jsval *rval)
{
	jsval node;
	double newX;
	if (!JS_ConvertArguments(cx, argc, argv, "od", &node, &newX))
		return JS_FALSE;
	printf("Setting x to %f\n", newX);

	CCNode *internalNode = getInternalNodeFromNode(cx, node);

	internalNode.position = ccp(newX, internalNode.position.y);
	printf("x is now %f\n", internalNode.position.x);
	return JS_TRUE;
}

JSBool _xcNodeSetY(JSContext *cx, JSObject *obj, uintN argc, jsval *argv, jsval *rval)
{
	jsval node;
	double newY;

	if (!JS_ConvertArguments(cx, argc, argv, "od", &node, &newY))
		return JS_FALSE;

	CCNode *internalNode = getInternalNodeFromNode(cx, node);

	internalNode.position = ccp(internalNode.position.x, 480 - newY);

	return JS_TRUE;
}

JSBool _xcNodeColor(JSContext *cx, JSObject *obj, uintN argc, jsval *argv, jsval *rval)
{
	jsval node;

	if (!JS_ConvertArguments(cx, argc, argv, "o", &node))
		return JS_FALSE;

	CCNode *internalNode = getInternalNodeFromNode(cx, node);
	
	ccColor3B color = [((CCSprite*)internalNode) color];
	JSObject *xcColor = JS_NewObject(cx, NULL, NULL, NULL);
	jsval r, g, b;

	JS_NewNumberValue(cx, color.r, &r);
	JS_NewNumberValue(cx, color.g, &g);
	JS_NewNumberValue(cx, color.b, &b);

	JS_DefineProperty(cx, xcColor, "r", r, NULL, NULL, 0);
	JS_DefineProperty(cx, xcColor, "g", g, NULL, NULL, 0);
	JS_DefineProperty(cx, xcColor, "b", b, NULL, NULL, 0);

	*rval = OBJECT_TO_JSVAL(xcColor);

	return JS_TRUE;

}
JSBool _xcNodeSetColor(JSContext *cx, JSObject *obj, uintN argc, jsval *argv, jsval *rval)
{
	jsval node;
	jsval newColor;

	if (!JS_ConvertArguments(cx, argc, argv, "oo", &node, &newColor))
		return JS_FALSE;

	JSObject *pColor;

	if (!JSVAL_IS_OBJECT(newColor))
	{
		return JS_FALSE;
	}
	if (! JS_ValueToObject(cx, newColor, &pColor))
	{
		return JS_FALSE;
	}
	
	jsval r, g, b;


	if (!JS_GetProperty(cx, pColor, "r", &r))
		return JS_FALSE;
	if (!JS_GetProperty(cx, pColor, "g", &g))
		return JS_FALSE;
	if (!JS_GetProperty(cx, pColor, "b", &b))
		return JS_FALSE;

	int internal_r, internal_g, internal_b;

	if (!JS_ValueToInt32(cx, r, &internal_r))
		return JS_FALSE;
	if (!JS_ValueToInt32(cx, g, &internal_g))
		return JS_FALSE;	
	if (!JS_ValueToInt32(cx, b, &internal_b))
		return JS_FALSE;

	CCNode *internalNode = getInternalNodeFromNode(cx, node);
	[((CCSprite*)internalNode) setColor: ccc3(internal_r, internal_g, internal_b)];

	return JS_TRUE;
}


JSBool _xcNodeScaleX(JSContext *cx, JSObject *obj, uintN argc, jsval *argv, jsval *rval)
{
	jsval node;

	if (!JS_ConvertArguments(cx, argc, argv, "o", &node))
			return JS_FALSE;

	CCNode *internalNode = getInternalNodeFromNode(cx, node);

	return JS_NewNumberValue(cx, internalNode.scaleX, rval);
}

JSBool _xcNodeScaleY(JSContext *cx, JSObject *obj, uintN argc, jsval *argv, jsval *rval)
{
	jsval node;

	if (!JS_ConvertArguments(cx, argc, argv, "o", &node))
			return JS_FALSE;

	CCNode *internalNode = getInternalNodeFromNode(cx, node);

	return JS_NewNumberValue(cx, internalNode.scaleY, rval);
}

JSBool _xcNodeSetScaleX(JSContext *cx, JSObject *obj, uintN argc, jsval *argv, jsval *rval)
{
	jsval node;
	double newScaleX;

	if (!JS_ConvertArguments(cx, argc, argv, "od", &node, &newScaleX))
		return JS_FALSE;

	CCNode *internalNode = getInternalNodeFromNode(cx, node);

	internalNode.scaleX = newScaleX;

	return JS_TRUE;
}

JSBool _xcNodeSetScaleY(JSContext *cx, JSObject *obj, uintN argc, jsval *argv, jsval *rval)
{
	jsval node;
	double newScaleY;

	if (!JS_ConvertArguments(cx, argc, argv, "od", &node, &newScaleY))
		return JS_FALSE;

	CCNode *internalNode = getInternalNodeFromNode(cx, node);

	internalNode.scaleY = newScaleY;

	return JS_TRUE;
}

JSBool _xcNodeRotation(JSContext *cx, JSObject *obj, uintN argc, jsval *argv, jsval *rval)
{
	jsval node;

	if (!JS_ConvertArguments(cx, argc, argv, "o", &node))
			return JS_FALSE;

	CCNode *internalNode = getInternalNodeFromNode(cx, node);

	return JS_NewNumberValue(cx, internalNode.rotation, rval);
}

JSBool _xcNodeSetRotation(JSContext *cx, JSObject *obj, uintN argc, jsval *argv, jsval *rval)
{
	jsval node;
	double newRotation;

	if (!JS_ConvertArguments(cx, argc, argv, "od", &node, &newRotation))
		return JS_FALSE;

	CCNode *internalNode = getInternalNodeFromNode(cx, node);

	internalNode.rotation = newRotation;

	return JS_TRUE;
}
	
JSBool _xcNodeOpacity(JSContext *cx, JSObject *obj, uintN argc, jsval *argv, jsval *rval)
{
	jsval node;

	if (!JS_ConvertArguments(cx, argc, argv, "o", &node))
			return JS_FALSE;

	CCNode *internalNode = getInternalNodeFromNode(cx, node);

	return JS_NewNumberValue(cx, ((CCSprite*)internalNode).opacity, rval);
}

JSBool _xcNodeSetOpacity(JSContext *cx, JSObject *obj, uintN argc, jsval *argv, jsval *rval)
{
	jsval node;
	double newOpacity;

	if (!JS_ConvertArguments(cx, argc, argv, "od", &node, &newOpacity))
		return JS_FALSE;

	CCNode *internalNode = getInternalNodeFromNode(cx, node);

	((CCSprite*)internalNode).opacity = newOpacity;

	return JS_TRUE;
}	
JSBool _xcNodeAnchorX(JSContext *cx, JSObject *obj, uintN argc, jsval *argv, jsval *rval)
{
	jsval node;

	if (!JS_ConvertArguments(cx, argc, argv, "o", &node))
			return JS_FALSE;

	CCNode *internalNode = getInternalNodeFromNode(cx, node);

	return JS_NewNumberValue(cx, ((CCSprite*)internalNode).anchorPoint.x, rval);
}

JSBool _xcNodeAnchorY(JSContext *cx, JSObject *obj, uintN argc, jsval *argv, jsval *rval)
{
	jsval node;

	if (!JS_ConvertArguments(cx, argc, argv, "o", &node))
			return JS_FALSE;

	CCNode *internalNode = getInternalNodeFromNode(cx, node);

	return JS_NewNumberValue(cx, ((CCSprite*)internalNode).anchorPoint.y, rval);
}

JSBool _xcNodeSetAnchorX(JSContext *cx, JSObject *obj, uintN argc, jsval *argv, jsval *rval)
{
	jsval node;
	double newAnchorX;

	if (!JS_ConvertArguments(cx, argc, argv, "od", &node, &newAnchorX))
		return JS_FALSE;

	CCNode *internalNode = getInternalNodeFromNode(cx, node);

	((CCSprite*)internalNode).anchorPoint.x = newAnchorX;

	return JS_TRUE;
}

JSBool _xcNodeSetAnchorY(JSContext *cx, JSObject *obj, uintN argc, jsval *argv, jsval *rval)
{
	jsval node;
	double newAnchorY;

	if (!JS_ConvertArguments(cx, argc, argv, "od", &node, &newAnchorY))
		return JS_FALSE;

	CCNode *internalNode = getInternalNodeFromNode(cx, node);

	((CCSprite*)internalNode).anchorPoint.y = newAnchorY;

	return JS_TRUE;
}

JSBool _xcTextSetText(JSContext *cx, JSObject *obj, uintN argc, jsval *argv, jsval *rval)
{
	jsval node;
	double newAnchorY;

	if (!JS_ConvertArguments(cx, argc, argv, "od", &node, &newAnchorY))
		return JS_FALSE;

	CCNode *internalNode = getInternalNodeFromNode(node);

	internalNode.anchor.y = newAnchorY;

	return JS_TRUE;
}

