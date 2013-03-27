// Copyright 2013 Jonathan Hulka
//
// This program is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; either version 2 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
// 
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
// MA 02110-1301, USA.
// 
//

include <screws.scad>;
module spindle_sub(shaft_diameter,turbine_diameter,thickness=4)
{
	difference()
	{
		union()
		{
			cylinder(h=thickness,r=shaft_diameter/2+thickness*6+20,center=true);
			translate([0,0,thickness*2.5])
				cylinder(h=thickness*6,r=shaft_diameter/2+thickness*6,center=true);
			translate([0,0,10+thickness*2.5])
				cylinder(h=20+thickness*6,r=shaft_diameter/2+thickness*2,center=true);
		}
		for(th=[0,120,240]) rotate(a=th)
			translate([0,-thickness*8-shaft_diameter/2-5,thickness/2]) rotate(a=90,v=[1,0,0])
			linear_extrude(height=thickness*16,center=true)
				polygon(points=[[-thickness*2,0],[thickness*2,0],[0,thickness*4]]);
		screws(shaft_diameter,turbine_diameter,thickness);
	}
}
module spindle(shaft_diameter,turbine_diameter,thickness=4,with_shaft_hole=true)
{
	translate([0,0,thickness/2])
	{
		if(with_shaft_hole) difference()
		{
			spindle_sub(shaft_diameter,turbine_diameter,thickness);
			cylinder(h=40+thickness*17,r=shaft_diameter/2,center=true);
		}
		else spindle_sub(shaft_diameter,turbine_diameter,thickness);
	}
}
