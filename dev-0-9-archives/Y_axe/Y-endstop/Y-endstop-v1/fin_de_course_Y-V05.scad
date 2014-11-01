// CC-by-sa-3.0|Creative Commons Attribution ShareAlike 3.0 
// www.plateforme-c.org  - 16/10/2013

$fn=15;
module positif () {

//semelle


hull(){
 translate([ -9, -35, 0 ]) {
		cylinder(r = 1.75, h = 5, center = true);
	}
translate([ 0, 5.5, 0 ]) {
		cylinder(r = 1.75, h = 5, center = true);
	}
translate([ -6, 5.5, 0 ]) {
		cylinder(r = 1.75, h = 5, center = true);
	}
translate([ 8, -11, 0 ]) {
		cylinder(r = 1.75, h = 5, center = true);
	}
 translate([ 9, -35, 0 ]) {
		cylinder(r = 1.75, h = 5, center = true);
	}


}

//poteau
	translate([ -1.5, -2, 12.5 ]) {
		cube([5,18,25],center = true);
	}

	translate([ 2, -8, 12.5 ]) {
		cube([5,6,25],center = true);
	}


}


module negatif() {

//trous fixation capteur

translate([ 0, -2, 8.5 ]) {
rotate([0,90,0])
		cylinder(r = 1.5, h = 30, center = true);
	}
translate([ 0, -2, 17.5 ]) {
rotate([0,90,0])
		cylinder(r = 1.5, h = 30, center = true);
	}


	
hull() {
   translate([ 4.5, -21, 0 ]) {
		cylinder(r = 1.75, h = 30, center = true);
	}

	translate([ 4.5, -31, 0 ]) {
		cylinder(r = 1.75, h = 30, center = true);
	}
}

hull() {
	translate([ -4.5, -21, 0 ]) {
		cylinder(r = 1.75, h = 30, center = true);
	}

	translate([ -4.5, -31, 0 ]) {
		cylinder(r = 1.75, h = 30, center = true);
	}
}




}


difference() {
	positif();
	negatif();
};