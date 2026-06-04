import CoreLocation

enum InterestingLocations {
    static let locations: [(name: String, coordinate: CLLocationCoordinate2D, altitude: Double)] = [
        ("Mount Everest",        CLLocationCoordinate2D(latitude: 27.9881, longitude: 86.9250), 8000),
        ("Grand Canyon",         CLLocationCoordinate2D(latitude: 36.1069, longitude: -112.1129), 6000),
        ("Maldives",             CLLocationCoordinate2D(latitude: 3.2028, longitude: 73.2207), 4000),
        ("Machu Picchu",         CLLocationCoordinate2D(latitude: -13.1631, longitude: -72.5450), 8000),
        ("Pyramids of Giza",     CLLocationCoordinate2D(latitude: 29.9792, longitude: 31.1342), 2000),
        ("Iceland",              CLLocationCoordinate2D(latitude: 64.9631, longitude: -19.0208), 15000),
        ("Great Wall",           CLLocationCoordinate2D(latitude: 40.4319, longitude: 116.5704), 5000),
        ("Santorini",            CLLocationCoordinate2D(latitude: 36.3932, longitude: 25.4615), 4000),
        ("Mount Fuji",           CLLocationCoordinate2D(latitude: 35.3606, longitude: 138.7274), 10000),
        ("Sahara Desert",        CLLocationCoordinate2D(latitude: 23.4162, longitude: 25.6628), 20000),
        ("Venice",               CLLocationCoordinate2D(latitude: 45.4408, longitude: 12.3155), 2000),
        ("Yosemite",             CLLocationCoordinate2D(latitude: 37.8651, longitude: -119.5383), 7000),
        ("Petra",                CLLocationCoordinate2D(latitude: 30.3285, longitude: 35.4444), 4000),
        ("Kilimanjaro",          CLLocationCoordinate2D(latitude: -3.0674, longitude: 37.3556), 12000),
        ("Bora Bora",            CLLocationCoordinate2D(latitude: -16.5004, longitude: -151.7415), 4000),
        ("Taj Mahal",            CLLocationCoordinate2D(latitude: 27.1751, longitude: 78.0421), 3000),
        ("Meteora",              CLLocationCoordinate2D(latitude: 39.7217, longitude: 21.6306), 4000),
        ("Niagara Falls",        CLLocationCoordinate2D(latitude: 43.0799, longitude: -79.0747), 3000),
        ("Banff",                CLLocationCoordinate2D(latitude: 51.1784, longitude: -115.5708), 8000),
        ("Uluru",                CLLocationCoordinate2D(latitude: -25.3444, longitude: 131.0369), 6000),
        ("Cappadocia",           CLLocationCoordinate2D(latitude: 38.6431, longitude: 34.8283), 5000),
        ("Cape Town",            CLLocationCoordinate2D(latitude: -33.9249, longitude: 18.4241), 8000),
        ("Ha Long Bay",          CLLocationCoordinate2D(latitude: 20.9101, longitude: 107.1839), 4000),
        ("Matterhorn",           CLLocationCoordinate2D(latitude: 45.9766, longitude: 7.6585), 8000),
        ("Great Barrier Reef",   CLLocationCoordinate2D(latitude: -18.2871, longitude: 147.6992), 6000),
        ("Amazon Rainforest",    CLLocationCoordinate2D(latitude: -3.4653, longitude: -62.2159), 20000),
        ("Mount Rushmore",       CLLocationCoordinate2D(latitude: 43.8791, longitude: -103.4591), 5000),
        ("Plitvice Lakes",       CLLocationCoordinate2D(latitude: 44.8654, longitude: 15.5820), 4000),
        ("Stonehenge",           CLLocationCoordinate2D(latitude: 51.1789, longitude: -1.8262), 2000),
        ("Angkor Wat",           CLLocationCoordinate2D(latitude: 13.4125, longitude: 103.8670), 4000),
        ("Galapagos Islands",    CLLocationCoordinate2D(latitude: -0.8292, longitude: -90.3922), 10000),
        ("Antarctica",           CLLocationCoordinate2D(latitude: -77.8460, longitude: 166.6680), 20000),
        ("Dubai",                CLLocationCoordinate2D(latitude: 25.1972, longitude: 55.2744), 3000),
        ("Patagonia",            CLLocationCoordinate2D(latitude: -49.3, longitude: -73.0), 15000),
        ("Himalayas",            CLLocationCoordinate2D(latitude: 28.0, longitude: 85.0), 20000),
        ("Rio de Janeiro",       CLLocationCoordinate2D(latitude: -22.9068, longitude: -43.1729), 4000),
        ("Hawaii",               CLLocationCoordinate2D(latitude: 20.7967, longitude: -156.3319), 8000),
        ("Kyoto",               CLLocationCoordinate2D(latitude: 35.0116, longitude: 135.7681), 3000),
    ]

    static func random() -> (name: String, coordinate: CLLocationCoordinate2D, altitude: Double) {
        locations.randomElement()!
    }
}
