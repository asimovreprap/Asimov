//
// (c) Andreas Thorn (andreas.thorn@gmail.com)
//	Thingiverse: 
//	
// Licence: Attribution - Share Alike - Creative Commons
//


//{{{ Info, Changelog
/*************************************************************************************************
...

Changelog;
102 Some cleanup before publishing
101	Module created for hotend.
100	Initial work. Most of the hidden measurements are only guessed.
**************************************************************************************************/
//}}}
//{{{ Variables and constants
shim = 0.1;								// used overlap meshes/cutouts
$fn = 60;

dim=[40,40];
//}}}


hexagon_hotend();

/*
// These modules are not used in this project but left in the
// code since they are handy.

// Create dimensionally correct inner holes
// http://hydraraptor.blogspot.se/2011/02/polyholes.html
module polyhole(h, d) {
    n = max(round(2 * d),3);
    rotate([0,0,180])
        cylinder(h = h, r = (d / 2) / cos (180 / n), $fn = n);
}

// Use cylinda module instead of cylinder to optionally use Polyhole module for
// dimensionally correct circular holes where it is required.
module cylinda(diam=1,height=1,fn=60,polyhole=0)
{
	if (polyhole==1)
	{
		polyhole(h=height,d=diam);
	} else {
		cylinder(r=diam/2,h=height,$fn=fn);
	}
}
*/


module hexagon_hotend() {
//translate([0,0,-20]) {
	translate([0,0,6+0.2]) {
		// Stainless heat break
		translate([0,0,10+2+2+0.1])
		difference() {
			color([0.5,1.0,0.7,1.0])
			union() {
				// Narrow part
				translate([0,0,-2])
				cylinder(r=2.5/2,h=2+21.9+4.2+4.4+4.8-4.7);
				
				// Part inside heat sink. Depth/height just a guess.
				translate([0,0,0])
				cylinder(r=6/2,h=8);
				
				// Part inside heat sink. Depth/height just a guess.
				translate([0,0,-2-6.1])
				cylinder(r=6/2,h=6.1);
			}
			
			// Through hole. Radius just a guess.
			translate([0,0,-2-6.1-shim])
			cylinder(r=1.9/2,h=2+8+21.9+4.2+4.4+4.8-4.7+(2*shim));
		}
		
		// Heat block
		translate([-4.5,-16/2,0])
		difference() {
			color([0.5,0.7,1.0,1.0])
			//color([0.5,0.7,1.0,0.5])		// Transparency to show the inside
			hull() {
				translate([4/2,0,0]) {
					translate([0,4/2,0])
					cylinder(r=4/2,h=10);
					
					translate([0,16-(4/2),0])
					cylinder(r=4/2,h=10);
				}
				
				translate([18-(4/2),0,0]) {
					translate([0,4/2,0])
					cylinder(r=4/2,h=10);
					
					translate([0,16-(4/2),0])
					cylinder(r=4/2,h=10);
				}
			}
			
			// Ceramic heater hole
			color([0.9,0.9,0.5,1.0])
			translate([18-(3+(6/2)),-shim,2+(6/2)])
			rotate([3*90,0,0])
			cylinder(r=6/2,h=16+(2*shim));
			
			// Grub screw hole M3
			color([0.9,0.9,0.5,1.0])
			translate([18+shim,16/2,2+(6/2)])
			rotate([0,3*90,0])
			cylinder(r=3/2,h=2+(6/2));
			
			// Heat break hole/nozzle hole
			color([0.9,0.9,0.5,1.0])
			translate([4.5,16/2,-shim])
			cylinder(r=5/2,h=10+(2*shim));
	
			// Hole for thermistor - TOTAL GUESS!!! h=4 for sure.
			color([0.9,0.9,0.5,1.0])
			translate([5,-shim,5])
			rotate([3*90,0,0])
			cylinder(r=2.4/2,h=4+shim);
		}
		
		// Nozzle
		translate([0,0,-6-0.2])
		color([1.0,0.7,1.0,1.0])
		difference() {
			union() {
				// Nozzle tip
				cylinder(r1=1.3/2,r2=8.8/2,h=3);
				
				// Nozzle cylinder
				translate([0,0,3])
				cylinder(r=8.8/2,h=3);
				
				// Nozzle top taper
				translate([0,0,3+3])
				cylinder(r1=8.8/2,r2=8.2/2,h=0.2);
				
				// Nozzle between taper and thread
				translate([0,0,3+3+0.2])
				cylinder(r=5/2,h=1.5);
				
				// Nozzle thread
				translate([0,0,3+3+0.2+1.5])
				cylinder(r=6/2,h=6-1.5);
			}
			
			// Nozzle orifice
			translate([0,0,-shim])
			cylinder(r=0.4/2,h=2+shim);
			
			// Through hole. Radius just a guess.
			translate([0,0,2-shim])
			cylinder(r=1.9/2,h=12-2+(2*shim)+(2*shim));
			
			translate([-(8.8/2)-shim,-(8.8/2)-shim,-shim])
			cube([8.8+(2*shim),(8.8-7)/2,3+3+0.2+(2*shim)]);
	
			mirror([0,1,0])
			translate([-(8.8/2)-shim,-(8.8/2)-shim,-shim])
			cube([8.8+(2*shim),(8.8-7)/2,3+3+0.2+(2*shim)]);
		}
		// Cold end
		translate([0,0,10+2+2+0.1])
		//color([0.7,0.7,0.7,0.5])		// Transparency to show the inside
		color([0.7,0.7,0.7,1.0])
		difference() {
			union() {
				// Cooling fins
				for (i=[0:2:19]) {
					translate([0,0,i*1.15])
					cylinder(r=18.3/2,h=1.2,$fn=6);
				}
				
				// Cooling fins core
				cylinder(r=9/2,h=21.9);
				
				// JR mount lower flange
				translate([0,0,21.9])
				cylinder(r=15.9/2,h=4.2);
				
				// JR mount mid flange
				translate([0,0,21.9+4.2])
				cylinder(r=12/2,h=4.4);
				
				// JR mount top flange
				translate([0,0,21.9+4.2+4.4])
				cylinder(r=15.9/2,h=4.8);
			}
			
			// Through hole
			translate([0,0,-shim])
			cylinder(r=2.5/2,h=21.9+4.2+4.4+4.8+(2*shim));
			
			// Top hole for brass insert/bowden/pneumatic quick connect
			translate([0,0,21.9+4.2+4.4+4.8-4.7])
			cylinder(r=5/2,h=4.7+(2*shim));
			
			// Bottom hole for stainless heat break. Depth/height just a guess.
			translate([0,0,-shim])
			cylinder(r=6/2,h=8+shim);
		}

	}
}
