// Motor mount for Make Magazine's "Towel" RC plane
// designed to fit the Great Plains Ammo GPMG5190 motor
// version 6

pt  =  1.25; // plate thickness
mr  = 28.5; // motor radius
ml  = 35.0; // motor length
mdx = 19.0; // mounting screw separation in x
mdy = 16.0; // mounting screw separation in y
sd  =  3.2; // mounting screw diameter
pd  = 13.0; // propeller hole diameter
rez = 32.0; // resolution for mounting holes

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

module motor_barrel() {
    rotate([0,90,0])
    difference() {
        union() {
            cylinder(h=ml+pt, d=mr+2*pt, $fn=2*rez);
            translate([pt/2,-mr*0.4,0])
            cube([mr/2, mr*0.8, ml+pt]);
        }
        translate([0,0,-0.5])
        cylinder(h=ml+pt+1, d=mr, $fn=2*rez);
    }
}

module tie_wrap() {
    translate([0,0,-1])
    cube([4, 2, pt+2]);    
}


translate([0,0,pt])
rotate([0,-90,0])
union() {

    // barrel
    translate([0, mr/2, pt+mr/2]) motor_barrel();

    // front face
    difference() {
        translate([-pt, -pt, 0]) cube([pt, mr+2*pt, mr+2*pt]);
        
        union() { // cut-out mounting holes
            translate([0, (mr+mdx)/2, pt+mr/2]) mounting_screw();
            translate([0, (mr-mdx)/2, pt+mr/2]) mounting_screw();
            translate([0,       mr/2, pt+mr/2]) propeller_shaft();
        }
    }
    
    // bottom plate
    difference() {
        translate([-pt, -pt-15.0, 0]) cube([2*pt+ml, mr+2*pt+2*15.0, pt]);

        union() { // cut-out tie-wrap holes
            translate([2*pt,     -14.0+pt/2, 0]) tie_wrap();
            translate([  mr,     -14.0+pt/2, 0]) tie_wrap();
            translate([2*pt, mr+15.0-6*pt/2, 0]) tie_wrap();
            translate([  mr, mr+15.0-6*pt/2, 0]) tie_wrap();
        }
    }
}
