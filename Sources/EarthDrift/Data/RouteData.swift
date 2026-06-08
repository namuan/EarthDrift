import Foundation
import CoreLocation

enum RouteData {
    static let nile = Route(
        title: "Nile River",
        subtitle: "The longest river on Earth",
        category: .rivers,
        coordinates: [
            .init(latitude: -2.0, longitude: 33.0),
            .init(latitude: 0.05, longitude: 32.35),
            .init(latitude: 2.28, longitude: 32.00),
            .init(latitude: 9.75, longitude: 31.65),
            .init(latitude: 15.6, longitude: 32.5),
            .init(latitude: 17.7, longitude: 33.95),
            .init(latitude: 21.5, longitude: 33.0),
            .init(latitude: 24.1, longitude: 32.9),
            .init(latitude: 25.7, longitude: 32.65),
            .init(latitude: 27.2, longitude: 31.1),
            .init(latitude: 29.5, longitude: 31.2),
            .init(latitude: 31.0, longitude: 31.8),
            .init(latitude: 31.2, longitude: 30.0),
        ],
        duration: 1800,
        narrationPoints: [
            NarrationPoint(latitude: -0.0, longitude: 32.5, title: "Lake Victoria", subtitle: "The source of the White Nile."),
            NarrationPoint(latitude: 15.6, longitude: 32.5, title: "Khartoum", subtitle: "Where the Blue and White Nile meet."),
            NarrationPoint(latitude: 24.1, longitude: 32.9, title: "Aswan", subtitle: "Gateway to ancient Nubia."),
            NarrationPoint(latitude: 25.7, longitude: 32.65, title: "Luxor", subtitle: "The Valley of the Kings."),
            NarrationPoint(latitude: 29.5, longitude: 31.2, title: "Cairo", subtitle: "Where the Nile meets the delta."),
            NarrationPoint(latitude: 31.2, longitude: 30.0, title: "Alexandria", subtitle: "Where the river meets the Mediterranean."),
        ]
    )

    static let amazon = Route(
        title: "Amazon River",
        subtitle: "The pulse of South America",
        category: .rivers,
        coordinates: [
            .init(latitude: -10.5, longitude: -73.5),
            .init(latitude: -9.0, longitude: -74.0),
            .init(latitude: -7.0, longitude: -73.0),
            .init(latitude: -5.0, longitude: -72.0),
            .init(latitude: -3.7, longitude: -70.3),
            .init(latitude: -3.2, longitude: -60.0),
            .init(latitude: -3.0, longitude: -58.5),
            .init(latitude: -2.6, longitude: -56.5),
            .init(latitude: -2.4, longitude: -54.7),
            .init(latitude: -1.8, longitude: -52.3),
            .init(latitude: -0.5, longitude: -50.0),
            .init(latitude: 0.5, longitude: -49.5),
            .init(latitude: 1.0, longitude: -49.3),
        ],
        duration: 1800,
        narrationPoints: [
            NarrationPoint(latitude: -10.5, longitude: -73.5, title: "Andes Headwaters", subtitle: "Where the mighty Amazon begins."),
            NarrationPoint(latitude: -5.0, longitude: -72.0, title: "Iquitos", subtitle: "The largest city unreachable by road."),
            NarrationPoint(latitude: -3.2, longitude: -60.0, title: "Manaus", subtitle: "Where the Rio Negro meets the Amazon."),
            NarrationPoint(latitude: -1.8, longitude: -52.3, title: "Amazon Basin", subtitle: "One of Earth's largest floodplains."),
            NarrationPoint(latitude: 0.1, longitude: -50.0, title: "Macapá", subtitle: "Where the Amazon meets the Atlantic."),
        ]
    )

    static let mississippi = Route(
        title: "Mississippi River",
        subtitle: "America's great waterway",
        category: .rivers,
        coordinates: [
            .init(latitude: 47.25, longitude: -95.2),
            .init(latitude: 45.0, longitude: -93.25),
            .init(latitude: 44.1, longitude: -92.5),
            .init(latitude: 42.5, longitude: -90.6),
            .init(latitude: 41.5, longitude: -90.5),
            .init(latitude: 39.1, longitude: -90.7),
            .init(latitude: 37.3, longitude: -89.5),
            .init(latitude: 36.1, longitude: -89.4),
            .init(latitude: 34.3, longitude: -90.9),
            .init(latitude: 33.0, longitude: -91.15),
            .init(latitude: 31.5, longitude: -91.4),
            .init(latitude: 30.0, longitude: -90.7),
            .init(latitude: 29.1, longitude: -89.3),
        ],
        duration: 1600,
        narrationPoints: [
            NarrationPoint(latitude: 47.25, longitude: -95.2, title: "Lake Itasca", subtitle: "The headwaters of the Mississippi."),
            NarrationPoint(latitude: 44.95, longitude: -93.25, title: "Minneapolis", subtitle: "Twin Cities on the river."),
            NarrationPoint(latitude: 39.1, longitude: -90.7, title: "St. Louis", subtitle: "Gateway to the West."),
            NarrationPoint(latitude: 34.3, longitude: -90.9, title: "Mississippi Delta", subtitle: "The fertile floodplain."),
            NarrationPoint(latitude: 30.0, longitude: -90.7, title: "New Orleans", subtitle: "The Crescent City."),
            NarrationPoint(latitude: 29.1, longitude: -89.3, title: "Gulf of Mexico", subtitle: "Where the great river ends."),
        ]
    )

    static let transSiberian = Route(
        title: "Trans-Siberian Railway",
        subtitle: "The world's longest train journey",
        category: .railways,
        coordinates: [
            .init(latitude: 55.75, longitude: 37.62),
            .init(latitude: 56.33, longitude: 44.0),
            .init(latitude: 58.0, longitude: 56.25),
            .init(latitude: 56.85, longitude: 60.6),
            .init(latitude: 55.0, longitude: 73.4),
            .init(latitude: 55.0, longitude: 82.9),
            .init(latitude: 52.3, longitude: 104.3),
            .init(latitude: 51.8, longitude: 107.6),
            .init(latitude: 48.5, longitude: 135.0),
            .init(latitude: 43.13, longitude: 131.9),
        ],
        duration: 3600,
        narrationPoints: [
            NarrationPoint(latitude: 55.75, longitude: 37.62, title: "Moscow", subtitle: "Departure from Yaroslavsky Station."),
            NarrationPoint(latitude: 56.33, longitude: 44.0, title: "Nizhny Novgorod", subtitle: "Crossing the Volga River."),
            NarrationPoint(latitude: 58.0, longitude: 56.25, title: "Perm", subtitle: "Gateway to Siberia."),
            NarrationPoint(latitude: 56.85, longitude: 60.6, title: "Yekaterinburg", subtitle: "The Ural Mountains divide Europe and Asia."),
            NarrationPoint(latitude: 55.0, longitude: 82.9, title: "Novosibirsk", subtitle: "Siberia's largest city."),
            NarrationPoint(latitude: 52.3, longitude: 104.3, title: "Irkutsk", subtitle: "Near the shores of Lake Baikal."),
            NarrationPoint(latitude: 51.8, longitude: 107.6, title: "Ulan-Ude", subtitle: "Buddhist heart of Russia."),
            NarrationPoint(latitude: 48.5, longitude: 135.0, title: "Khabarovsk", subtitle: "Along the Amur River."),
            NarrationPoint(latitude: 43.13, longitude: 131.9, title: "Vladivostok", subtitle: "The Pacific terminus."),
        ]
    )

    static let californiaZephyr = Route(
        title: "California Zephyr",
        subtitle: "Across the American West",
        category: .railways,
        coordinates: [
            .init(latitude: 41.88, longitude: -87.63),
            .init(latitude: 41.5, longitude: -90.5),
            .init(latitude: 41.25, longitude: -95.9),
            .init(latitude: 40.8, longitude: -99.65),
            .init(latitude: 39.75, longitude: -104.99),
            .init(latitude: 39.65, longitude: -107.0),
            .init(latitude: 39.3, longitude: -110.8),
            .init(latitude: 40.75, longitude: -111.9),
            .init(latitude: 39.5, longitude: -119.8),
            .init(latitude: 38.5, longitude: -121.5),
            .init(latitude: 37.78, longitude: -122.4),
        ],
        duration: 2400,
        narrationPoints: [
            NarrationPoint(latitude: 41.88, longitude: -87.63, title: "Chicago", subtitle: "Departure from Union Station."),
            NarrationPoint(latitude: 41.25, longitude: -95.9, title: "Omaha", subtitle: "The plains of Nebraska stretch endlessly."),
            NarrationPoint(latitude: 39.75, longitude: -104.99, title: "Denver", subtitle: "The Mile High City."),
            NarrationPoint(latitude: 39.65, longitude: -107.0, title: "Glenwood Canyon", subtitle: "Through the Colorado Rockies."),
            NarrationPoint(latitude: 40.75, longitude: -111.9, title: "Salt Lake City", subtitle: "Crossing the Great Basin."),
            NarrationPoint(latitude: 39.5, longitude: -119.8, title: "Reno", subtitle: "The Biggest Little City."),
            NarrationPoint(latitude: 38.5, longitude: -121.5, title: "Sacramento", subtitle: "California's capital."),
            NarrationPoint(latitude: 37.78, longitude: -122.4, title: "San Francisco", subtitle: "Journey's end by the Bay."),
        ]
    )

    static let orientExpress = Route(
        title: "Orient Express",
        subtitle: "Paris to Istanbul in grand style",
        category: .railways,
        coordinates: [
            .init(latitude: 48.86, longitude: 2.35),
            .init(latitude: 48.58, longitude: 7.75),
            .init(latitude: 48.14, longitude: 11.58),
            .init(latitude: 48.21, longitude: 16.37),
            .init(latitude: 47.50, longitude: 19.04),
            .init(latitude: 44.43, longitude: 26.10),
            .init(latitude: 42.70, longitude: 23.32),
            .init(latitude: 41.01, longitude: 28.98),
        ],
        duration: 2400,
        narrationPoints: [
            NarrationPoint(latitude: 48.86, longitude: 2.35, title: "Paris", subtitle: "Departure from the City of Light."),
            NarrationPoint(latitude: 48.58, longitude: 7.75, title: "Strasbourg", subtitle: "Crossing into the Rhine Valley."),
            NarrationPoint(latitude: 48.14, longitude: 11.58, title: "Munich", subtitle: "Bavarian capital, gateway to the Alps."),
            NarrationPoint(latitude: 48.21, longitude: 16.37, title: "Vienna", subtitle: "The imperial city on the Danube."),
            NarrationPoint(latitude: 47.50, longitude: 19.04, title: "Budapest", subtitle: "The Pearl of the Danube."),
            NarrationPoint(latitude: 44.43, longitude: 26.10, title: "Bucharest", subtitle: "The Little Paris of the East."),
            NarrationPoint(latitude: 41.01, longitude: 28.98, title: "Istanbul", subtitle: "Where two continents embrace."),
        ]
    )

