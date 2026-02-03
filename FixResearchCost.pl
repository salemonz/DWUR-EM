# input:	research-filename
# example:  research.txt
# output:	stdout
# function:	makes research costs linear, instead of exponential, so the game doesn't suck as it goes past about level 4..

sub ProcessFile
{
	my($sourcefile) = $_[0];
	open(SF, $sourcefile) or die "$!";

	# read in each line of the file
	while ($line = <SF>)
	{
		#'PROJECT line - list of comma-separated values as follows:
		#' - Project ID: unique numeric value identifying the project
		#' - Name: text of project name
		#' - Tech Level: how advanced the project is, which determines the default research cost of the project. This corresponds to the 'column' that this project is displayed at in the tech tree, tech level 0 is at far left, tech #level 7 is at far right. Each single additional tech level doubles the default research cost of the project.
		#' - Row: the vertical position of the project in the tech tree, starting at 1 (top)
		#' - Industry: 0=Weapons, 1=Energy, 2=HighTech
		#' - Category: 0=Armor, 1=AssaultPod, 2=Computer, 3=Construction, 4=EnergyCollector, 5=Engine, 6=Extractor, 7=Fighter, 8=Habitation, 9=HyperDisrupt, 10=HyperDrive, 11=Labs, 12=Manufacturer, 13=Reactor, 14=Sensor, 15=ShieldRecharge, 16=Shields, 17=Storage, 18=WeaponArea, 19=WeaponBeam, 20=WeaponGravity, 21=WeaponIon, 22=WeaponPointDefense, 23=WeaponSuperArea, 24=WeaponSuperBeam, 25=WeaponTorpedo
		#' - Special Function Code: 0=NONE, 1=PreWarp tech that is already researched when starting game as PreWarp empire, 2=primitive hyperdrive tech (warp bubble) that must be unlocked before can be researched, 3=superweapon, 4=initial colonization tech, 5=starts game locked (must be unlocked by game event before can be researched)
		#' - Base Cost Multiplier Override: multiplier factor for modifying the default research cost of the project. Project cost is related to Tech Level - each single additional tech level doubles the default research cost of the project. Base Cost Multiplier Override can be used to make projects more or less expensive than normal.
		# ex: PROJECT			;0, Wave Weapons, 2, 1, 		0, 19, 0, 0.0, 
		if ($line =~ /^(PROJECT[ \t]+;)([0-9]+)(,[ \t]+)([^,]+)(,[ \t]+)([0-9]+)(,[ \t]+)([0-9]+)(,[ \t]+)([0-9]+)(,[ \t]+)([0-9]+)(,[ \t]+)([0-9]+)(,[ \t]+)([0-9.]+)(.*)$/)
		{
			#$line = sprintf("Project: $4, ID: $2, level: $6, row: $8, tech: $10, category: $12, spec-fun: $14, cost: %0.2f\n", $cost);
			
			$id = $2;
			$name = $4;
			$col = $6;
			$row = $8 + 0;
			$tech = $10;
			$category = $12;
			$spec = $14;
			$cost = $16 + 0.0;
		
			# adjust cost
			#if ($col > 3)
			#{
			#	$cost = 3*($col-2);
			#	$line = sprintf("$1$2$3$4$5$6$7$8$9$10$11$12$13$14$15%0.1f$17\n", $cost);
			#}
			
			if ($col > 1)
			{
				$cost = $col**1.5;
				$line = sprintf("$1$2$3$4$5$6$7$8$9$10$11$12$13$14$15%0.1f$17\n", $cost);
			}
		}
		# copy this line to output
		print $line;
	}

	close(SF);
}

ProcessFile($ARGV[0], $ARGV[1], $ARGV[2], $ARGV[3], $ARGV[4]);
