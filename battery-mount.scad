// battery mount for Make Magazine's "Towel" RC airplane

// The concept is just a shallow box with hooks to allow
// rubber bands to be stretched across the top; just enough
// to keep the battery in place during flight but easy
// enough to remove for safe charging.

// overall dimensions in inches
_width = 1.5;
_length = 4.5;
_height = 0.33;

// conversion to mm
mm = 25.4;  // millimeters per inch
width = _width * mm;
length = _length * mm;
height = _height * mm;
tabs = 7;
thick = 1.5;

module base_plate() {
    difference() {
        // base plate
        translate([-tabs, 0, -thick])
            cube([length+2*tabs, width, thick]);
        // subtract cutouts for mounting w/ zip ties
        translate([-tabs/2, 0, -thick])
            cube([tabs/2, width/8, thick*2]);
        translate([-tabs/2, 7*width/8, -thick])
            cube([tabs/2, width/8, thick*2]);
        translate([length, 0, -thick])
            cube([tabs/2, width/8, thick*2]);
        translate([length, 7*width/8, -thick])
            cube([tabs/2, width/8, thick*2]);
    }
}

module box() {
    difference() {
        // form the outer box
        cube([length, width, height]);
        // hollow out the inside
        translate([thick, thick, 0])
            cube([length-2*thick, width-2*thick, height+thick]);
        // subtract cutouts for battery wires
        translate([length/2, thick, height/4])
            cube([length, width/4, height]);
        translate([length/2, width*3/4-thick, height/4])
            cube([length, width/4, height]);
    }
}

module peg(flip=0) {
    r1 = thick*1.25;
    r2 = thick*1.25;
    rotate([90, 90, 180*flip])
    translate([0, 0, -thick])
        cylinder(h=tabs*0.7+thick, r1=r1, r2=r2, $fn=16.0);
}

module pegs(n) {
    spacing = length/n;
    union() {
        for(i=[0:1:n-1]) {
            translate([spacing*(0.5+i), 0, height*0.66]) {
                peg(0);
                translate([0,width,0]) peg(1);
            }
        }
    }
}

// this is the full assembly
union() {
    base_plate();
    box();
    pegs(6);
}