    static let theGhan = Route(
        title: "The Ghan",
        subtitle: "Across the Australian outback",
        category: .railways,
        coordinates: [
            .init(latitude: -34.93, longitude: 138.60),
            .init(latitude: -32.49, longitude: 137.77),
            .init(latitude: -29.01, longitude: 134.75),
            .init(latitude: -23.70, longitude: 133.88),
            .init(latitude: -19.65, longitude: 134.19),
            .init(latitude: -14.47, longitude: 132.26),
            .init(latitude: -12.46, longitude: 130.84),
        ],
        duration: 2400,
        narrationPoints: [
            NarrationPoint(latitude: -34.93, longitude: 138.60, title: "Adelaide", subtitle: "Departure from the south coast."),
            NarrationPoint(latitude: -32.49, longitude: 137.77, title: "Port Augusta", subtitle: "Where the outback begins."),
            NarrationPoint(latitude: -29.01, longitude: 134.75, title: "Coober Pedy", subtitle: "The opal capital, a town underground."),
            NarrationPoint(latitude: -23.70, longitude: 133.88, title: "Alice Springs", subtitle: "The Red Centre of Australia."),
            NarrationPoint(latitude: -14.47, longitude: 132.26, title: "Katherine", subtitle: "Gateway to Nitmiluk Gorge."),
            NarrationPoint(latitude: -12.46, longitude: 130.84, title: "Darwin", subtitle: "Journey's end on the Timor Sea."),
        ]
    )

    static let darjeelingHimalayan = Route(
        title: "Darjeeling Himalayan Railway",
        subtitle: "The toy train to the clouds",
        category: .railways,
        coordinates: [
            .init(latitude: 26.68, longitude: 88.44),
            .init(latitude: 26.72, longitude: 88.42),
            .init(latitude: 26.88, longitude: 88.28),
            .init(latitude: 27.01, longitude: 88.25),
            .init(latitude: 27.04, longitude: 88.26),
        ],
        duration: 900,
        narrationPoints: [
            NarrationPoint(latitude: 26.68, longitude: 88.44, title: "New Jalpaiguri", subtitle: "The plains of West Bengal."),
            NarrationPoint(latitude: 26.72, longitude: 88.42, title: "Siliguri", subtitle: "Where the climb begins."),
            NarrationPoint(latitude: 26.88, longitude: 88.28, title: "Kurseong", subtitle: "Tea gardens blanket the hillsides."),
            NarrationPoint(latitude: 27.01, longitude: 88.25, title: "Ghum", subtitle: "India's highest railway station."),
            NarrationPoint(latitude: 27.04, longitude: 88.26, title: "Darjeeling", subtitle: "The Queen of the Hills, with Kanchenjunga rising beyond."),
        ]
    )

    static let tokyoLA = Route(
        title: "Tokyo → Los Angeles",
        subtitle: "Across the Pacific",
        category: .flights,
        coordinates: [
            .init(latitude: 35.68, longitude: 139.76),
            .init(latitude: 37.0, longitude: 142.0),
            .init(latitude: 40.0, longitude: 150.0),
            .init(latitude: 42.0, longitude: 160.0),
            .init(latitude: 43.0, longitude: 170.0),
            .init(latitude: 43.5, longitude: -180.0),
            .init(latitude: 43.0, longitude: -170.0),
            .init(latitude: 42.0, longitude: -160.0),
            .init(latitude: 40.0, longitude: -140.0),
            .init(latitude: 38.0, longitude: -130.0),
            .init(latitude: 37.0, longitude: -125.0),
            .init(latitude: 36.0, longitude: -122.0),
            .init(latitude: 34.0, longitude: -119.0),
            .init(latitude: 33.95, longitude: -118.4),
        ],
        duration: 1800,
        narrationPoints: [
            NarrationPoint(latitude: 35.68, longitude: 139.76, title: "Tokyo", subtitle: "Departure from Narita."),
            NarrationPoint(latitude: 42.0, longitude: 160.0, title: "Pacific Ocean", subtitle: "The vast expanse of blue."),
            NarrationPoint(latitude: 43.5, longitude: -180.0, title: "International Date Line", subtitle: "Crossing into yesterday."),
            NarrationPoint(latitude: 40.0, longitude: -140.0, title: "Mid-Pacific", subtitle: "Thousands of miles from land."),
            NarrationPoint(latitude: 37.0, longitude: -125.0, title: "California Coast", subtitle: "Landfall over the Golden State."),
            NarrationPoint(latitude: 33.95, longitude: -118.4, title: "Los Angeles", subtitle: "Arrival at LAX."),
        ],
        altitude: 15000
    )

    static let danube = Route(
        title: "Danube River",
        subtitle: "Europe's storied waterway",
        category: .rivers,
        coordinates: [
            .init(latitude: 48.1, longitude: 8.15),
            .init(latitude: 48.3, longitude: 10.0),
            .init(latitude: 48.57, longitude: 13.46),
            .init(latitude: 48.2, longitude: 16.37),
            .init(latitude: 47.8, longitude: 17.6),
            .init(latitude: 47.5, longitude: 19.04),
            .init(latitude: 45.25, longitude: 19.85),
            .init(latitude: 44.8, longitude: 20.45),
            .init(latitude: 44.0, longitude: 22.5),
            .init(latitude: 43.8, longitude: 23.5),
            .init(latitude: 44.15, longitude: 27.6),
            .init(latitude: 45.2, longitude: 29.65),
        ],
        duration: 1600,
        narrationPoints: [
            NarrationPoint(latitude: 48.1, longitude: 8.15, title: "Black Forest", subtitle: "Where the Danube springs to life."),
            NarrationPoint(latitude: 48.2, longitude: 16.37, title: "Vienna", subtitle: "The imperial city on the Danube."),
            NarrationPoint(latitude: 47.8, longitude: 17.6, title: "Bratislava", subtitle: "Slovakia's riverside capital."),
            NarrationPoint(latitude: 47.5, longitude: 19.04, title: "Budapest", subtitle: "The Pearl of the Danube."),
            NarrationPoint(latitude: 44.8, longitude: 20.45, title: "Belgrade", subtitle: "Where the Sava meets the Danube."),
            NarrationPoint(latitude: 44.0, longitude: 22.5, title: "Iron Gates", subtitle: "A spectacular gorge through the Carpathians."),
            NarrationPoint(latitude: 45.2, longitude: 29.65, title: "Danube Delta", subtitle: "Europe's largest wetland."),
        ]
    )

    static let silkRoad = Route(
        title: "Silk Road",
        subtitle: "The ancient trade route",
        category: .ancient,
        coordinates: [
            .init(latitude: 39.9, longitude: 116.4),
            .init(latitude: 39.5, longitude: 113.0),
            .init(latitude: 38.0, longitude: 105.0),
            .init(latitude: 37.1, longitude: 97.0),
            .init(latitude: 39.0, longitude: 88.0),
            .init(latitude: 42.87, longitude: 74.6),
            .init(latitude: 41.3, longitude: 69.24),
            .init(latitude: 39.65, longitude: 66.95),
            .init(latitude: 37.0, longitude: 60.0),
            .init(latitude: 35.7, longitude: 51.42),
            .init(latitude: 38.0, longitude: 46.3),
            .init(latitude: 39.93, longitude: 32.85),
            .init(latitude: 41.0, longitude: 28.95),
        ],
        duration: 3600,
        narrationPoints: [
            NarrationPoint(latitude: 39.9, longitude: 116.4, title: "Beijing", subtitle: "Beginning of the Silk Road."),
            NarrationPoint(latitude: 37.1, longitude: 97.0, title: "Gobi Desert", subtitle: "Caravans braved the harsh sands."),
            NarrationPoint(latitude: 42.87, longitude: 74.6, title: "Bishkek", subtitle: "Crossroads of Central Asia."),
            NarrationPoint(latitude: 41.3, longitude: 69.24, title: "Tashkent", subtitle: "A great oasis city."),
            NarrationPoint(latitude: 39.65, longitude: 66.95, title: "Samarkand", subtitle: "The jewel of the Silk Road."),
            NarrationPoint(latitude: 37.0, longitude: 60.0, title: "Merv", subtitle: "Legendary city of the Turkmen desert."),
            NarrationPoint(latitude: 35.7, longitude: 51.42, title: "Tehran", subtitle: "Persian crossroads."),
            NarrationPoint(latitude: 39.93, longitude: 32.85, title: "Ankara", subtitle: "Where East meets West."),
            NarrationPoint(latitude: 41.0, longitude: 28.95, title: "Istanbul", subtitle: "The final stop, bridging two continents."),
        ],
        altitude: 6000
    )

    static let pacificCoast = Route(
        title: "Pacific Coast Highway",
        subtitle: "California's coastal masterpiece",
        category: .coastlines,
        coordinates: [
            .init(latitude: 37.8, longitude: -122.5),
            .init(latitude: 37.5, longitude: -122.4),
            .init(latitude: 37.1, longitude: -122.3),
            .init(latitude: 36.95, longitude: -122.0),
            .init(latitude: 36.6, longitude: -121.9),
            .init(latitude: 36.3, longitude: -121.8),
            .init(latitude: 35.6, longitude: -121.1),
            .init(latitude: 35.35, longitude: -120.8),
            .init(latitude: 34.55, longitude: -120.4),
            .init(latitude: 34.4, longitude: -119.7),
            .init(latitude: 34.05, longitude: -118.9),
            .init(latitude: 33.97, longitude: -118.45),
        ],
        duration: 1800,
        narrationPoints: [
            NarrationPoint(latitude: 37.8, longitude: -122.5, title: "San Francisco", subtitle: "Starting at the Golden Gate."),
            NarrationPoint(latitude: 36.6, longitude: -121.9, title: "Monterey Bay", subtitle: "Marine sanctuary by the shore."),
            NarrationPoint(latitude: 35.6, longitude: -121.1, title: "Big Sur", subtitle: "Where mountains plunge into the Pacific."),
            NarrationPoint(latitude: 34.4, longitude: -119.7, title: "Santa Barbara", subtitle: "The American Riviera."),
            NarrationPoint(latitude: 34.05, longitude: -118.9, title: "Malibu", subtitle: "Sun, surf, and sandstone cliffs."),
        ],
        altitude: 3500
    )

    static let londonSingapore = Route(
        title: "London → Singapore",
        subtitle: "The Kangaroo Route",
        category: .flights,
        coordinates: [
            .init(latitude: 51.47, longitude: -0.45),
            .init(latitude: 50.5, longitude: 2.5),
            .init(latitude: 48.5, longitude: 8.0),
            .init(latitude: 46.0, longitude: 15.0),
            .init(latitude: 42.0, longitude: 25.0),
            .init(latitude: 38.0, longitude: 35.0),
            .init(latitude: 34.0, longitude: 45.0),
            .init(latitude: 30.0, longitude: 55.0),
            .init(latitude: 25.0, longitude: 65.0),
            .init(latitude: 20.0, longitude: 75.0),
            .init(latitude: 10.0, longitude: 85.0),
            .init(latitude: 5.0, longitude: 95.0),
            .init(latitude: 1.35, longitude: 103.8),
        ],
        duration: 1800,
        narrationPoints: [
            NarrationPoint(latitude: 51.47, longitude: -0.45, title: "London", subtitle: "Departure from Heathrow."),
            NarrationPoint(latitude: 48.5, longitude: 8.0, title: "Alps", subtitle: "Snow-capped peaks below."),
            NarrationPoint(latitude: 38.0, longitude: 35.0, title: "Anatolia", subtitle: "The ancient land bridge."),
            NarrationPoint(latitude: 30.0, longitude: 55.0, title: "Persian Gulf", subtitle: "Crossing the Arabian Peninsula."),
            NarrationPoint(latitude: 20.0, longitude: 75.0, title: "Indian Subcontinent", subtitle: "Over the Bay of Bengal."),
            NarrationPoint(latitude: 5.0, longitude: 95.0, title: "Strait of Malacca", subtitle: "One of the world's busiest shipping lanes."),
            NarrationPoint(latitude: 1.35, longitude: 103.8, title: "Singapore", subtitle: "Welcome to the Lion City."),
        ],
        altitude: 15000
    )

