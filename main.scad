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

include <arm.scad>;
include <spindle.scad>;
//modes: "arm", "arm mirror", "spindle", "assembled", "exploded"
draw_model(mode="exploded",shaft_diameter=15,sheet_thickness=2,turbine_diameter=650);

module draw_model(mode="assembled",shaft_diameter,sheet_thickness,turbine_diameter,thickness=4,margin=10)
{
	if(mode=="arm")
	{
		arm (shaft_diameter,sheet_thickness,turbine_diameter,thickness,margin);
	}
	else if(mode=="arm mirror")
	{
		mirror([1,0,0]) arm(shaft_diameter,sheet_thickness,turbine_diameter,thickness,margin);
	}
	else if(mode=="spindle")
	{
		spindle(shaft_diameter,turbine_diameter,thickness);
	}
	else if(mode=="assembled")
	{
		for(th=[0,120,240])
			rotate(a=th) translate([0,-50,thickness]) arm(shaft_diameter,sheet_thickness,turbine_diameter,thickness,margin);
		spindle(shaft_diameter,turbine_diameter,thickness);
	}
	else if(mode=="exploded")
	{
		for(th=[0,120,240])
			rotate(a=th) translate([0,-50,thickness]) arm(shaft_diameter,sheet_thickness,turbine_diameter,thickness,margin);
		spindle(shaft_diameter,turbine_diameter,thickness);
	}
	else
	{
		echo( "invalid mode, expected one of arm, arm mirror, spindle, assembled, or exploded");
	}
}
