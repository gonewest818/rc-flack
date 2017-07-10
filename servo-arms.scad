// RC Flack - servo arms and horns for aileron/elevon control


// dimensions in mm
screw = 2.0;  // dimension of the M1.7x3 screw
inner = 4.0;  // dimension of the HS-55 spline (A1)
outer = 6.0;  // outside dimension of the housing
depth = 2.0;  // depth of barrel
hngr  = 3.0;  // dimension of the coathanger wire
armtk = 2.0;  // thickness of arm
easy  = 12.0; // short throw mounting hole
hard  = 24.0; // long throw mounting hole
half  = (easy+hard)/2.0;
chwid = 16.0;
chlen = 50.0;

// resolution of cylinders
rez = 32;

module arm() {
    difference() {
        union() {        
            // barrel
            difference() {
                cylinder(h=depth+armtk, d=outer, $fn=rez); // outer
                translate([0,0,armtk])
                    cylinder(h=depth, d=inner, $fn=rez);   // inner
            }
            // arm
            hull() {
                cylinder(h=armtk, d=outer+3, $fn=rez);
                translate([0, hard, 0])
                    cylinder(h=armtk, d=hngr+3, $fn=rez);
            }
        }
        // screws
        cylinder(h=depth+armtk, d=screw, $fn=rez); // M1.7
        translate([0, easy, 0])
            cylinder(h=depth+armtk, d=hngr, $fn=rez); // "easy"
        translate([0, half, 0])
            cylinder(h=depth+armtk, d=hngr, $fn=rez); // "half"
        translate([0, hard, 0])
            cylinder(h=depth+armtk, d=hngr, $fn=rez); // "hard"
    }
}

module arms(n=4, m=3) {
    for (i=[0:n-1]) {
        xs = outer*2;
        ys = (hard + 2*outer) * 1.1;
        for (j=[0:m-1])
            translate([i*xs, j*ys, 0]) arm();
    }
}

module control_horn() {
    radius=1;
    difference() {
        union() {
            // piece w/ hole
            minkowski() {
                translate([radius,radius,0])
                    cube([chwid-2*radius, chwid-2*radius, armtk-1]);
                cylinder(h=1, d=2*radius, $fn=32);
            }
            // mounting plate
            minkowski() {
                translate([0, radius, radius])
                    cube([armtk-1, chwid-2*radius, chlen-2*radius]);
                rotate([0,90,0])
                    cylinder(h=1, d=2*radius, $fn=32);
            }
            cube([armtk, chwid, armtk]);
        }
        // control wire hole
        translate([chwid/2, chwid/2, 0])
            cylinder(h=armtk, d=hngr, $fn=rez);
        // zip ties
        translate([0, 0, chlen*1/4])
            cube([armtk, 2.0, 4.0]);
        translate([0, 0, chlen*3/4])
            cube([armtk, 2.0, 4.0]);
        translate([0, chwid-2.0, chlen*1/4])
            cube([armtk, 2.0, 4.0]);
        translate([0, chwid-2.0, chlen*3/4])
            cube([armtk, 2.0, 4.0]);
    }
}

module horns(n=4, m=3) {
    for (i=[0:n-1]) {
        xs = chwid * 2;
        ys = chlen * 1.1;
        for (j=[0:m-1])
            translate([i*xs, chlen+j*ys, 0])
            rotate([90,0,0])
                control_horn();
    }
}



union() {
    horns(1,2);
    translate ([2*chwid, 0, 0]) arms(1,2);
}