    static let newYorkLondon = Route(
        title: "New York → London",
        subtitle: "The quintessential transatlantic crossing",
        category: .flights,
        coordinates: [
            .init(latitude: 40.64, longitude: -73.78),
            .init(latitude: 42.0, longitude: -70.5),
            .init(latitude: 44.5, longitude: -63.5),
            .init(latitude: 47.5, longitude: -53.0),
            .init(latitude: 50.5, longitude: -40.0),
            .init(latitude: 52.5, longitude: -30.0),
            .init(latitude: 53.5, longitude: -20.0),
            .init(latitude: 53.0, longitude: -10.0),
            .init(latitude: 51.8, longitude: -5.0),
            .init(latitude: 51.47, longitude: -0.45),
        ],
        duration: 1800,
        narrationPoints: [
            NarrationPoint(latitude: 40.64, longitude: -73.78, title: "New York", subtitle: "Departure from JFK, Manhattan glitters below."),
            NarrationPoint(latitude: 47.5, longitude: -53.0, title: "Newfoundland", subtitle: "North America's easternmost edge."),
            NarrationPoint(latitude: 50.5, longitude: -40.0, title: "Mid-Atlantic", subtitle: "Nothing but ocean for a thousand miles."),
            NarrationPoint(latitude: 53.5, longitude: -20.0, title: "Irish Coast", subtitle: "The Emerald Isle emerges from the sea."),
            NarrationPoint(latitude: 51.47, longitude: -0.45, title: "London", subtitle: "Welcome to Heathrow."),
        ],
        altitude: 15000
    )

    static let sydneyAuckland = Route(
        title: "Sydney → Auckland",
        subtitle: "Across the Tasman Sea",
        category: .flights,
        coordinates: [
            .init(latitude: -33.87, longitude: 151.21),
            .init(latitude: -34.5, longitude: 152.5),
            .init(latitude: -35.5, longitude: 156.0),
            .init(latitude: -36.5, longitude: 161.0),
            .init(latitude: -37.0, longitude: 166.0),
            .init(latitude: -37.0, longitude: 171.0),
            .init(latitude: -36.8, longitude: 174.0),
            .init(latitude: -36.85, longitude: 174.76),
        ],
        duration: 1200,
        narrationPoints: [
            NarrationPoint(latitude: -33.87, longitude: 151.21, title: "Sydney", subtitle: "Departure over the Harbour Bridge."),
            NarrationPoint(latitude: -35.5, longitude: 156.0, title: "Tasman Sea", subtitle: "The deep waters between two nations."),
            NarrationPoint(latitude: -36.5, longitude: 161.0, title: "Lord Howe Rise", subtitle: "A submerged continent beneath the waves."),
            NarrationPoint(latitude: -37.0, longitude: 171.0, title: "North Island", subtitle: "New Zealand's green shores appear."),
            NarrationPoint(latitude: -36.85, longitude: 174.76, title: "Auckland", subtitle: "The City of Sails, nestled between two harbours."),
        ],
        altitude: 15000
    )

    static let losAngelesTokyo = Route(
        title: "Los Angeles → Tokyo",
        subtitle: "Chasing the sunrise across the Pacific",
        category: .flights,
        coordinates: [
            .init(latitude: 33.95, longitude: -118.4),
            .init(latitude: 34.5, longitude: -122.0),
            .init(latitude: 36.0, longitude: -128.0),
            .init(latitude: 38.0, longitude: -138.0),
            .init(latitude: 40.0, longitude: -150.0),
            .init(latitude: 42.0, longitude: -162.0),
            .init(latitude: 43.0, longitude: -174.0),
            .init(latitude: 43.5, longitude: -180.0),
            .init(latitude: 43.5, longitude: 180.0),
            .init(latitude: 42.0, longitude: 168.0),
            .init(latitude: 39.0, longitude: 153.0),
            .init(latitude: 36.5, longitude: 143.0),
            .init(latitude: 35.68, longitude: 139.76),
        ],
        duration: 1800,
        narrationPoints: [
            NarrationPoint(latitude: 33.95, longitude: -118.4, title: "Los Angeles", subtitle: "Departure from LAX, the City of Angels."),
            NarrationPoint(latitude: 38.0, longitude: -138.0, title: "Eastern Pacific", subtitle: "Endless blue stretching to every horizon."),
            NarrationPoint(latitude: 43.5, longitude: -180.0, title: "International Date Line", subtitle: "A day vanishes in an instant."),
            NarrationPoint(latitude: 39.0, longitude: 153.0, title: "Kuroshio Current", subtitle: "The warm black stream of the western Pacific."),
            NarrationPoint(latitude: 35.68, longitude: 139.76, title: "Tokyo", subtitle: "Arrival in the world's largest metropolis."),
        ],
        altitude: 15000
    )

    static let greekIslands = Route(
        title: "Greek Islands",
        subtitle: "Cyclades of the Aegean",
        category: .islandHopping,
        coordinates: [
            .init(latitude: 37.97, longitude: 23.73),
            .init(latitude: 37.45, longitude: 24.15),
            .init(latitude: 37.45, longitude: 25.35),
            .init(latitude: 36.42, longitude: 25.43),
            .init(latitude: 36.20, longitude: 26.80),
            .init(latitude: 36.15, longitude: 27.70),
            .init(latitude: 36.45, longitude: 28.20),
            .init(latitude: 36.90, longitude: 27.30),
            .init(latitude: 37.40, longitude: 25.35),
            .init(latitude: 37.50, longitude: 24.45),
            .init(latitude: 37.97, longitude: 23.73),
        ],
        duration: 1800,
        narrationPoints: [
            NarrationPoint(latitude: 37.97, longitude: 23.73, title: "Athens", subtitle: "Gateway to the Aegean."),
            NarrationPoint(latitude: 37.45, longitude: 25.35, title: "Mykonos", subtitle: "The iconic Cycladic island."),
            NarrationPoint(latitude: 36.42, longitude: 25.43, title: "Santorini", subtitle: "Caldera of a sleeping giant."),
            NarrationPoint(latitude: 36.20, longitude: 26.80, title: "Nisyros", subtitle: "Volcanic crater rising from the sea."),
            NarrationPoint(latitude: 36.45, longitude: 28.20, title: "Rhodes", subtitle: "Medieval fortress of the Knights."),
            NarrationPoint(latitude: 36.90, longitude: 27.30, title: "Kos", subtitle: "Where Hippocrates walked."),
        ]
    )

    static let hawaiianIslands = Route(
        title: "Hawaiian Islands",
        subtitle: "The Pacific emerald chain",
        category: .islandHopping,
        coordinates: [
            .init(latitude: 19.50, longitude: -154.95),
            .init(latitude: 19.60, longitude: -155.50),
            .init(latitude: 19.75, longitude: -155.95),
            .init(latitude: 19.60, longitude: -156.40),
            .init(latitude: 20.20, longitude: -156.40),
            .init(latitude: 20.45, longitude: -156.65),
            .init(latitude: 20.55, longitude: -156.60),
            .init(latitude: 20.75, longitude: -156.55),
            .init(latitude: 20.90, longitude: -156.70),
            .init(latitude: 21.00, longitude: -156.65),
            .init(latitude: 21.25, longitude: -157.10),
            .init(latitude: 21.30, longitude: -157.70),
            .init(latitude: 21.40, longitude: -158.05),
            .init(latitude: 21.46, longitude: -158.20),
        ],
        duration: 1800,
        narrationPoints: [
            NarrationPoint(latitude: 19.50, longitude: -154.95, title: "Big Island", subtitle: "Hawaiʻi — volcano country."),
            NarrationPoint(latitude: 20.20, longitude: -156.40, title: "Maui", subtitle: "The Valley Isle."),
            NarrationPoint(latitude: 20.75, longitude: -156.55, title: "Molokai", subtitle: "The Friendly Isle."),
            NarrationPoint(latitude: 21.00, longitude: -156.65, title: "Lanai", subtitle: "The Pineapple Isle."),
            NarrationPoint(latitude: 21.30, longitude: -157.70, title: "Oʻahu", subtitle: "The Gathering Place."),
            NarrationPoint(latitude: 22.05, longitude: -159.35, title: "Kauaʻi", subtitle: "The Garden Isle."),
        ]
    )

    static let indonesianArchipelago = Route(
        title: "Indonesian Archipelago",
        subtitle: "From Sumatra to Flores",
        category: .islandHopping,
        coordinates: [
            .init(latitude: -0.50, longitude: 101.50),
            .init(latitude: -2.00, longitude: 104.50),
            .init(latitude: -4.00, longitude: 105.50),
            .init(latitude: -5.50, longitude: 107.00),
            .init(latitude: -6.40, longitude: 108.50),
            .init(latitude: -7.00, longitude: 110.40),
            .init(latitude: -7.50, longitude: 112.00),
            .init(latitude: -8.20, longitude: 114.40),
            .init(latitude: -8.40, longitude: 115.60),
            .init(latitude: -8.10, longitude: 116.00),
            .init(latitude: -8.40, longitude: 117.00),
            .init(latitude: -8.50, longitude: 119.00),
            .init(latitude: -8.60, longitude: 120.50),
            .init(latitude: -8.90, longitude: 121.30),
        ],
        duration: 2400,
        narrationPoints: [
            NarrationPoint(latitude: -0.50, longitude: 101.50, title: "Sumatra", subtitle: "The wild west of Indonesia."),
            NarrationPoint(latitude: -6.40, longitude: 108.50, title: "Java", subtitle: "The cultural heartland."),
            NarrationPoint(latitude: -8.40, longitude: 115.60, title: "Bali", subtitle: "Island of the Gods."),
            NarrationPoint(latitude: -8.40, longitude: 117.00, title: "Komodo", subtitle: "Home of the dragons."),
            NarrationPoint(latitude: -8.60, longitude: 120.50, title: "Flores", subtitle: "Volcanoes and ancient mysteries."),
        ]
    )

    static let caribbeanChain = Route(
        title: "Caribbean Chain",
        subtitle: "Islands of the sun",
        category: .islandHopping,
        coordinates: [
            .init(latitude: 18.50, longitude: -66.00),
            .init(latitude: 18.40, longitude: -67.50),
            .init(latitude: 18.60, longitude: -69.00),
            .init(latitude: 18.90, longitude: -70.50),
            .init(latitude: 19.00, longitude: -71.40),
            .init(latitude: 18.50, longitude: -72.50),
            .init(latitude: 18.80, longitude: -74.50),
            .init(latitude: 19.50, longitude: -75.50),
            .init(latitude: 20.00, longitude: -77.00),
            .init(latitude: 20.50, longitude: -78.20),
            .init(latitude: 21.50, longitude: -79.00),
            .init(latitude: 22.50, longitude: -79.50),
            .init(latitude: 23.50, longitude: -80.00),
            .init(latitude: 23.80, longitude: -77.50),
            .init(latitude: 24.50, longitude: -78.00),
            .init(latitude: 25.00, longitude: -77.50),
            .init(latitude: 25.50, longitude: -77.00),
        ],
        duration: 2000,
        narrationPoints: [
            NarrationPoint(latitude: 18.50, longitude: -66.00, title: "Puerto Rico", subtitle: "La Isla del Encanto."),
            NarrationPoint(latitude: 18.90, longitude: -70.50, title: "Dominican Republic", subtitle: "The first European settlement in the Americas."),
            NarrationPoint(latitude: 18.50, longitude: -72.50, title: "Haiti", subtitle: "The mountain republic."),
            NarrationPoint(latitude: 20.00, longitude: -77.00, title: "Jamaica", subtitle: "Land of wood and water."),
            NarrationPoint(latitude: 22.50, longitude: -79.50, title: "Cuba", subtitle: "The Pearl of the Antilles."),
            NarrationPoint(latitude: 25.00, longitude: -77.50, title: "The Bahamas", subtitle: "Seven hundred islands of paradise."),
        ]
    )

