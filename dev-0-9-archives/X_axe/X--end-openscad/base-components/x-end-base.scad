// Base solid for X ends : holds linear ball bearings and leadscrew nuts for the stepper and bearing ends of the X axis

// Part-specific values
x_end_leadscrew_nut_holder_height = 8;
z_linear_bearing_top_holder_height = 2;

// Fixation holes for leadscrew nut
z_nut_type = 2;

module x_end_base(){

    union(){
       
       difference(){
            // Base box for this form
            // length = 120mm because we are going to cut it down later
            // depth  = 30mm is the base length, to keep 15mm around the center of the shafts
            // height = 70mm by default by convention, the distance between the two X shafts being 50mm by convention, 
            //          this leaves enough room for holding at any shaft diameter
            cube([120,30,x_end_box_height]);

            // Holes for both X shafts 
            for( height = [10,x_end_box_height-10] ){
                translate([0,15,height]){
                    rotate([0,90,0]){ 
                        cylinder(h = 300, 
                                 r = (x_axis_shaft_diameter/2) + holes_extra_radius_compensation , 
                                 center = true, 
                                 $fn=20);
                    } 
                }
            }
            
            // Slots for x shaft holes pressure
            for( height = [4,x_end_box_height-3] ){
                translate([-junction_assurance_length,15-(x_axis_pressure_slot_width/2)+1,-junction_assurance_length+height]){ 
                    rotate([90,0,0]){ cube([200,1,2]); }
                    cube([200,1,4+6]);
                    translate([0,-2,-3-6]){ cube([200,1,4+6]); }					 
                }
            }

            // Pulley/belt hole
            translate([-junction_assurance_length,5,20]){
                cube([300,20,30]);
            }
        }

        // Holding box for the Z linear ball bearings
        translate([0,30-junction_assurance_length,0]){ 
            difference(){
            
                // Base holder
                cube([z_linear_bearing_outside_diameter + 2*2 + 4, 
                     ( z_linear_bearing_outside_diameter + 2*2 ) + junction_assurance_length , 
                     x_end_box_height]);
       
                // The hole for the linear bearings themselves
                translate([(z_linear_bearing_outside_diameter + 2*2)/2,
                           (z_linear_bearing_outside_diameter + 2*2)/2,
                           -z_linear_bearing_top_holder_height]){
                    cylinder(h = x_end_box_height*2,
                             r = (z_linear_bearing_outside_diameter/2) + holes_extra_radius_compensation, 
                             center = true, 
                             $fn=20); 
                }
 
                // Holder at the top, with a smaller diameter
                translate([(z_linear_bearing_outside_diameter + 2*2)/2,
                           (z_linear_bearing_outside_diameter + 2*2)/2,
                           0]){
                    cylinder(h = 200, r = (z_axis_shaft_diameter/2)+2 , center = true, $fn=20); 
                }
                translate([1,17.5,100]){
                    rotate([0,90,0]){
                        translate([0,1,0]){ rotate([90,0,0]){ cube([200,1,2.5]); } }
                        cube([200,1,4+6]);
                        translate([0,-2,-3-6]){ cube([200,1,4+6]); }
                    }
                }
            }
        }

