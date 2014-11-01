// x-bearing-end is the right end of the X axis, it holds the bearing for the pulley, is attached to the Z shaft with 
// linear ball bearings, and is moved by the Z leadscrew
// It also holds the two X shafts
// It is derived from the base x-end ( x_end_base )

include <../config.scad>;
include <base-components/x-end-base.scad>;

// Component-specific calculated values
bearing_holder_distance = z_linear_bearing_outside_diameter + 2*2 + 10; 

rotate(a=[0,270,0]){ x_bearing_end(); }

module x_bearing_end(){
    difference(){
        union(){
            // Base x-end solid : as both are a mirror, we only code it once
            x_end_base(); 
        }

        // Remove extraneous solid
        translate([52,-junction_assurance_length,-junction_assurance_length]){
            cube([200,200,200]);
        }


        // Holes for 5mm bearing holder bolt
        translate([bearing_holder_distance, 0, x_end_box_height/2]){ 
            rotate(a=[90,0,0]){
                cylinder(h=200, r=(5/2)+holes_extra_radius_compensation, center=true, $fn=10);
            }
        }
    }

}
