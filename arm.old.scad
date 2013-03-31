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
module arm(shaft_diameter,sheet_thickness,turbine_diameter,thickness=4,margin=10)
{
	difference()
	{
		union()
		{
			translate([0,0,thickness/2]) difference()
			{
				rotate(a=-13)intersection()
				{
					rotate_extrude() polygon(
						points=[
							[0,-thickness/2],[0,thickness*7/2],
							[turbine_diameter*1/8,thickness*7/2],
							[turbine_diameter*3/8,thickness/2],
							[turbine_diameter/2,thickness/2],
							[turbine_diameter/2,-thickness/2]]);
					linear_extrude(height=thickness*11,center=true) polygon(
						points=[[thickness*4,-5],
							[-thickness*4,-5],
							[0,-turbine_diameter],
							[turbine_diameter/2,-turbine_diameter]]);
				}
				union()
				{
					translate([turbine_diameter/2+thickness*2,0,turbine_diameter/2+thickness/2])
						cube(
							size=[turbine_diameter,turbine_diameter,turbine_diameter],
							center=true);
					translate([-turbine_diameter/2-thickness*2,0,turbine_diameter/2+thickness/2])
						cube(
							size=[turbine_diameter,turbine_diameter,turbine_diameter],
							center=true);
				}
				rotate(a=-9)
				translate([0,-turbine_diameter+turbine_diameter*0.14/2+margin/2,0])
					rotate(a=9)
						cube(size=turbine_diameter,center=true);
			}
			rotate(a=-9) //Move the wing into place
				translate([0,-turbine_diameter/2,0])
					rotate(a=9)
						wing(sheet_thickness,turbine_diameter,thickness,margin);
		}
		translate([0,0,-thickness])
			spindle(shaft_diameter,turbine_diameter,thickness,false);
		screws(shaft_diameter,turbine_diameter,thickness);
	}	
}
