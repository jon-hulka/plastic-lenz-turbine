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
include <wing.scad>;
include <spindle.scad>;
include <screws.scad>;
include <wedge.scad>;
module arm(shaft_diameter,sheet_thickness,turbine_diameter,thickness=4,margin=10)
{
	difference()
	{
		union()
		{
			translate([0,0,thickness/2]) difference()
			{
				intersection()
				{
					union()
					{
						//Flat bottom part
						translate([0,turbine_diameter/8,0])mirror([0,1,0])wedge(h=thickness,r=turbine_diameter,a=20);
						//Reinforcing rib - fades into the arm near the end
						rotate([90+asin(thickness*3/(turbine_diameter*(0.8)/2-margin*3)),0,0])translate([0,thickness,turbine_diameter/2-thickness/2])
						{
							cube(size=[thickness*4,thickness*2,turbine_diameter],center=true);
							translate([0,thickness,0])cylinder(h=turbine_diameter,r=thickness*2,center=true);
						}
					}
					//Flatten the bottom and trim off anything that might overlap other arms
					translate([0,-1,thickness*2])mirror([0,1,0])wedge(h=thickness*5,r=turbine_diameter,a=120);
				}
				//extend 1/2 margin into wing piece
				rotate(a=-14)
				translate([0,-turbine_diameter*(1-0.14/2)+margin/2,0])
					rotate(a=9)
						cube(size=turbine_diameter,center=true);
			}
			rotate(a=-14) //Move the wing into place
				translate([0,-turbine_diameter/2,0])
					rotate(a=9)
						wing(sheet_thickness,turbine_diameter,thickness,margin);
		}
		translate([0,0,-thickness])
			spindle(shaft_diameter,turbine_diameter,thickness,false);
		screws(shaft_diameter,turbine_diameter,thickness);
	}	
}
