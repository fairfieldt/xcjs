var s1 = xc_add_sprite('Icon.png', 1);

for (i = 0; i < 20; i++)
{
	for (j = 0; j < 20; j++)
	{
		var s2 = xc_add_sprite('Icon.png', 2);
		xc_draw(s2, i * 57, j*57, 1.0, 180);
	}
}
function xc_update(dt)
{
	xc_print(dt);

	var tap = xc_get_tap();
	if (tap)
	{
		xc_draw(s1, tap.x, tap.y, 1.0, 0);
	}
}