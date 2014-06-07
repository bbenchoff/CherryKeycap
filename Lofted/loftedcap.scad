use <models.scad>;

// dimensions Cherry MX connector
c_corr = .4;                // tolerance
c_horiz = 1.1;              // horizontal bar width
c_vert = 1.0;               // vertical bar width
c_dia = 4;                  // cross width
c_depth = 7;                // connector depth
c_space = 4;                // height of hollow inside
c_inset = .25;              // distance connector start to keycap base

cutoff = 6.5;               // cut keycap here to make room for decoration
                            // must be bigger than c_space + c_corr
key_scale = [1.02,1.02,1.02]; // overall scale


// stuff
$fn = 64;

module key()
{
	difference()
	{
		difference()
		{
			intersection()
			{
				translate([-13.75,-13.75,0])scale([25.5,25.5,35])import("LoftedCap.stl");
				translate([0,0,-30])sphere(r=40, $fn=300);
			}
			difference()
			{
				translate([0,1,0])scale([.2,.2,.2])linear_extrude(height=50)face();
				translate([0,0,-30.4])sphere(r=40, $fn=300);
			}
		}
	   hull()
	   {
	        scale([0.95,0.95,0.95])translate([0,0,0]) linear_extrude(height=1) import("base.dxf");
	        scale([1.1,1.1,1.1])translate([0,7]) linear_extrude(height=6.5) import("top.dxf");
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

// combine key, pin and connector. cleanup below the key
scale(key_scale) difference()
{
    union() 
    { 
        translate([0,0,-2])key();
        cylinder( h=7., r=(c_dia+1+c_corr)/2 );
    }
    
	connector();
	translate([0,0,-50-c_inset]) cube([100,100,100], center=true);
}