        // Holding box for the Z leadscrew nut
        translate([z_linear_bearing_outside_diameter + 2*2 - junction_assurance_length, 
                   30 - junction_assurance_length, 
                   x_end_box_height - x_end_leadscrew_nut_holder_height]){ 
            
            difference(){
         
                // Base holder
                cube([30 + junction_assurance_length, 
                     ( z_linear_bearing_outside_diameter + 2*2 ) + junction_assurance_length , 
                     x_end_leadscrew_nut_holder_height]);

                // Holes
                // Aligned with the linear ball bearing in X, and distant from it by z_shaft_to_leadscrew_distance
                translate([z_shaft_to_leadscrew_distance - (z_linear_bearing_outside_diameter + 2*2)/2,
                          (z_linear_bearing_outside_diameter + 2*2)/2,
                          -junction_assurance_length]){   
                    
                    // Main ( leadscrew ) hole
                    cylinder(h = 200, r = ((z_leadscrew_diameter+2)/2)+holes_extra_radius_compensation, center = true, $fn=20); 

                    // Holes for fixation screws for leadscrew nut ( 4 holes, larger nut size )
                    if( z_nut_type == 0 ){
                        for(rotation = [0:3]){
                            // Rotation of the hole around the center hole
                            rotate(a=[0,0,45+(90*rotation)+45]){
                                translate([9.5,0,0]){
                                    // Rotation of the hole around itself 
                                    rotate(a=[0,0,(90*rotation)+90]){
                                        translate([1.5,0,0]){
                                            cylinder(h=100, r=(z_leadscrew_nut_screw_diameter/2)+holes_extra_radius_compensation, center = true, $fn=20);
                                        }
                                        translate([-1.5,0,0]){
                                            cylinder(h=100, r=(z_leadscrew_nut_screw_diameter/2)+holes_extra_radius_compensation, center = true, $fn=20);
                                        }
                                        translate([-1.5,0-(  ((z_leadscrew_nut_screw_diameter+2)/2)+holes_extra_radius_compensation  )/2,0]){ cube([3, ((z_leadscrew_nut_screw_diameter+2)/2)+holes_extra_radius_compensation, 200]); }
                                    } 
                                }
                            }
                        }
                    }

                    // Holes for fixation screws for leadscrew nut ( alternative: 4 holes, smaller nut size )
                    if( z_nut_type == 1 ){
                        for(rotation = [0:3]){
                            // Rotation of the hole around the center hole
                            rotate(a=[0,0,(90*rotation)]){
                                translate([7,0,0]){
                                    // Rotation of the hole around itself 
                                    rotate(a=[0,0,(90*rotation)]){
                                        translate([1.5,0,0]){
                                            cylinder(h=100, r=(z_leadscrew_nut_screw_diameter/2)+holes_extra_radius_compensation, center = true, $fn=20);
                                        }
                                        translate([-1.5,0,0]){
                                            cylinder(h=100, r=(z_leadscrew_nut_screw_diameter/2)+holes_extra_radius_compensation, center = true, $fn=20);
                                        }
                                        translate([-1.5,0-(  ((z_leadscrew_nut_screw_diameter+2)/2)+holes_extra_radius_compensation  )/2,0]){ cube([3, ((z_leadscrew_nut_screw_diameter+2)/2)+holes_extra_radius_compensation, 200]); }
                                    } 
                                }
                            }
                        }
                    }


                    // Holes for fixation screws for leadscrew nut ( alternative: 3 holes, larger nut size )
                    if( z_nut_type == 2 ){
                        for(rotation = [0:2]){
                            // Rotation of the hole around the center hole
                            rotate(a=[0,0,(120*rotation)+180]){
                                translate([11,0,0]){
                                    // Rotation of the hole around itself 
                                    rotate(a=[0,0,(60*rotation)+180]){
                                        translate([1.5,0,0]){
                                            cylinder(h=100, r=(z_leadscrew_nut_screw_diameter/2)+holes_extra_radius_compensation, center = true, $fn=20);
                                        }
                                        translate([-1.5,0,0]){
                                            cylinder(h=100, r=(z_leadscrew_nut_screw_diameter/2)+holes_extra_radius_compensation, center = true, $fn=20);
                                        }
                                        translate([-1.5,0-(  ((z_leadscrew_nut_screw_diameter+2)/2)+holes_extra_radius_compensation  )/2,0]){ cube([3, ((z_leadscrew_nut_screw_diameter+2)/2)+holes_extra_radius_compensation, 200]); }
                                    } 
                                }
                            }
                        }
                    }


                }
            }
        }
    }
}


