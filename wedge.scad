//Creates a wedge-shaped section of a cylinder
//The result is centered with the open part of the wedge facing in the positive y direction
//h - height
//r - radius
//a - angle
module wedge(h,r,a)
{
	th=(a%360)/2;
	difference()
	{
		cylinder(h=h,r=r,center=true);
		if(th<90)
		{
			for(n=[-1,1])rotate(-th*n)translate([(r+0.5)*n,0,0])
				cube(size=[r*2+1,r*2+1,h+1],center=true);
		}
		else
		{
			intersection()
			{
				rotate(-th)translate([(r+0.5),(r+0.5),0])
					cube(size=[r*2+1,r*2+1,h+1],center=true);
				rotate(th)translate([-(r+0.5),(r+0.5),0])
					cube(size=[r*2+1,r*2+1,h+1],center=true);
			}
		}
	}
}