    static let galapagos = Route(
        title: "Galápagos",
        subtitle: "Darwin's living laboratory",
        category: .islandHopping,
        coordinates: [
            .init(latitude: -0.75, longitude: -90.35),
            .init(latitude: -0.85, longitude: -89.60),
            .init(latitude: -0.50, longitude: -90.30),
            .init(latitude: -0.20, longitude: -90.45),
            .init(latitude: 0.00, longitude: -91.00),
            .init(latitude: -0.30, longitude: -91.50),
            .init(latitude: -0.80, longitude: -91.30),
            .init(latitude: -1.00, longitude: -90.80),
            .init(latitude: -1.30, longitude: -90.45),
            .init(latitude: -1.25, longitude: -89.70),
            .init(latitude: -1.20, longitude: -89.20),
            .init(latitude: -0.50, longitude: -89.40),
            .init(latitude: -0.75, longitude: -90.35),
        ],
        duration: 1800,
        narrationPoints: [
            NarrationPoint(latitude: -0.75, longitude: -90.35, title: "Isabela", subtitle: "The largest island, still being forged by volcanoes."),
            NarrationPoint(latitude: -0.50, longitude: -90.30, title: "Santiago", subtitle: "Where Darwin first set foot."),
            NarrationPoint(latitude: 0.00, longitude: -91.00, title: "Fernandina", subtitle: "The youngest and most pristine island."),
            NarrationPoint(latitude: -0.80, longitude: -91.30, title: "Santa Cruz", subtitle: "The research heart of the archipelago."),
            NarrationPoint(latitude: -1.25, longitude: -89.70, title: "San Cristóbal", subtitle: "Where evolution reveals itself."),
            NarrationPoint(latitude: -0.50, longitude: -89.40, title: "Genovesa", subtitle: "The bird sanctuary of the archipelago."),
        ]
    )

    static let japanVolcanoes = Route(
        title: "Japan",
        subtitle: "Volcanic arc of the rising sun",
        category: .volcanoes,
        coordinates: [
            .init(latitude: 35.36, longitude: 138.73),
            .init(latitude: 35.00, longitude: 138.50),
            .init(latitude: 34.50, longitude: 138.00),
            .init(latitude: 34.00, longitude: 137.50),
            .init(latitude: 33.50, longitude: 137.00),
            .init(latitude: 33.00, longitude: 137.00),
            .init(latitude: 32.50, longitude: 137.00),
            .init(latitude: 32.00, longitude: 137.00),
            .init(latitude: 31.50, longitude: 130.50),
        ],
        duration: 600,
        narrationPoints: [
            NarrationPoint(latitude: 35.36, longitude: 138.73, title: "Mount Fuji", subtitle: "Japan's sacred volcano and cultural icon."),
            NarrationPoint(latitude: 34.50, longitude: 138.00, title: "Izu Peninsula", subtitle: "A volcanic landscape of hot springs."),
            NarrationPoint(latitude: 32.50, longitude: 137.00, title: "Mount Aso", subtitle: "One of the world's largest calderas."),
            NarrationPoint(latitude: 31.50, longitude: 130.50, title: "Sakurajima", subtitle: "An active stratovolcano in Kagoshima Bay."),
        ]
    )

    static let kamchatka = Route(
        title: "Kamchatka",
        subtitle: "Land of fire and ice",
        category: .volcanoes,
        coordinates: [
            .init(latitude: 56.06, longitude: 160.64),
            .init(latitude: 56.00, longitude: 160.50),
            .init(latitude: 55.80, longitude: 160.30),
            .init(latitude: 55.60, longitude: 160.10),
            .init(latitude: 55.40, longitude: 160.00),
            .init(latitude: 55.20, longitude: 159.50),
            .init(latitude: 55.00, longitude: 159.00),
            .init(latitude: 54.80, longitude: 158.50),
            .init(latitude: 54.50, longitude: 158.00),
        ],
        duration: 480,
        narrationPoints: [
            NarrationPoint(latitude: 56.06, longitude: 160.64, title: "Klyuchevskaya Sopka", subtitle: "The tallest active volcano in Kamchatka."),
            NarrationPoint(latitude: 55.60, longitude: 160.30, title: "Tolbachik", subtitle: "A massive volcanic complex."),
            NarrationPoint(latitude: 55.00, longitude: 159.00, title: "Karymsky", subtitle: "Kamchatka's most active volcano."),
            NarrationPoint(latitude: 54.50, longitude: 158.00, title: "Mutnovsky", subtitle: "A geothermal wonderland."),
        ]
    )

    static let alaskaVolcanoes = Route(
        title: "Alaska",
        subtitle: "The Aleutian volcanic arc",
        category: .volcanoes,
        coordinates: [
            .init(latitude: 54.00, longitude: -166.00),
            .init(latitude: 53.50, longitude: -168.00),
            .init(latitude: 53.00, longitude: -170.00),
            .init(latitude: 52.50, longitude: -172.00),
            .init(latitude: 52.00, longitude: -174.00),
            .init(latitude: 52.00, longitude: -176.00),
            .init(latitude: 52.50, longitude: -178.00),
            .init(latitude: 53.00, longitude: 178.00),
            .init(latitude: 53.50, longitude: 176.00),
        ],
        duration: 600,
        narrationPoints: [
            NarrationPoint(latitude: 54.00, longitude: -166.00, title: "Unalaska", subtitle: "Gateway to the Aleutian Islands."),
            NarrationPoint(latitude: 52.50, longitude: -172.00, title: "Adak Island", subtitle: "Volcanic peaks in the mist."),
            NarrationPoint(latitude: 52.00, longitude: -174.00, title: "Aleutian Arc", subtitle: "A chain of volcanoes stretching across the Pacific."),
            NarrationPoint(latitude: 53.00, longitude: 178.00, title: "Buldir Island", subtitle: "Remote volcanic outpost."),
        ]
    )

    static let cascades = Route(
        title: "Cascades",
        subtitle: "The Pacific Northwest volcanic range",
        category: .volcanoes,
        coordinates: [
            .init(latitude: 48.50, longitude: -122.00),
            .init(latitude: 48.00, longitude: -121.80),
            .init(latitude: 47.50, longitude: -121.50),
            .init(latitude: 46.85, longitude: -121.76),
            .init(latitude: 46.20, longitude: -122.00),
            .init(latitude: 45.50, longitude: -122.00),
            .init(latitude: 44.50, longitude: -122.00),
            .init(latitude: 44.00, longitude: -121.50),
            .init(latitude: 43.50, longitude: -121.00),
            .init(latitude: 42.50, longitude: -121.00),
        ],
        duration: 600,
        narrationPoints: [
            NarrationPoint(latitude: 48.50, longitude: -122.00, title: "Mount Baker", subtitle: "The northern sentinel of the Cascades."),
            NarrationPoint(latitude: 48.00, longitude: -121.80, title: "Glacier Peak", subtitle: "One of Washington's most remote volcanoes."),
            NarrationPoint(latitude: 46.85, longitude: -121.76, title: "Mount Rainier", subtitle: "14,410 feet — crown of the Cascades."),
            NarrationPoint(latitude: 45.50, longitude: -122.00, title: "Mount St. Helens", subtitle: "Remembering the 1980 eruption."),
            NarrationPoint(latitude: 44.00, longitude: -121.50, title: "Three Sisters", subtitle: "Three volcanic peaks in the Oregon Cascades."),
            NarrationPoint(latitude: 42.50, longitude: -121.00, title: "Mount Shasta", subtitle: "California's volcanic giant."),
        ]
    )

    static let mexicoVolcanoes = Route(
        title: "Mexico",
        subtitle: "The fiery heart of Mesoamerica",
        category: .volcanoes,
        coordinates: [
            .init(latitude: 19.50, longitude: -98.70),
            .init(latitude: 19.20, longitude: -98.50),
            .init(latitude: 19.02, longitude: -98.62),
            .init(latitude: 19.00, longitude: -98.80),
            .init(latitude: 19.00, longitude: -99.00),
            .init(latitude: 19.00, longitude: -99.20),
            .init(latitude: 18.80, longitude: -99.40),
            .init(latitude: 18.60, longitude: -99.50),
            .init(latitude: 18.50, longitude: -99.60),
            .init(latitude: 18.30, longitude: -100.00),
        ],
        duration: 480,
        narrationPoints: [
            NarrationPoint(latitude: 19.50, longitude: -98.70, title: "La Malinche", subtitle: "A dormant volcano overlooking Puebla."),
            NarrationPoint(latitude: 19.02, longitude: -98.62, title: "Popocatépetl", subtitle: "Mexico's most active volcano."),
            NarrationPoint(latitude: 19.00, longitude: -99.00, title: "Iztaccíhuatl", subtitle: "The sleeping woman of Aztec legend."),
            NarrationPoint(latitude: 18.50, longitude: -99.60, title: "Nevado de Toluca", subtitle: "An ancient stratovolcano with crater lakes."),
            NarrationPoint(latitude: 18.30, longitude: -100.00, title: "Colima", subtitle: "Mexico's most active — the Volcano of Fire."),
        ]
    )

    static let andesVolcanoes = Route(
        title: "Andes",
        subtitle: "The volcanic spine of South America",
        category: .volcanoes,
        coordinates: [
            .init(latitude: -0.50, longitude: -78.50),
            .init(latitude: -0.68, longitude: -78.43),
            .init(latitude: -1.00, longitude: -78.50),
            .init(latitude: -1.50, longitude: -78.50),
            .init(latitude: -2.00, longitude: -78.50),
            .init(latitude: -2.50, longitude: -78.50),
            .init(latitude: -3.00, longitude: -78.50),
            .init(latitude: -3.50, longitude: -78.50),
            .init(latitude: -4.00, longitude: -78.50),
            .init(latitude: -4.50, longitude: -78.50),
            .init(latitude: -5.00, longitude: -78.00),
            .init(latitude: -6.00, longitude: -77.50),
        ],
        duration: 600,
        narrationPoints: [
            NarrationPoint(latitude: -0.50, longitude: -78.50, title: "Cayambe", subtitle: "The only peak on the equator with permanent snow."),
            NarrationPoint(latitude: -0.68, longitude: -78.43, title: "Cotopaxi", subtitle: "19,347 feet — the highest active volcano in the Andes."),
            NarrationPoint(latitude: -1.50, longitude: -78.50, title: "Tungurahua", subtitle: "The throat of fire."),
            NarrationPoint(latitude: -3.00, longitude: -78.50, title: "Sangay", subtitle: "One of Ecuador's most active volcanoes."),
            NarrationPoint(latitude: -6.00, longitude: -77.50, title: "Huascarán", subtitle: "Peru's highest peak — a volcanic giant."),
        ]
    )

