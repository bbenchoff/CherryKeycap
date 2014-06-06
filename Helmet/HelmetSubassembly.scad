use <models.scad>;

union()
{
	intersection()
	{
		linear_extrude(height = 50, center = false) helmet();
	
		translate([0,0,-190]) sphere(r=240, $fn = 300);
	}
	intersection()
	{
		intersection()
		{	
			intersection()
			{
				 linear_extrude(height = 47, center = false) vent();
			
				 translate([-25,-64,36]) rotate([0,90,0]) cylinder(h=50, d=18, $fn=100);
			}
	
			translate([0,-55,-15.3]) rotate([90,0,0]) cylinder(h=20, d=120, $fn=300);
		}
		translate([0,0,-189.5]) sphere(r=240, $fn = 300);
	}	
	intersection()
	{
		linear_extrude(height = 50, center = false) helmetBase();
		translate([0,0,-192]) sphere(r=240, $fn = 300);
	}
	
	union()
	{
		difference()
		{
		
			intersection()
			{
				translate([0,0,5])linear_extrude(height = 50, center = false) skull();
				translate([0,0,-65]) sphere(r=120, $fn = 300);
			}
			
			difference()
			{		
				translate([0,0,44]) linear_extrude(height = 15, center = false) face();
				translate([0,0,-67]) sphere(r=120, $fn = 300);
			}

		}
	}
}

	