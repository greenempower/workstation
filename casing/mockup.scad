function inmm(inch_qnt) = inch_qnt* 25.4;

ext_rad = 20;
extrad2 = (ext_rad*2);

small_ext = [ext_rad, 150, ext_rad]; // these are cheap aluminum extrusions on aliexpress

pillar_ext = [20, 20, 500];
horizontal_ext = [450, 20, 20];


radiator = [33, 121, inmm(15.5)];

// dimensions of a 3.5" hard drive from https://members.snia.org/document/dl/25862
hdd = [101.6, 147, 42];
hdd_mnt = 3.175; //offset of screw mount from edge

fan = [25, 120, 120];

boarddep = inmm(1/8);

mobo_dimm = [inmm(12), 2, inmm(13)];
psu_dimm = [inmm(6+(1/2)), inmm(5+(7/8)), inmm(3+(3/8))];
mnt_board_dimm = [horizontal_ext.x, inmm(1/8), pillar_ext.z-psu_dimm.z-ext_rad-hdd.z-10];

//plywood mounting board

//a small extrusion for supporting the other end of the psu
//translate([psu_dimm.x-ext_rad, ext_rad, 0]) color("sienna") cube(small_ext);
// a small extrusion for supporting hard drives
x_of_small_ext_for_hdd_support = horizontal_ext.x-hdd.x-(ext_rad/2)+hdd_mnt+hdd_mnt-(ext_rad/2);
//translate([x_of_small_ext_for_hdd_support, ext_rad, 0]) color("sienna") cube(small_ext);

color("sienna") {
    translate([radiator.x+fan.x+65, ext_rad, 0]) cube(small_ext);
    translate([horizontal_ext.x-psu_dimm.x, ext_rad, 0]) cube(small_ext);
}

color("NavajoWhite", 0.6) translate([0, ext_rad, ext_rad]) cube([horizontal_ext.x, small_ext.y, boarddep]);

// hard drives
color("green", 0.5) {
    //translate([horizontal_ext.x-hdd.x-(ext_rad/2)+hdd_mnt, ext_rad+boarddep, ext_rad+2]) cube(hdd);
    translate([horizontal_ext.x-hdd.x-ext_rad-10, ext_rad+boarddep, ext_rad+2]) cube(hdd);
    translate([164, ext_rad+5, ext_rad+boarddep]) cube(hdd);
    translate([21, ext_rad+5, ext_rad+boarddep]) cube(hdd);

}


color("white") {
    translate([0, 0, 20]) cube(pillar_ext);
    translate([horizontal_ext.x-ext_rad, 0, 20])    cube(pillar_ext);
    translate([0, ext_rad+small_ext.y, ext_rad])    cube(pillar_ext);
    translate([horizontal_ext.x-ext_rad, ext_rad+small_ext.y, ext_rad]) cube(pillar_ext);
    
    translate([radiator.x+fan.x+65, 0, ext_rad]) cube(pillar_ext);
}

color("sienna") {
    translate([0, ext_rad, 0]) cube(small_ext);
    translate([horizontal_ext.x-ext_rad, ext_rad, 0]) cube(small_ext);
    translate([0, ext_rad, pillar_ext.z+ext_rad]) cube(small_ext);
    translate([horizontal_ext.x-ext_rad, ext_rad, pillar_ext.z+ext_rad]) cube(small_ext);
}

color("red") {
    cube(horizontal_ext);
    translate([0, 0, 20+pillar_ext.z]) cube(horizontal_ext);
    translate([0, small_ext.y+ext_rad, 0]) cube(horizontal_ext);
    translate([0, small_ext.y+ext_rad, 20+pillar_ext.z]) cube(horizontal_ext);
}


// radiator
translate([0, ext_rad+15, (pillar_ext.z-radiator.z)+ext_rad]) color("blue", 0.5) cube(radiator);
//translate([ext_rad, ext_rad+10, (pillar_ext.z-radiator.z)+ext_rad]) color("blue") cube([radiator.z, radiator.y, radiator.x]);

// fans
color("lightblue", 0.6) {
    translate([radiator.x, ext_rad+15, (pillar_ext.z-fan.z)+ext_rad-15]) cube(fan);
    translate([radiator.x, ext_rad+15, (pillar_ext.z-fan.z)+ext_rad-15-120-2]) cube(fan);
    translate([radiator.x, ext_rad+15, (pillar_ext.z-fan.z)+ext_rad-15-120*2-2*2]) cube(fan);
}



//translate([horizontal_ext.x-hdd.x-(ext_rad/2)+hdd_mnt+hdd_mnt-(ext_rad/2), ext_rad+small_ext.y, ext_rad]) color("white") cube(pillar_ext);
translate([horizontal_ext.x-psu_dimm.x, ext_rad+small_ext.y, ext_rad]) color("white") cube(pillar_ext);
translate([horizontal_ext.x-psu_dimm.x, 0, ext_rad]) color("white") cube(pillar_ext);


translate([horizontal_ext.x-psu_dimm.x, ext_rad, pillar_ext.z+ext_rad]) color("sienna") cube(small_ext);

translate([horizontal_ext.x-psu_dimm.x, ext_rad, pillar_ext.z-psu_dimm.z]) color("sienna") cube(small_ext);





//translate([ext_rad, 0, (pillar_ext.z-psu_dimm.z)]) color("red") cube(horizontal_ext);


translate([horizontal_ext.x-ext_rad, ext_rad, (pillar_ext.z-psu_dimm.z)]) color("sienna") cube(small_ext);


// imaginary watercooling reservoir

color("MediumSpringGreen", 0.5) translate([radiator.x+fan.x+40, 95, 400]) cylinder(h=100, r=25);


//psu
translate([horizontal_ext.x-psu_dimm.x, ext_rad, pillar_ext.z-psu_dimm.z+ext_rad]) {
    color("purple", 0.5) cube(psu_dimm);
}


translate([0, ext_rad, ext_rad+hdd.z+10]) {
    color("NavajoWhite", 0.5) cube(mnt_board_dimm);
}

io_pannel_offset = 2.2; // mm amount that the io ports from the mobo extrude off to the left of the mobo. the io plate will go into the acrylic/plywood mounted on the left exterior, that sheet should be boarddep thick. the plat aligns that the io will meet right on the exterior surface of the sheet

// this won't work since io_pannel_offset is smaller than boarddep. so I will provide an approximation that will work because this is just a visualization and sanity test
mobo_x_offset = 0.5;

//mobo
translate([horizontal_ext.x-mobo_dimm.x-mobo_x_offset, ext_rad+mnt_board_dimm.y, pillar_ext.z-psu_dimm.z-mobo_dimm.z-7]) {
    color("black", 0.5) {
        cube(mobo_dimm);
    }
}