    static let newZealandVolcanoes = Route(
        title: "New Zealand",
        subtitle: "The volcanic North Island",
        category: .volcanoes,
        coordinates: [
            .init(latitude: -38.50, longitude: 176.00),
            .init(latitude: -38.80, longitude: 176.00),
            .init(latitude: -39.00, longitude: 176.00),
            .init(latitude: -39.20, longitude: 175.80),
            .init(latitude: -39.28, longitude: 175.57),
            .init(latitude: -39.40, longitude: 175.50),
            .init(latitude: -39.50, longitude: 175.50),
            .init(latitude: -39.80, longitude: 175.50),
            .init(latitude: -40.00, longitude: 175.50),
            .init(latitude: -40.20, longitude: 175.80),
        ],
        duration: 480,
        narrationPoints: [
            NarrationPoint(latitude: -38.50, longitude: 176.00, title: "Lake Rotorua", subtitle: "A caldera lake in a geothermal wonderland."),
            NarrationPoint(latitude: -39.00, longitude: 176.00, title: "Taupō Volcanic Zone", subtitle: "One of the most active volcanic regions on Earth."),
            NarrationPoint(latitude: -39.28, longitude: 175.57, title: "Mount Ruapehu", subtitle: "The North Island's highest peak and active volcano."),
            NarrationPoint(latitude: -39.50, longitude: 175.50, title: "Mount Tongariro", subtitle: "A multi-vent volcanic complex."),
            NarrationPoint(latitude: -40.20, longitude: 175.80, title: "Mount Taranaki", subtitle: "A near-perfect volcanic cone."),
        ]
    )

    static let himalayas = Route(
        title: "Himalayas",
        subtitle: "The Roof of the World",
        category: .mountains,
        coordinates: [
            .init(latitude: 35.2, longitude: 74.6),
            .init(latitude: 34.6, longitude: 76.0),
            .init(latitude: 34.0, longitude: 77.5),
            .init(latitude: 33.2, longitude: 78.8),
            .init(latitude: 32.0, longitude: 80.5),
            .init(latitude: 31.0, longitude: 82.0),
            .init(latitude: 30.5, longitude: 83.5),
            .init(latitude: 29.5, longitude: 85.0),
            .init(latitude: 28.5, longitude: 86.5),
            .init(latitude: 27.9, longitude: 86.9),
            .init(latitude: 27.7, longitude: 88.1),
            .init(latitude: 28.5, longitude: 90.0),
            .init(latitude: 29.0, longitude: 92.0),
            .init(latitude: 29.6, longitude: 95.0),
        ],
        duration: 1800,
        narrationPoints: [
            NarrationPoint(latitude: 35.2, longitude: 74.6, title: "Nanga Parbat", subtitle: "The western anchor of the Himalayas."),
            NarrationPoint(latitude: 32.0, longitude: 80.5, title: "Tibetan Plateau", subtitle: "The highest plateau on Earth."),
            NarrationPoint(latitude: 28.5, longitude: 86.5, title: "Mount Everest", subtitle: "29,032 feet — the summit of the world."),
            NarrationPoint(latitude: 27.7, longitude: 88.1, title: "Kanchenjunga", subtitle: "The third highest peak on Earth."),
            NarrationPoint(latitude: 29.6, longitude: 95.0, title: "Namche Barwa", subtitle: "The eastern terminus of the Himalayan arc."),
        ]
    )

    static let andes = Route(
        title: "Andes",
        subtitle: "The spine of South America",
        category: .mountains,
        coordinates: [
            .init(latitude: 10.8, longitude: -73.7),
            .init(latitude: 8.5, longitude: -75.5),
            .init(latitude: 6.0, longitude: -77.0),
            .init(latitude: 3.0, longitude: -78.0),
            .init(latitude: 0.2, longitude: -78.5),
            .init(latitude: -3.0, longitude: -78.5),
            .init(latitude: -6.0, longitude: -78.0),
            .init(latitude: -9.0, longitude: -77.5),
            .init(latitude: -12.0, longitude: -77.0),
            .init(latitude: -15.0, longitude: -74.0),
            .init(latitude: -18.0, longitude: -69.0),
            .init(latitude: -22.0, longitude: -67.0),
            .init(latitude: -26.0, longitude: -67.0),
            .init(latitude: -30.0, longitude: -69.0),
            .init(latitude: -32.7, longitude: -70.0),
            .init(latitude: -35.0, longitude: -71.0),
            .init(latitude: -38.0, longitude: -71.5),
            .init(latitude: -41.0, longitude: -72.0),
            .init(latitude: -44.0, longitude: -72.5),
            .init(latitude: -47.0, longitude: -73.0),
            .init(latitude: -50.0, longitude: -73.0),
            .init(latitude: -54.9, longitude: -68.5),
        ],
        duration: 2400,
        narrationPoints: [
            NarrationPoint(latitude: 10.8, longitude: -73.7, title: "Sierra Nevada de Santa Marta", subtitle: "The northernmost range of the Andes."),
            NarrationPoint(latitude: 0.2, longitude: -78.5, title: "Equator", subtitle: "Crossing the middle of the world."),
            NarrationPoint(latitude: -9.1, longitude: -77.6, title: "Huascarán", subtitle: "Peru's highest peak at 22,205 feet."),
            NarrationPoint(latitude: -18.1, longitude: -68.9, title: "Sajama", subtitle: "Bolivia's highest mountain."),
            NarrationPoint(latitude: -32.7, longitude: -70.0, title: "Aconcagua", subtitle: "22,837 feet — the highest peak in the Americas."),
            NarrationPoint(latitude: -50.0, longitude: -73.0, title: "Patagonia", subtitle: "Towering spires and immense glaciers."),
            NarrationPoint(latitude: -54.9, longitude: -68.5, title: "Tierra del Fuego", subtitle: "Where the Andes meet the sea."),
        ]
    )

    static let alps = Route(
        title: "Alps",
        subtitle: "Europe's great mountain range",
        category: .mountains,
        coordinates: [
            .init(latitude: 45.8, longitude: 6.9),
            .init(latitude: 46.0, longitude: 7.5),
            .init(latitude: 46.0, longitude: 7.7),
            .init(latitude: 46.2, longitude: 8.0),
            .init(latitude: 46.5, longitude: 8.0),
            .init(latitude: 46.6, longitude: 8.6),
            .init(latitude: 46.8, longitude: 9.5),
            .init(latitude: 46.4, longitude: 10.0),
            .init(latitude: 46.4, longitude: 11.0),
            .init(latitude: 46.4, longitude: 11.9),
            .init(latitude: 46.8, longitude: 12.3),
            .init(latitude: 47.1, longitude: 12.7),
            .init(latitude: 47.3, longitude: 13.0),
        ],
        duration: 1200,
        narrationPoints: [
            NarrationPoint(latitude: 45.8, longitude: 6.9, title: "Mont Blanc", subtitle: "15,774 feet — western Europe's highest peak."),
            NarrationPoint(latitude: 46.0, longitude: 7.7, title: "Matterhorn", subtitle: "The iconic pyramid of the Alps."),
            NarrationPoint(latitude: 46.5, longitude: 8.0, title: "Jungfrau Region", subtitle: "A wonderland of glaciers and peaks."),
            NarrationPoint(latitude: 46.4, longitude: 10.0, title: "Bernina Range", subtitle: "Switzerland's eastern alpine crown."),
            NarrationPoint(latitude: 46.4, longitude: 11.9, title: "Dolomites", subtitle: "Pale peaks of the Italian Alps."),
            NarrationPoint(latitude: 47.1, longitude: 12.7, title: "Grossglockner", subtitle: "Austria's highest mountain."),
        ]
    )

    static let rockies = Route(
        title: "Rocky Mountains",
        subtitle: "The backbone of North America",
        category: .mountains,
        coordinates: [
            .init(latitude: 53.0, longitude: -118.5),
            .init(latitude: 52.0, longitude: -117.0),
            .init(latitude: 51.2, longitude: -115.6),
            .init(latitude: 50.0, longitude: -114.5),
            .init(latitude: 49.0, longitude: -114.0),
            .init(latitude: 48.7, longitude: -113.8),
            .init(latitude: 47.5, longitude: -113.0),
            .init(latitude: 46.0, longitude: -111.5),
            .init(latitude: 44.6, longitude: -110.6),
            .init(latitude: 43.7, longitude: -110.7),
            .init(latitude: 42.0, longitude: -109.0),
            .init(latitude: 41.0, longitude: -107.0),
            .init(latitude: 40.3, longitude: -105.7),
            .init(latitude: 39.0, longitude: -105.5),
            .init(latitude: 37.5, longitude: -106.0),
            .init(latitude: 35.7, longitude: -105.9),
        ],
        duration: 1800,
        narrationPoints: [
            NarrationPoint(latitude: 52.9, longitude: -118.1, title: "Jasper", subtitle: "Crown of the Canadian Rockies."),
            NarrationPoint(latitude: 51.2, longitude: -115.6, title: "Banff", subtitle: "Canada's first national park."),
            NarrationPoint(latitude: 48.7, longitude: -113.8, title: "Glacier National Park", subtitle: "The Crown of the Continent."),
            NarrationPoint(latitude: 44.6, longitude: -110.6, title: "Yellowstone", subtitle: "The world's first national park."),
            NarrationPoint(latitude: 43.7, longitude: -110.7, title: "Grand Teton", subtitle: "A jagged spire rising from the valley."),
            NarrationPoint(latitude: 40.3, longitude: -105.7, title: "Rocky Mountain National Park", subtitle: "The heart of the Colorado Rockies."),
        ]
    )

    static let southernAlps = Route(
        title: "Southern Alps",
        subtitle: "New Zealand's alpine spine",
        category: .mountains,
        coordinates: [
            .init(latitude: -41.1, longitude: 172.5),
            .init(latitude: -41.5, longitude: 172.0),
            .init(latitude: -42.0, longitude: 171.8),
            .init(latitude: -42.5, longitude: 171.5),
            .init(latitude: -43.0, longitude: 171.0),
            .init(latitude: -43.5, longitude: 170.5),
            .init(latitude: -43.6, longitude: 170.1),
            .init(latitude: -44.0, longitude: 169.8),
            .init(latitude: -44.5, longitude: 169.0),
            .init(latitude: -45.0, longitude: 168.5),
            .init(latitude: -45.4, longitude: 167.5),
            .init(latitude: -45.8, longitude: 167.0),
            .init(latitude: -46.7, longitude: 168.1),
        ],
        duration: 900,
        narrationPoints: [
            NarrationPoint(latitude: -41.1, longitude: 172.5, title: "Kahurangi", subtitle: "The northern gateway to the Southern Alps."),
            NarrationPoint(latitude: -43.6, longitude: 170.1, title: "Aoraki / Mount Cook", subtitle: "12,218 feet — New Zealand's highest peak."),
            NarrationPoint(latitude: -44.0, longitude: 169.8, title: "Westland Tai Poutini", subtitle: "Glaciers descending to rainforest."),
            NarrationPoint(latitude: -45.4, longitude: 167.5, title: "Fiordland", subtitle: "Where mountains plunge into the sea."),
        ]
    )

    static let sahara = Route(
        title: "Sahara",
        subtitle: "The world's largest hot desert",
        category: .deserts,
        coordinates: [
            .init(latitude: 20.0, longitude: -5.0),
            .init(latitude: 21.0, longitude: -2.0),
            .init(latitude: 22.5, longitude: 1.0),
            .init(latitude: 24.0, longitude: 4.0),
            .init(latitude: 25.0, longitude: 7.0),
            .init(latitude: 26.0, longitude: 10.0),
            .init(latitude: 26.5, longitude: 13.0),
            .init(latitude: 26.0, longitude: 16.0),
            .init(latitude: 25.5, longitude: 19.0),
            .init(latitude: 25.0, longitude: 22.0),
            .init(latitude: 24.5, longitude: 25.0),
            .init(latitude: 24.0, longitude: 28.0),
            .init(latitude: 24.5, longitude: 31.0),
            .init(latitude: 25.0, longitude: 33.0),
        ],
        duration: 1800,
        narrationPoints: [
            NarrationPoint(latitude: 20.0, longitude: -5.0, title: "Mali Dunes", subtitle: "The sea of sand begins here."),
            NarrationPoint(latitude: 24.0, longitude: 4.0, title: "Tassili n'Ajjer", subtitle: "Ancient rock art in the Sahara."),
            NarrationPoint(latitude: 26.5, longitude: 13.0, title: "Ubari Sand Sea", subtitle: "Vast dunes of the Libyan Sahara."),
            NarrationPoint(latitude: 25.0, longitude: 22.0, title: "Erg Awbari", subtitle: "Where dunes meet oasis."),
            NarrationPoint(latitude: 24.5, longitude: 31.0, title: "Great Sand Sea", subtitle: "Endless waves of sand."),
            NarrationPoint(latitude: 25.0, longitude: 33.0, title: "Luxor", subtitle: "The eastern edge of the great desert."),
        ]
    )

