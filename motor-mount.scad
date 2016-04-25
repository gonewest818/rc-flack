// Motor mount for Make Magazine's "Towel" RC plane
// designed to fit the Great Plains Ammo GPMG5190 motor
// version 1.

pt  =  3.0; // plate thickness
mr  = 28.0; // motor radius
ml  = 40.0; // motor length
mdx = 19.0; // mounting screw separation in x
mdy = 16.0; // mounting screw separation in y

module mounting_screw(rez=32) {
    translate([-(pt+1),0,0])
    color("red")
    rotate([0,90,0])
    cylinder(h=pt+2, d=3, $fn=rez);    
}

module propeller_shaft(rez=32) {
    translate([-(pt+1),0,0])
    color("green")
    rotate([0,90,0])
    cylinder(h=pt+2, d=6, $fn=rez);    
}

module motor_indent() {
    translate([-1,0,0])
    color("blue")
    rotate([0,90,0])
    cylinder(h=2, d=mr, $fn=rez);
}

module brace() {
    polyhedron(points = [[0,       0,      0],
                         [pt+ml,   0,      0],
                         [0,       0,  pt+mr],
                         [0,     -pt,      0],
                         [pt+ml, -pt,      0],
                         [0,     -pt,  pt+mr]],
               faces  = [[0, 1, 2],
                         [3, 5, 4],
                         [1, 0, 3, 4],
                         [2, 1, 4, 5],
                         [0, 2, 5, 3]],
               convexity = 10);
}

module tie_wrap(rez=32, color="blue") {
    translate([0,0,-1])
    color(color)
    cube([1.5, 3, pt+2]);    
}

union() {
    
    // front face
    difference() {
        translate([-pt, -pt, 0]) cube([pt, mr+2*pt, mr+pt]);
        union() { // cut-out mounting holes
            translate([0, (mr+mdx)/2, pt+mr/2]) mounting_screw();
            translate([0, (mr-mdx)/2, pt+mr/2]) mounting_screw();
            translate([0, mr/2, pt+(mr+mdy)/2]) mounting_screw();
            translate([0, mr/2, pt+(mr-mdy)/2]) mounting_screw();
            translate([0, mr/2, pt+mr/2]) propeller_shaft();
            // translate([0, mr/2, pt+mr/2]) motor_indent();
        }
    }
    
    // bottom plate
    difference() {
        translate([0, -pt, 0]) cube([pt+ml, mr+2*pt, pt]);
        union() { // cut-out mounting holes
            translate([pt, pt/2, 0]) tie_wrap();
            translate([mr-2*pt, pt/2, 0]) tie_wrap();
            translate([3*pt, mr-3*pt/2, 0]) tie_wrap();
            translate([mr, mr-3*pt/2, 0]) tie_wrap();
        }
    }
    
    // left brace
    brace();

    // right brace
    translate([0, pt+mr, 0]) brace();
}
