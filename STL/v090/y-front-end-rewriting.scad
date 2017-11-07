$fn = 22;


module trou_vis() {
    cylinder(d = 6, h = 42);
    cylinder(d = 9, h=4);
}

difference() {
    union() {
        translate([0,0,10]) cube([170, 19, 20], center=true);
        points = [[0,-9.5],[0,12],[8,8]];
        translate([-85, 0, 0])
        rotate([0, 90, 0])         
        linear_extrude(170) 
        polygon(points=points);
    }
    // Branding
    #translate([-70, 3, -3]) rotate([155, 0 , 0]) linear_extrude(3) text("Asimov");
    #translate([15, 3, -3]) rotate([155, 0 , 0]) linear_extrude(3) text("3D Printer");
    // Central screw
    translate([0, 0, 10]) rotate([90, 0, 0]) cylinder(d = 6, h = 50, center = true);
    // Left screw
    translate([60, -10, 10]) rotate([270, 0, 0]) trou_vis();
    // Right screw
    translate([-60, -10, 10]) rotate([270, 0, 0]) trou_vis();
    // Left clip
    translate([-75, -7.5, 7]) cylinder(d = 8, h = 20);
    // Right clip
    translate([75, -7.5, 7]) cylinder(d = 8, h = 20);
    // Bridge
    translate([0, 10, 0]) scale([1.6, 1.5, 1]) cylinder(r = 10, h = 60, center=true);
    hull() {
        // Bearings place
        translate([0, 18.6, 10]) rotate([90, 0, 0]) cylinder(d = 14.5, h = 50, center = true);
        // Bearings insertions
        translate([0, 18.6, 20]) rotate([90, 0, 0]) cylinder(d = 15.5, h = 50, center = true);
    }
}