    static let namib = Route(
        title: "Namib",
        subtitle: "The oldest desert on Earth",
        category: .deserts,
        coordinates: [
            .init(latitude: -22.0, longitude: 14.0),
            .init(latitude: -22.5, longitude: 14.5),
            .init(latitude: -23.0, longitude: 15.0),
            .init(latitude: -23.5, longitude: 15.0),
            .init(latitude: -24.0, longitude: 15.0),
            .init(latitude: -24.5, longitude: 15.0),
            .init(latitude: -25.0, longitude: 15.0),
            .init(latitude: -25.5, longitude: 15.0),
            .init(latitude: -26.0, longitude: 15.0),
            .init(latitude: -26.5, longitude: 15.0),
            .init(latitude: -27.0, longitude: 15.0),
        ],
        duration: 900,
        narrationPoints: [
            NarrationPoint(latitude: -22.0, longitude: 14.0, title: "Swakopmund", subtitle: "Where the desert meets the Atlantic."),
            NarrationPoint(latitude: -23.5, longitude: 15.0, title: "Walvis Bay", subtitle: "A lagoon among the dunes."),
            NarrationPoint(latitude: -24.7, longitude: 15.0, title: "Sossusvlei", subtitle: "The iconic red dunes of Namibia."),
            NarrationPoint(latitude: -26.0, longitude: 15.0, title: "Namib Sand Sea", subtitle: "Millions of years of shifting sands."),
        ]
    )

    static let atacama = Route(
        title: "Atacama",
        subtitle: "The driest place on Earth",
        category: .deserts,
        coordinates: [
            .init(latitude: -20.0, longitude: -70.0),
            .init(latitude: -20.5, longitude: -70.0),
            .init(latitude: -21.0, longitude: -69.5),
            .init(latitude: -21.5, longitude: -69.0),
            .init(latitude: -22.0, longitude: -69.0),
            .init(latitude: -22.5, longitude: -68.5),
            .init(latitude: -23.0, longitude: -68.5),
            .init(latitude: -23.5, longitude: -68.5),
            .init(latitude: -24.0, longitude: -68.5),
            .init(latitude: -24.5, longitude: -68.5),
            .init(latitude: -25.0, longitude: -68.5),
        ],
        duration: 900,
        narrationPoints: [
            NarrationPoint(latitude: -20.0, longitude: -70.0, title: "Iquique", subtitle: "Coastal gateway to the Atacama."),
            NarrationPoint(latitude: -21.5, longitude: -69.0, title: "Calama", subtitle: "Heart of the driest desert."),
            NarrationPoint(latitude: -22.5, longitude: -68.5, title: "San Pedro de Atacama", subtitle: "An oasis in the high desert."),
            NarrationPoint(latitude: -24.0, longitude: -68.5, title: "Salar de Atacama", subtitle: "A salt flat beneath volcanic peaks."),
        ]
    )

    static let gobi = Route(
        title: "Gobi",
        subtitle: "Asia's vast cold desert",
        category: .deserts,
        coordinates: [
            .init(latitude: 45.0, longitude: 105.0),
            .init(latitude: 44.5, longitude: 104.0),
            .init(latitude: 44.0, longitude: 103.0),
            .init(latitude: 43.5, longitude: 102.0),
            .init(latitude: 43.0, longitude: 101.0),
            .init(latitude: 42.5, longitude: 100.0),
            .init(latitude: 42.0, longitude: 99.0),
            .init(latitude: 41.5, longitude: 98.0),
            .init(latitude: 41.0, longitude: 97.0),
            .init(latitude: 40.5, longitude: 96.0),
        ],
        duration: 900,
        narrationPoints: [
            NarrationPoint(latitude: 45.0, longitude: 105.0, title: "Eastern Gobi", subtitle: "Vast steppe and desert meet."),
            NarrationPoint(latitude: 44.0, longitude: 103.0, title: "Gobi Gurvansaikhan", subtitle: "The beautiful landscape of the Gobi."),
            NarrationPoint(latitude: 43.0, longitude: 101.0, title: "Khongoryn Els", subtitle: "The singing sands of the Gobi."),
            NarrationPoint(latitude: 41.5, longitude: 98.0, title: "Gobi Desert", subtitle: "Fossil treasures in the sands."),
        ]
    )

    static let arabianDesert = Route(
        title: "Arabian Desert",
        subtitle: "The Empty Quarter",
        category: .deserts,
        coordinates: [
            .init(latitude: 24.0, longitude: 50.0),
            .init(latitude: 23.5, longitude: 49.0),
            .init(latitude: 23.0, longitude: 48.0),
            .init(latitude: 22.5, longitude: 47.0),
            .init(latitude: 22.0, longitude: 46.0),
            .init(latitude: 21.5, longitude: 45.0),
            .init(latitude: 21.0, longitude: 44.0),
            .init(latitude: 20.5, longitude: 43.0),
            .init(latitude: 20.0, longitude: 42.0),
            .init(latitude: 19.5, longitude: 41.0),
            .init(latitude: 19.0, longitude: 40.0),
        ],
        duration: 900,
        narrationPoints: [
            NarrationPoint(latitude: 24.0, longitude: 50.0, title: "Jubail", subtitle: "Where the desert meets the Gulf."),
            NarrationPoint(latitude: 23.0, longitude: 48.0, title: "Rub' al Khali", subtitle: "The Empty Quarter — the largest continuous sand desert."),
            NarrationPoint(latitude: 21.5, longitude: 45.0, title: "Empty Quarter", subtitle: "Unbroken dunes stretching to the horizon."),
            NarrationPoint(latitude: 20.0, longitude: 42.0, title: "Asir Mountains", subtitle: "Where the desert rises into highlands."),
        ]
    )

    static let greenland = Route(
        title: "Greenland Coastline",
        subtitle: "Ice fjords of the Arctic",
        category: .polar,
        coordinates: [
            .init(latitude: 61.0, longitude: -45.0),
            .init(latitude: 62.0, longitude: -46.0),
            .init(latitude: 63.0, longitude: -47.0),
            .init(latitude: 64.0, longitude: -48.0),
            .init(latitude: 64.5, longitude: -49.0),
            .init(latitude: 65.0, longitude: -50.0),
            .init(latitude: 65.5, longitude: -51.0),
            .init(latitude: 66.0, longitude: -52.0),
            .init(latitude: 66.5, longitude: -52.5),
            .init(latitude: 67.0, longitude: -53.0),
            .init(latitude: 67.5, longitude: -53.0),
            .init(latitude: 68.0, longitude: -53.0),
            .init(latitude: 68.5, longitude: -53.0),
            .init(latitude: 69.0, longitude: -52.0),
            .init(latitude: 69.3, longitude: -51.0),
        ],
        duration: 1200,
        narrationPoints: [
            NarrationPoint(latitude: 61.0, longitude: -45.0, title: "Nanortalik", subtitle: "The southern gateway to Greenland."),
            NarrationPoint(latitude: 64.0, longitude: -48.0, title: "Icefjord", subtitle: "Where glaciers calve into the sea."),
            NarrationPoint(latitude: 66.5, longitude: -52.5, title: "Sermersuaq", subtitle: "The great Greenland ice sheet."),
            NarrationPoint(latitude: 69.3, longitude: -51.0, title: "Ilulissat", subtitle: "The iceberg capital of the world."),
        ]
    )

    static let antarcticPeninsula = Route(
        title: "Antarctic Peninsula",
        subtitle: "The frozen frontier",
        category: .polar,
        coordinates: [
            .init(latitude: -63.0, longitude: -57.0),
            .init(latitude: -63.5, longitude: -57.5),
            .init(latitude: -64.0, longitude: -58.0),
            .init(latitude: -64.5, longitude: -59.0),
            .init(latitude: -65.0, longitude: -60.0),
            .init(latitude: -65.5, longitude: -60.5),
            .init(latitude: -66.0, longitude: -61.0),
            .init(latitude: -66.5, longitude: -62.0),
            .init(latitude: -67.0, longitude: -63.0),
            .init(latitude: -67.5, longitude: -64.0),
            .init(latitude: -68.0, longitude: -65.0),
            .init(latitude: -68.5, longitude: -66.0),
            .init(latitude: -69.0, longitude: -67.0),
            .init(latitude: -69.5, longitude: -68.0),
            .init(latitude: -70.0, longitude: -69.0),
            .init(latitude: -70.5, longitude: -70.0),
            .init(latitude: -71.0, longitude: -71.0),
            .init(latitude: -71.5, longitude: -72.0),
            .init(latitude: -72.0, longitude: -73.0),
            .init(latitude: -72.5, longitude: -74.0),
        ],
        duration: 1800,
        narrationPoints: [
            NarrationPoint(latitude: -63.0, longitude: -57.0, title: "Hope Bay", subtitle: "The tip of the Antarctic Peninsula."),
            NarrationPoint(latitude: -64.5, longitude: -59.0, title: "Snow Hill Island", subtitle: "Home to emperor penguin colonies."),
            NarrationPoint(latitude: -66.0, longitude: -61.0, title: "Jason Peninsula", subtitle: "Towering ice cliffs and glaciers."),
            NarrationPoint(latitude: -68.5, longitude: -66.0, title: "Marguerite Bay", subtitle: "Where the ice meets the Southern Ocean."),
            NarrationPoint(latitude: -71.0, longitude: -71.0, title: "Alexander Island", subtitle: "The frozen edge of the continent."),
        ]
    )

    static let northwestPassage = Route(
        title: "Northwest Passage",
        subtitle: "Through the Arctic Archipelago",
        category: .polar,
        coordinates: [
            .init(latitude: 74.0, longitude: -80.0),
            .init(latitude: 74.0, longitude: -82.0),
            .init(latitude: 73.5, longitude: -84.0),
            .init(latitude: 73.0, longitude: -86.0),
            .init(latitude: 73.0, longitude: -88.0),
            .init(latitude: 72.5, longitude: -90.0),
            .init(latitude: 72.0, longitude: -92.0),
            .init(latitude: 72.0, longitude: -94.0),
            .init(latitude: 71.5, longitude: -96.0),
            .init(latitude: 71.0, longitude: -98.0),
            .init(latitude: 71.0, longitude: -100.0),
            .init(latitude: 70.5, longitude: -102.0),
            .init(latitude: 70.0, longitude: -104.0),
            .init(latitude: 70.0, longitude: -106.0),
            .init(latitude: 69.5, longitude: -108.0),
            .init(latitude: 69.0, longitude: -110.0),
            .init(latitude: 69.0, longitude: -112.0),
            .init(latitude: 69.0, longitude: -114.0),
            .init(latitude: 69.0, longitude: -116.0),
            .init(latitude: 69.0, longitude: -118.0),
            .init(latitude: 69.5, longitude: -120.0),
            .init(latitude: 70.0, longitude: -122.0),
            .init(latitude: 70.5, longitude: -124.0),
        ],
        duration: 1800,
        narrationPoints: [
            NarrationPoint(latitude: 74.0, longitude: -80.0, title: "Lancaster Sound", subtitle: "The eastern entrance to the passage."),
            NarrationPoint(latitude: 73.0, longitude: -86.0, title: "Prince Regent Inlet", subtitle: "Ice-choked waters of the Arctic."),
            NarrationPoint(latitude: 72.0, longitude: -94.0, title: "Bellot Strait", subtitle: "A narrow channel through the ice."),
            NarrationPoint(latitude: 70.5, longitude: -102.0, title: "Victoria Strait", subtitle: "Where explorers sought a route west."),
            NarrationPoint(latitude: 69.0, longitude: -112.0, title: "Dease Strait", subtitle: "Navigating the heart of the passage."),
            NarrationPoint(latitude: 70.0, longitude: -122.0, title: "Amundsen Gulf", subtitle: "The western gateway to the Beaufort Sea."),
        ]
    )

