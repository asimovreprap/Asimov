// x-stepper-end is the left end of the X axis, it holds the stepper motor, is attached to the Z shaft with 
// linear ball bearings, and is moved by the Z leadscrew
// It also holds the two X shafts
// It is derived from the base x-end ( x_end_base )

include <libs/config.scad>;
include <base-components/x-end-basev0.scad>;

rotate(a=[0,90,0]){ x_motor_end(); }

module x_motor_end(){

    // Mirror the object as the base solid is the wrong way for this
    mirror([1,0,0]){ 

        difference(){
            
            // Base x-end solid : as both are a mirror, we only code it once
            x_end_base(); 

            // Remove extraneous solid
            translate([52,-junction_assurance_length,-junction_assurance_length]){
                cube([200,200,200]);
            }
       
            // NEMA17 stepper motor holes 
            translate([42/2+10,junction_assurance_length,x_end_box_height/2]){
                rotate(a=[90,0,0]){
                    // Central hole for stepper shaft and center
                    cylinder(h=10, r=28/2, center=true, $fn=30); 

                    // Holes for 4 fixation screws
                    for(rotation = [0:3]){
                        rotate(a=[0,0,rotation*90]){
                            translate([31/2,31/2,0]){
                                cylinder(h=200, r=3/2, center=true, $fn=10);
                                translate([0,0,-52]){ 
                                    cylinder(h=100, r=8/2, center=true, $fn=20);
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
