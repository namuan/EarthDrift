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

    static let allRoutes: [Route] = [
        nile, amazon, mississippi, danube,
        transSiberian, californiaZephyr,
        tokyoLA, londonSingapore,
        silkRoad, pacificCoast,
        greekIslands, hawaiianIslands, indonesianArchipelago, caribbeanChain, galapagos,
    ]

    static let defaultChannels: [Channel] = [
        Channel(name: "Rivers", icon: "water.waves", routes: [nile, amazon, mississippi, danube]),
        Channel(name: "Railways", icon: "train.side.front.car", routes: [transSiberian, californiaZephyr]),
        Channel(name: "Flights", icon: "airplane", routes: [tokyoLA, londonSingapore]),
        Channel(name: "Ancient Routes", icon: "scroll", routes: [silkRoad]),
        Channel(name: "Coastlines", icon: "beach.umbrella", routes: [pacificCoast]),
        Channel(name: "Island Hopping", icon: "ferry", routes: [greekIslands, hawaiianIslands, indonesianArchipelago, caribbeanChain, galapagos]),
    ]
}
