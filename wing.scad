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

module wing(sheet_thickness,turbine_diameter,thickness=4,margin=10)
{
	slot_offset=sheet_thickness/2;
	wing_radius=turbine_diameter*0.14/2;
	tail_length=turbine_diameter*0.4-wing_radius;
	translate([0,0,thickness/2]) difference()
	{
		union()
		{
			difference()
			{
				//Outer radius
				cylinder(h=thickness,r=wing_radius+margin+slot_offset,center=true);
				//cut in half
				translate([(wing_radius+margin+slot_offset)/2+1,0,0])
					cube(size=[wing_radius+margin+slot_offset+2,(wing_radius+margin+slot_offset)*2+1,thickness+3], center=true);
			}
			linear_extrude(height=thickness,center=true) polygon(
				points=[
					[0,-1*(wing_radius+margin+slot_offset)],
					[0,wing_radius+margin+slot_offset],
					[tail_length,wing_radius+margin+slot_offset],
					[tail_length,wing_radius-margin-slot_offset]],
				paths=[[0,1,2,3]]
			);
			//Rounded margins around the slot endpoints (make sure no point is less than margin distance from the edge)
			translate([tail_length,wing_radius,0]) cylinder(h=thickness,r=margin+slot_offset,center=true);
			translate([0,-1*wing_radius,0]) cylinder(h=thickness,r=margin+slot_offset,center=true);
			//Screw mount
			for(offset=[-thickness/2-slot_offset,thickness/2+slot_offset])
			translate([thickness*2.5+tail_length/4,wing_radius+offset,thickness*2.5])
				cube(size=[thickness*5,thickness,thickness*6],center=true);
		}
		union() //The blade shape to be cut out
		{
			difference() //Semicircle 'head'
			{
				difference() //Outer cylinder minus inner cylinder
				{
					cylinder(h=thickness+1,r=wing_radius+slot_offset,center=true);
					cylinder(h=thickness+2,r=wing_radius-slot_offset,center=true);
				}
				//cut in half
				translate([(wing_radius+sheet_thickness)/2+1,0,0])
					cube(size=[wing_radius+sheet_thickness+2,wing_radius*2+sheet_thickness+1,thickness+3], center=true);
			}
			//The 'tail'
			translate([tail_length/2-0.25,wing_radius,0])
			cube(size=[tail_length+0.5,sheet_thickness,thickness+1],center=true);
			//Screw hole
			translate([thickness*2.5+tail_length/4,0,thickness*3])rotate(a=90,v=[1,0,0])cylinder(h=turbine_diameter,r=thickness*1/3,center=true);
		}
	}
}
