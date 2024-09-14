return {
	-- 0	vehicle has no storage
	-- 1	vehicle has no trunk storage
	-- 2	vehicle has no glovebox storage
	-- 3	vehicle has trunk in the hood
	Storage = {
		[`jester`] = 3,
		[`adder`] = 3,
		[`osiris`] = 1,
		[`pfister811`] = 1,
		[`penetrator`] = 1,
		[`autarch`] = 1,
		[`bullet`] = 1,
		[`cheetah`] = 1,
		[`cyclone`] = 1,
		[`voltic`] = 1,
		[`reaper`] = 3,
		[`entityxf`] = 1,
		[`t20`] = 1,
		[`taipan`] = 1,
		[`tezeract`] = 1,
		[`torero`] = 3,
		[`turismor`] = 1,
		[`fmj`] = 1,
		[`infernus`] = 1,
		[`italigtb`] = 3,
		[`italigtb2`] = 3,
		[`nero2`] = 1,
		[`vacca`] = 3,
		[`vagner`] = 1,
		[`visione`] = 1,
		[`prototipo`] = 1,
		[`zentorno`] = 1,
		[`trophytruck`] = 0,
		[`trophytruck2`] = 0,
	},

	-- slots, maxWeight; default weight is 8000 per slot
	glovebox = {
		[0]    = { 10, 5000 }, -- Compact
		[1]    = { 10, 5000 }, -- Sedan
		[2]    = { 10, 5000 }, -- SUV
		[3]    = { 10, 5000 }, -- Coupe
		[4]    = { 10, 5000 }, -- Muscle
		[5]    = { 10, 5000 }, -- Sports Classic
		[6]    = { 10, 5000 }, -- Sports
		[7]    = { 10, 5000 }, -- Super
		[8]    = { 5, 2000 }, -- Motorcycle
		[9]    = { 10, 5000 }, -- Offroad
		[10]   = { 10, 5000 }, -- Industrial
		[11]   = { 10, 5000 }, -- Utility
		[12]   = { 10, 5000 }, -- Van
		[14]   = { 10, 5000 }, -- Boat
		[15]   = { 10, 5000 }, -- Helicopter
		[16]   = { 10, 5000 }, -- Plane
		[17]   = { 10, 5000 }, -- Service
		[18]   = { 10, 5000 }, -- Emergency
		[19]   = { 10, 5000 }, -- Military
		[20]   = { 10, 5000 }, -- Commercial (trucks)
		models = {
			--[`xa21`] = {11, 88000}
		}
	},

	trunk = {
		[0] = { 21, 60000 }, -- Compact
		[1] = { 20, 40000 }, -- Sedan
		[2] = { 50, 70000 }, -- SUV
		[3] = { 15, 60000 }, -- Coupe
		[4] = { 15, 60000 }, -- Muscle
		[5] = { 15, 60000 }, -- Sports Classic
		[6] = { 15, 60000 }, -- Sports
		[7] = { 5, 10000 }, -- Super
		[8] = { 5, 10000 }, -- Motorcycle
		[9] = { 50, 90000 }, -- Offroad
		[10] = { 50, 60000 }, -- Industrial
		[11] = { 50, 60000 }, -- Utility
		[12] = { 50, 200000 }, -- Van
		-- [14] -- Boat
		-- [15] -- Helicopter
		-- [16] -- Plane
		[17] = { 30, 30000 }, -- Service
		[18] = { 10, 30000 }, -- Emergency
		[19] = { 10, 30000 }, -- Military
		[20] = { 30, 30000 }, -- Commercial
		models = {
			[`mule3`] = { 70, 500000 },
			[`nspeedo`] = { 50, 250000 }
		},
	}
}
