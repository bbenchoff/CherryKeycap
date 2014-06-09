// Row 4 decorated Cherry MX key
use <models.scad>;
// dimensions Cherry MX connector
c_corr = .4;                // tolerance
c_horiz = 1.1;              // horizontal bar width
c_vert = 1.0;               // vertical bar width
c_dia = 4;                  // cross width
c_depth = 6;                // connector depth
c_space = 4;                // height of hollow inside
c_inset = .75;              // distance connector start to keycap base

// decoration
obj_pos = [0,0.3,-.7];        // decoration offset
obj_scale = [1.01,1.03,1.03]; // decoration scale
obj_rot = [0,0,0];          // decoration rotation

// keycap shape
head_tilt = 1;              // rotation of top around x-axis
head_pos = 2.25;            // keycap top y-offset
head_height = 8;           // z-offset of keycap top from the bottom of the keycap
cutoff = 9;               // cut keycap here to make room for decoration
                            // must be bigger than c_space + c_corr
key_scale = [1.02,1.02,1.02]; // overall scale

//stuff
$fn = 300 ;


//Modules
module DrawBottomwrench()
{
	translate([5,-4.5,4])rotate([-40,0,-130])scale([.1,.1,.1])linear_extrude(height=50) Topwrench();
}

module DrawTopwrench()
{
	translate([5.5,5,4])rotate([-55,0,-45])scale([.1,.1,.1])linear_extrude(height=50) Topwrench();
}

module Drawwrenches()
{
	DrawBottomwrench();
	mirror([1,0,0])
	{
		DrawBottomwrench();
	}
	
	
	DrawTopwrench();
	mirror([1,0,0])
	{
		DrawTopwrench();
	}
}

module shape()
{
	 hull()
    {
        translate([0,0,-c_inset]) linear_extrude(height=1) import("base.dxf");
        rotate([head_tilt,0,0]) translate([0,5+head_pos,head_height-c_inset]) linear_extrude(height=.2) import("top.dxf");
    }
}

//Start of actual stuff

//make the skullspider
module skullspider()
{
	difference()
	{
		union()
		{
			intersection()
			{
				translate([0,-0.5,2])scale([.17,.17,.5])linear_extrude(height=21) skull();
				translate([0,0,0.3]) sphere(r=11);
			}
			
			intersection()
			{
				Drawwrenches();
				sphere(r=11);
			}
		}
		difference()
		{
			translate([0,0,9])scale([.17,.17,1])linear_extrude(height = 20)face();
			sphere(r=11);
		}
	}
}

// construct the connector pin
module connector() 
{
    translate([0,0,c_depth/2-.1]) union()
    {
        cube([c_vert+c_corr,c_dia+c_corr,c_depth+.1], center=true );
        cube([c_dia+c_corr,c_horiz+c_corr,c_depth+.1], center=true );
    }
}

// create the hollow key with decoration
module key()
{
    difference()
    {
        // combine basic key shape with decoration
        union()
        {
            translate(obj_pos) rotate(obj_rot) scale(obj_scale) skullspider();
            
            //difference()
            {
                shape();
                //rotate([head_tilt,0,0]) translate([0,0,5+cutoff-c_inset]) cube([10,100,10], center=true);
            }
        }

        // subtract scaled basic shape, cut at minimum required height
        difference()
        {
            scale([.9,.9,.9]) translate([0,0,-1]) shape();
            translate([0,0,5+c_space+c_corr]) cube([100,100,10], center=true);
        }
    }
}

// combine key, pin and connector. cleanup below the key
scale(key_scale) difference()
{
    union() 
    { 
        key();
        cylinder( h=c_space+c_corr, r=(c_dia+1+c_corr)/2 );
    }
    
	connector();
	translate([0,0,-50-c_inset]) cube([100,100,100], center=true);
}



