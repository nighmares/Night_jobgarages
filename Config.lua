Config = {}

Config.notitype = 'mythic' --- 'esx' if you dont use mythic!

--- npc stuff
Config.Distancia = 10.0

Config.main = {

    {
        modelo = "cs_prolsec_02",
        coords = vector3(1869.29, 3686.78, 33.78),  ---- sheriff
        heading = 160.03,
        gender = "male"
    },
    {
        modelo = "s_f_y_scrubs_01",
        coords = vector3(294.65, -600.49, 43.3),  ---- ambulance
        heading = 157.14,
        gender = "male"
    },


}

Config.societymoney = true


Config.policejob = 'police' -- your policejob name drom db
Config.event = 'Night:policegarage' --- change it to 'Night:policegaragemoney' if you want the cars to take money!


--garage ambulance
Config.ambulancejob = 'ambulance'
Config.event2 = 'Night:ambulance'

Config.garages = {

    {
        job = 'police',
        grade = 'sergeant',
        society = 'police',
        money = 100,
        plate = 'police1',
        models = {
            {label = "police1", model = "police"},
        },
        coords = vector3(1867.08,3679.41,33.58),
        heading = 218.27

    },

    {
        job = 'police',
        grade = 'sergeant',
        society = 'police',
        plate = 'police2',
        money = 100,
        models = {
            {label = "police2", model = "t20"},
        },
        coords = vector3(1861.67,3677.89,33.64),
        heading = 216.31

    },

    {
        job = 'police',
        grade = 'boss',
        society = 'police',
        plate = 'police3',
        money = 100,
        models = {
            {label = "police1", model = "t20"},
        },
        coords = vector3(1867.08,3679.41,33.58),
        heading = 218.27

    },

    {
        job = 'police',
        grade = 'boss',
        society = 'police',
        plate = "BURGER",
        money = 100,
        models = {
            {label = "police2", model = "police"},
        },
        coords = vector3(1861.67,3677.89,33.64),
        heading = 218.27

    },

    {
        job = 'ambulance',
        grade = 'nurse',
        society = 'ambulance',
        plate = 'police',
        money = 100,
        models = {
            {label = "police2", model = "police"},
        },
        coords = vector3(297.47,-608.41,43.27),
        heading = 64.27

    },

    {
        job = 'ambulance',
        grade = 'nurse',
        society = 'ambulance',
        plate = 'wait2!',
        money = 100,
        models = {
            {label = "ambulance", model = "ambulance"},
        },
        coords = vector3(297.47,-608.41,43.27),
        heading = 64.27

    },

    {
        job = 'ambulance',
        grade = 'boss',
        society = 'ambulance',
        plate = 'wait2!',
        money = 100,
        models = {
            {label = "ambulance", model = "ambulance"},
        },
        coords = vector3(297.47,-608.41,43.27),
        heading = 64.27

    },

    {
        job = 'ambulance',
        grade = 'boss',
        society = 'ambulance',
        plate = 'police',
        money = 100,
        models = {
            {label = "police2", model = "police"},
        },
        coords = vector3(297.47,-608.41,43.27),
        heading = 64.27

    },

    


}