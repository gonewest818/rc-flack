// Motor mount for Make Magazine's "Towel" RC plane
// designed to fit the Great Plains Ammo GPMG5190 motor
// version 1.

pt  =  3.0; // plate thickness
mr  = 28.0; // motor radius
ml  = 40.0; // motor length
mdx = 19.0; // mounting screw separation in x
mdy = 16.0; // mounting screw separation in y
sd  =  3.2; // mounting screw diameter
pd  =  6.0; // propeller diameter
rez = 32.0; // resolution for holes

module mounting_screw() {
    translate([-(pt+1),0,0])
    rotate([0,90,0])
    cylinder(h=pt+2, d=sd, $fn=rez);    
}

module propeller_shaft() {
    translate([-(pt+1),0,0])
    rotate([0,90,0])
    cylinder(h=pt+2, d=pd, $fn=rez);    
}

module motor_indent() {
    translate([-1,0,0])
    rotate([0,90,0])
    cylinder(h=2, d=mr, $fn=rez);
}

module brace() {
    translate([0,0,pt])
    rotate([90,0,0])
    linear_extrude(pt)
    polygon([[    0,  0],
             [    0, mr],
             [pt+ml,  0]]);
}

module tie_wrap() {
    translate([0,0,-1])
    cube([1.5, 3, pt+2]);    
}

union() {
    
    // front face
    difference() {
        translate([-pt, -pt, 0]) cube([pt, mr+2*pt, mr+pt]);
        
        union() { // cut-out mounting holes
            translate([0, (mr+mdx)/2,       pt+mr/2]) mounting_screw();
            translate([0, (mr-mdx)/2,       pt+mr/2]) mounting_screw();
            translate([0,       mr/2, pt+(mr+mdy)/2]) mounting_screw();
            translate([0,       mr/2, pt+(mr-mdy)/2]) mounting_screw();
            translate([0,       mr/2,       pt+mr/2]) propeller_shaft();
         // translate([0,       mr/2,       pt+mr/2]) motor_indent();
        }
    }
    
    // bottom plate
    difference() {
        translate([0, -pt, 0]) cube([pt+ml, mr+2*pt, pt]);

        union() { // cut-out mounting holes
            translate([  pt,      pt/2, 0]) tie_wrap();
            translate([  mr,      pt/2, 0]) tie_wrap();
            translate([3*pt, mr-3*pt/2, 0]) tie_wrap();
            translate([  mr, mr-3*pt/2, 0]) tie_wrap();
        }
    }
    
    // left brace
    brace();

    // right brace
    translate([0, pt+mr, 0]) brace();
}