    static let svalbard = Route(
        title: "Svalbard",
        subtitle: "The Arctic archipelago",
        category: .polar,
        coordinates: [
            .init(latitude: 78.2, longitude: 15.0),
            .init(latitude: 78.5, longitude: 14.0),
            .init(latitude: 78.8, longitude: 13.0),
            .init(latitude: 79.0, longitude: 12.0),
            .init(latitude: 79.2, longitude: 11.0),
            .init(latitude: 79.0, longitude: 10.0),
            .init(latitude: 78.8, longitude: 10.5),
            .init(latitude: 78.5, longitude: 11.0),
            .init(latitude: 78.2, longitude: 12.0),
            .init(latitude: 78.0, longitude: 13.0),
            .init(latitude: 77.8, longitude: 14.0),
            .init(latitude: 77.5, longitude: 15.0),
            .init(latitude: 77.5, longitude: 16.0),
            .init(latitude: 77.8, longitude: 17.0),
            .init(latitude: 78.0, longitude: 18.0),
            .init(latitude: 78.2, longitude: 19.0),
            .init(latitude: 78.5, longitude: 20.0),
            .init(latitude: 78.8, longitude: 21.0),
            .init(latitude: 79.0, longitude: 20.0),
            .init(latitude: 79.0, longitude: 18.0),
            .init(latitude: 78.8, longitude: 16.0),
            .init(latitude: 78.5, longitude: 15.0),
            .init(latitude: 78.2, longitude: 15.0),
        ],
        duration: 1200,
        narrationPoints: [
            NarrationPoint(latitude: 78.2, longitude: 15.0, title: "Longyearbyen", subtitle: "The northernmost settlement on Earth."),
            NarrationPoint(latitude: 79.0, longitude: 12.0, title: "Ny-Ålesund", subtitle: "Research outpost at the edge of the ice."),
            NarrationPoint(latitude: 78.0, longitude: 13.0, title: "Isfjorden", subtitle: "A majestic Arctic fjord system."),
            NarrationPoint(latitude: 78.5, longitude: 20.0, title: "Edgeøya", subtitle: "Remote wilderness of the eastern archipelago."),
            NarrationPoint(latitude: 78.8, longitude: 15.0, title: "Adventfjorden", subtitle: "Glaciers cascading into the sea."),
        ]
    )

    static let london = Route(
        title: "London",
        subtitle: "The Thames from above",
        category: .cities,
        coordinates: [
            .init(latitude: 51.48, longitude: -0.15),
            .init(latitude: 51.49, longitude: -0.12),
            .init(latitude: 51.50, longitude: -0.10),
            .init(latitude: 51.50, longitude: -0.09),
            .init(latitude: 51.50, longitude: -0.08),
            .init(latitude: 51.50, longitude: -0.07),
            .init(latitude: 51.50, longitude: -0.05),
            .init(latitude: 51.50, longitude: -0.03),
            .init(latitude: 51.50, longitude: 0.00),
        ],
        duration: 600,
        narrationPoints: [
            NarrationPoint(latitude: 51.48, longitude: -0.15, title: "Chelsea", subtitle: "The historic borough on the Thames."),
            NarrationPoint(latitude: 51.50, longitude: -0.12, title: "Big Ben", subtitle: "Iconic clock tower of the Palace of Westminster."),
            NarrationPoint(latitude: 51.50, longitude: -0.10, title: "London Eye", subtitle: "The soaring observation wheel."),
            NarrationPoint(latitude: 51.50, longitude: -0.08, title: "Somerset House", subtitle: "A neoclassical masterpiece."),
            NarrationPoint(latitude: 51.50, longitude: -0.05, title: "Tower Bridge", subtitle: "The defining bridge of London."),
            NarrationPoint(latitude: 51.50, longitude: 0.00, title: "Canary Wharf", subtitle: "Modern London's financial skyline."),
        ]
    )

    static let paris = Route(
        title: "Paris",
        subtitle: "The City of Light",
        category: .cities,
        coordinates: [
            .init(latitude: 48.86, longitude: 2.30),
            .init(latitude: 48.86, longitude: 2.32),
            .init(latitude: 48.86, longitude: 2.34),
            .init(latitude: 48.86, longitude: 2.35),
            .init(latitude: 48.85, longitude: 2.35),
            .init(latitude: 48.85, longitude: 2.34),
            .init(latitude: 48.85, longitude: 2.33),
            .init(latitude: 48.85, longitude: 2.30),
            .init(latitude: 48.85, longitude: 2.28),
            .init(latitude: 48.85, longitude: 2.25),
            .init(latitude: 48.85, longitude: 2.22),
        ],
        duration: 600,
        narrationPoints: [
            NarrationPoint(latitude: 48.86, longitude: 2.30, title: "Arc de Triomphe", subtitle: "The grand arch at the center of Paris."),
            NarrationPoint(latitude: 48.86, longitude: 2.34, title: "Opéra Garnier", subtitle: "A masterpiece of Beaux-Arts architecture."),
            NarrationPoint(latitude: 48.85, longitude: 2.34, title: "Louvre Museum", subtitle: "The world's largest art museum."),
            NarrationPoint(latitude: 48.85, longitude: 2.33, title: "Notre-Dame", subtitle: "The Gothic heart of Paris."),
            NarrationPoint(latitude: 48.85, longitude: 2.28, title: "Eiffel Tower", subtitle: "Paris's iron lady."),
        ]
    )

    static let rome = Route(
        title: "Rome",
        subtitle: "The Eternal City",
        category: .cities,
        coordinates: [
            .init(latitude: 41.91, longitude: 12.48),
            .init(latitude: 41.91, longitude: 12.47),
            .init(latitude: 41.90, longitude: 12.47),
            .init(latitude: 41.90, longitude: 12.48),
            .init(latitude: 41.89, longitude: 12.48),
            .init(latitude: 41.89, longitude: 12.49),
            .init(latitude: 41.89, longitude: 12.50),
            .init(latitude: 41.88, longitude: 12.50),
            .init(latitude: 41.88, longitude: 12.49),
            .init(latitude: 41.88, longitude: 12.48),
            .init(latitude: 41.88, longitude: 12.47),
            .init(latitude: 41.88, longitude: 12.46),
        ],
        duration: 600,
        narrationPoints: [
            NarrationPoint(latitude: 41.91, longitude: 12.48, title: "Vatican City", subtitle: "The spiritual center of Catholicism."),
            NarrationPoint(latitude: 41.90, longitude: 12.48, title: "Castel Sant'Angelo", subtitle: "The fortress of the popes."),
            NarrationPoint(latitude: 41.89, longitude: 12.49, title: "Pantheon", subtitle: "An ancient architectural marvel."),
            NarrationPoint(latitude: 41.88, longitude: 12.50, title: "Colosseum", subtitle: "The eternal symbol of ancient Rome."),
            NarrationPoint(latitude: 41.88, longitude: 12.47, title: "Spanish Steps", subtitle: "Where beauty meets history."),
        ]
    )

    static let istanbul = Route(
        title: "Istanbul",
        subtitle: "Where continents meet",
        category: .cities,
        coordinates: [
            .init(latitude: 41.04, longitude: 28.95),
            .init(latitude: 41.03, longitude: 28.96),
            .init(latitude: 41.02, longitude: 28.97),
            .init(latitude: 41.01, longitude: 28.97),
            .init(latitude: 41.01, longitude: 28.98),
            .init(latitude: 41.01, longitude: 28.99),
            .init(latitude: 41.01, longitude: 29.00),
            .init(latitude: 41.02, longitude: 29.01),
            .init(latitude: 41.03, longitude: 29.01),
            .init(latitude: 41.04, longitude: 29.00),
            .init(latitude: 41.05, longitude: 29.00),
            .init(latitude: 41.06, longitude: 29.00),
            .init(latitude: 41.07, longitude: 29.00),
        ],
        duration: 600,
        narrationPoints: [
            NarrationPoint(latitude: 41.04, longitude: 28.95, title: "Galata Tower", subtitle: "Medieval tower overlooking the Golden Horn."),
            NarrationPoint(latitude: 41.02, longitude: 28.97, title: "Hagia Sophia", subtitle: "Byzantine masterpiece and cultural icon."),
            NarrationPoint(latitude: 41.01, longitude: 28.98, title: "Blue Mosque", subtitle: "Sultan Ahmed's imperial mosque."),
            NarrationPoint(latitude: 41.01, longitude: 29.00, title: "Topkapi Palace", subtitle: "The heart of the Ottoman Empire."),
            NarrationPoint(latitude: 41.04, longitude: 29.00, title: "Bosphorus Bridge", subtitle: "Connecting Europe and Asia."),
        ]
    )

    static let cairo = Route(
        title: "Cairo",
        subtitle: "The city of a thousand minarets",
        category: .cities,
        coordinates: [
            .init(latitude: 30.05, longitude: 31.22),
            .init(latitude: 30.05, longitude: 31.24),
            .init(latitude: 30.05, longitude: 31.26),
            .init(latitude: 30.04, longitude: 31.27),
            .init(latitude: 30.03, longitude: 31.27),
            .init(latitude: 30.02, longitude: 31.26),
            .init(latitude: 30.02, longitude: 31.25),
            .init(latitude: 30.01, longitude: 31.24),
            .init(latitude: 30.00, longitude: 31.23),
            .init(latitude: 30.00, longitude: 31.22),
            .init(latitude: 30.00, longitude: 31.20),
            .init(latitude: 30.00, longitude: 31.18),
        ],
        duration: 600,
        narrationPoints: [
            NarrationPoint(latitude: 30.05, longitude: 31.22, title: "Zamalek", subtitle: "The island district on the Nile."),
            NarrationPoint(latitude: 30.04, longitude: 31.27, title: "Cairo Tower", subtitle: "The modern sentinel of Cairo."),
            NarrationPoint(latitude: 30.03, longitude: 31.27, title: "Tahrir Square", subtitle: "The beating heart of modern Egypt."),
            NarrationPoint(latitude: 30.01, longitude: 31.25, title: "Islamic Cairo", subtitle: "A thousand minarets against the sky."),
            NarrationPoint(latitude: 30.00, longitude: 31.18, title: "Pyramids of Giza", subtitle: "The last surviving wonder of the ancient world."),
        ]
    )

    static let newYork = Route(
        title: "New York City",
        subtitle: "The concrete jungle",
        category: .cities,
        coordinates: [
            .init(latitude: 40.76, longitude: -73.98),
            .init(latitude: 40.76, longitude: -73.97),
            .init(latitude: 40.76, longitude: -73.96),
            .init(latitude: 40.76, longitude: -73.95),
            .init(latitude: 40.75, longitude: -73.95),
            .init(latitude: 40.75, longitude: -73.96),
            .init(latitude: 40.74, longitude: -73.96),
            .init(latitude: 40.74, longitude: -73.97),
            .init(latitude: 40.73, longitude: -73.97),
            .init(latitude: 40.72, longitude: -73.97),
            .init(latitude: 40.71, longitude: -73.97),
            .init(latitude: 40.70, longitude: -73.97),
            .init(latitude: 40.69, longitude: -73.97),
            .init(latitude: 40.68, longitude: -73.97),
        ],
        duration: 900,
        narrationPoints: [
            NarrationPoint(latitude: 40.76, longitude: -73.98, title: "Central Park", subtitle: "The green lungs of Manhattan."),
            NarrationPoint(latitude: 40.76, longitude: -73.96, title: "Rockefeller Center", subtitle: "The art deco heart of Midtown."),
            NarrationPoint(latitude: 40.75, longitude: -73.96, title: "Times Square", subtitle: "The crossroads of the world."),
            NarrationPoint(latitude: 40.74, longitude: -73.97, title: "Empire State Building", subtitle: "The iconic skyscraper of New York."),
            NarrationPoint(latitude: 40.71, longitude: -73.97, title: "Brooklyn Bridge", subtitle: "A masterpiece of 19th-century engineering."),
            NarrationPoint(latitude: 40.69, longitude: -73.97, title: "Statue of Liberty", subtitle: "Lady Liberty welcoming the world."),
        ]
    )

    static let tokyo = Route(
        title: "Tokyo",
        subtitle: "The neon metropolis",
        category: .cities,
        coordinates: [
            .init(latitude: 35.69, longitude: 139.70),
            .init(latitude: 35.69, longitude: 139.71),
            .init(latitude: 35.68, longitude: 139.72),
            .init(latitude: 35.67, longitude: 139.73),
            .init(latitude: 35.66, longitude: 139.74),
            .init(latitude: 35.65, longitude: 139.74),
            .init(latitude: 35.64, longitude: 139.74),
            .init(latitude: 35.64, longitude: 139.75),
            .init(latitude: 35.63, longitude: 139.76),
            .init(latitude: 35.63, longitude: 139.77),
            .init(latitude: 35.63, longitude: 139.78),
        ],
        duration: 600,
        narrationPoints: [
            NarrationPoint(latitude: 35.69, longitude: 139.70, title: "Shinjuku", subtitle: "The neon heart of Tokyo."),
            NarrationPoint(latitude: 35.68, longitude: 139.72, title: "Shibuya", subtitle: "The world's busiest crossing."),
            NarrationPoint(latitude: 35.66, longitude: 139.74, title: "Tokyo Tower", subtitle: "The red and white icon of the city."),
            NarrationPoint(latitude: 35.64, longitude: 139.75, title: "Imperial Palace", subtitle: "The serene heart of old Edo."),
            NarrationPoint(latitude: 35.63, longitude: 139.78, title: "Rainbow Bridge", subtitle: "The gateway to Tokyo Bay."),
        ]
    )

    static let dubai = Route(
        title: "Dubai",
        subtitle: "The city of superlatives",
        category: .cities,
        coordinates: [
            .init(latitude: 25.20, longitude: 55.26),
            .init(latitude: 25.20, longitude: 55.27),
            .init(latitude: 25.19, longitude: 55.27),
            .init(latitude: 25.18, longitude: 55.27),
            .init(latitude: 25.17, longitude: 55.27),
            .init(latitude: 25.16, longitude: 55.27),
            .init(latitude: 25.15, longitude: 55.26),
            .init(latitude: 25.14, longitude: 55.25),
            .init(latitude: 25.13, longitude: 55.24),
            .init(latitude: 25.12, longitude: 55.23),
            .init(latitude: 25.11, longitude: 55.22),
            .init(latitude: 25.10, longitude: 55.21),
        ],
        duration: 600,
        narrationPoints: [
            NarrationPoint(latitude: 25.20, longitude: 55.27, title: "Burj Khalifa", subtitle: "The tallest building on Earth."),
            NarrationPoint(latitude: 25.18, longitude: 55.27, title: "Dubai Mall", subtitle: "A retail city beneath a single roof."),
            NarrationPoint(latitude: 25.16, longitude: 55.27, title: "Dubai Marina", subtitle: "A glittering waterfront district."),
            NarrationPoint(latitude: 25.13, longitude: 55.24, title: "Palm Jumeirah", subtitle: "The iconic artificial archipelago."),
            NarrationPoint(latitude: 25.10, longitude: 55.21, title: "Burj Al Arab", subtitle: "The sail-shaped silhouette of Dubai."),
        ]
    )

    static let hongKong = Route(
        title: "Hong Kong",
        subtitle: "Where East meets West",
        category: .cities,
        coordinates: [
            .init(latitude: 22.30, longitude: 114.15),
            .init(latitude: 22.30, longitude: 114.16),
            .init(latitude: 22.29, longitude: 114.17),
            .init(latitude: 22.28, longitude: 114.17),
            .init(latitude: 22.28, longitude: 114.16),
            .init(latitude: 22.27, longitude: 114.16),
            .init(latitude: 22.27, longitude: 114.17),
            .init(latitude: 22.27, longitude: 114.18),
            .init(latitude: 22.27, longitude: 114.19),
            .init(latitude: 22.27, longitude: 114.20),
            .init(latitude: 22.27, longitude: 114.21),
        ],
        duration: 600,
        narrationPoints: [
            NarrationPoint(latitude: 22.30, longitude: 114.15, title: "Tsim Sha Tsui", subtitle: "Kowloon's vibrant waterfront."),
            NarrationPoint(latitude: 22.29, longitude: 114.17, title: "Victoria Harbour", subtitle: "One of the world's finest harbors."),
            NarrationPoint(latitude: 22.28, longitude: 114.16, title: "Central", subtitle: "The financial heart of Asia."),
            NarrationPoint(latitude: 22.27, longitude: 114.18, title: "Wan Chai", subtitle: "A district of contrasts."),
            NarrationPoint(latitude: 22.27, longitude: 114.20, title: "Happy Valley", subtitle: "A green oasis amid the skyscrapers."),
        ]
    )

    static let sydney = Route(
        title: "Sydney",
        subtitle: "The harbour city",
        category: .cities,
        coordinates: [
            .init(latitude: -33.85, longitude: 151.20),
            .init(latitude: -33.85, longitude: 151.21),
            .init(latitude: -33.84, longitude: 151.21),
            .init(latitude: -33.84, longitude: 151.20),
            .init(latitude: -33.84, longitude: 151.19),
            .init(latitude: -33.84, longitude: 151.18),
            .init(latitude: -33.85, longitude: 151.18),
            .init(latitude: -33.86, longitude: 151.18),
            .init(latitude: -33.87, longitude: 151.18),
            .init(latitude: -33.88, longitude: 151.18),
            .init(latitude: -33.89, longitude: 151.19),
        ],
        duration: 600,
        narrationPoints: [
            NarrationPoint(latitude: -33.85, longitude: 151.20, title: "Sydney Opera House", subtitle: "A UNESCO World Heritage masterpiece."),
            NarrationPoint(latitude: -33.84, longitude: 151.21, title: "Royal Botanic Garden", subtitle: "A green haven by the harbour."),
            NarrationPoint(latitude: -33.84, longitude: 151.19, title: "Sydney Harbour Bridge", subtitle: "The grand coat hanger of Sydney."),
            NarrationPoint(latitude: -33.86, longitude: 151.18, title: "Darling Harbour", subtitle: "A vibrant waterfront precinct."),
            NarrationPoint(latitude: -33.88, longitude: 151.18, title: "Chinatown", subtitle: "A cultural melting pot."),
        ]
    )

    static let rio = Route(
        title: "Rio de Janeiro",
        subtitle: "The marvelous city",
        category: .cities,
        coordinates: [
            .init(latitude: -22.90, longitude: -43.22),
            .init(latitude: -22.91, longitude: -43.21),
            .init(latitude: -22.92, longitude: -43.20),
            .init(latitude: -22.93, longitude: -43.19),
            .init(latitude: -22.94, longitude: -43.18),
            .init(latitude: -22.95, longitude: -43.17),
            .init(latitude: -22.96, longitude: -43.18),
            .init(latitude: -22.97, longitude: -43.19),
            .init(latitude: -22.98, longitude: -43.20),
            .init(latitude: -22.99, longitude: -43.21),
        ],
        duration: 600,
        narrationPoints: [
            NarrationPoint(latitude: -22.90, longitude: -43.22, title: "Sugarloaf Mountain", subtitle: "A granite peak rising from the sea."),
            NarrationPoint(latitude: -22.92, longitude: -43.20, title: "Copacabana", subtitle: "The world's most famous beach."),
            NarrationPoint(latitude: -22.94, longitude: -43.18, title: "Ipanema", subtitle: "Where the mountains meet the sea."),
            NarrationPoint(latitude: -22.97, longitude: -43.19, title: "Christ the Redeemer", subtitle: "Arms open wide over Rio."),
            NarrationPoint(latitude: -22.99, longitude: -43.21, title: "Tijuca Forest", subtitle: "The largest urban rainforest in the world."),
        ]
    )

    static let allRoutes: [Route] = [
        nile, amazon, mississippi, danube,
        transSiberian, californiaZephyr, orientExpress, theGhan, darjeelingHimalayan,
        tokyoLA, londonSingapore, newYorkLondon, sydneyAuckland, losAngelesTokyo,
        silkRoad, pacificCoast,
        greekIslands, hawaiianIslands, indonesianArchipelago, caribbeanChain, galapagos,
        himalayas, andes, alps, rockies, southernAlps,
        japanVolcanoes, kamchatka, alaskaVolcanoes, cascades, mexicoVolcanoes, andesVolcanoes, newZealandVolcanoes,
        sahara, namib, atacama, gobi, arabianDesert,
        greenland, antarcticPeninsula, northwestPassage, svalbard,
        london, paris, rome, istanbul, cairo,
        newYork, tokyo, dubai, hongKong, sydney, rio,
    ]

    static let defaultChannels: [Channel] = [
        Channel(name: "Rivers", icon: "water.waves", routes: [nile, amazon, mississippi, danube]),
        Channel(name: "Railways", icon: "train.side.front.car", routes: [transSiberian, californiaZephyr, orientExpress, theGhan, darjeelingHimalayan]),
        Channel(name: "Flights", icon: "airplane", routes: [tokyoLA, londonSingapore, newYorkLondon, sydneyAuckland, losAngelesTokyo]),
        Channel(name: "Ancient Routes", icon: "scroll", routes: [silkRoad]),
        Channel(name: "Coastlines", icon: "beach.umbrella", routes: [pacificCoast]),
        Channel(name: "Mountains", icon: "mountain.2", routes: [himalayas, andes, alps, rockies, southernAlps]),
        Channel(name: "Island Hopping", icon: "ferry", routes: [greekIslands, hawaiianIslands, indonesianArchipelago, caribbeanChain, galapagos]),
        Channel(name: "Ring of Fire", icon: "mountain.2.fill", routes: [japanVolcanoes, kamchatka, alaskaVolcanoes, cascades, mexicoVolcanoes, andesVolcanoes, newZealandVolcanoes]),
        Channel(name: "Deserts", icon: "sun.max", routes: [sahara, namib, atacama, gobi, arabianDesert]),
        Channel(name: "Polar Expeditions", icon: "snowflake", routes: [greenland, antarcticPeninsula, northwestPassage, svalbard]),
        Channel(name: "Great Cities from Above", icon: "building.2", routes: [london, paris, rome, istanbul, cairo, newYork, tokyo, dubai, hongKong, sydney, rio]),
    ]
}
