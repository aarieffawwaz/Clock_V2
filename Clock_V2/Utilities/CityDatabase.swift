import Foundation

struct CityInfo {
    let id: String           // timezone identifier (e.g., "Asia/Jakarta")
    let name: String         // city name (e.g., "Jakarta")
    let country: String      // country name (e.g., "Indonesia")
    let countryCode: String  // ISO 2-letter code (e.g., "ID")
}

struct CityDatabase {
    private static let CITY_DATABASE: [CityInfo] = [
        // Asia
        CityInfo(id: "Asia/Jakarta", name: "Jakarta", country: "Indonesia", countryCode: "ID"),
        CityInfo(id: "Asia/Tokyo", name: "Tokyo", country: "Japan", countryCode: "JP"),
        CityInfo(id: "Asia/Singapore", name: "Singapore", country: "Singapore", countryCode: "SG"),
        CityInfo(id: "Asia/Hong_Kong", name: "Hong Kong", country: "Hong Kong", countryCode: "HK"),
        CityInfo(id: "Asia/Bangkok", name: "Bangkok", country: "Thailand", countryCode: "TH"),
        CityInfo(id: "Asia/Kolkata", name: "Mumbai", country: "India", countryCode: "IN"),
        CityInfo(id: "Asia/Kolkata", name: "New Delhi", country: "India", countryCode: "IN"),
        CityInfo(id: "Asia/Dubai", name: "Dubai", country: "United Arab Emirates", countryCode: "AE"),
        CityInfo(id: "Asia/Shanghai", name: "Shanghai", country: "China", countryCode: "CN"),
        CityInfo(id: "Asia/Beijing", name: "Beijing", country: "China", countryCode: "CN"),
        CityInfo(id: "Asia/Seoul", name: "Seoul", country: "South Korea", countryCode: "KR"),
        CityInfo(id: "Asia/Ho_Chi_Minh", name: "Ho Chi Minh City", country: "Vietnam", countryCode: "VN"),
        CityInfo(id: "Asia/Manila", name: "Manila", country: "Philippines", countryCode: "PH"),
        CityInfo(id: "Asia/Kuala_Lumpur", name: "Kuala Lumpur", country: "Malaysia", countryCode: "MY"),
        CityInfo(id: "Asia/Hanoi", name: "Hanoi", country: "Vietnam", countryCode: "VN"),
        CityInfo(id: "Asia/Taipei", name: "Taipei", country: "Taiwan", countryCode: "TW"),
        CityInfo(id: "Asia/Tehran", name: "Tehran", country: "Iran", countryCode: "IR"),
        CityInfo(id: "Asia/Karachi", name: "Karachi", country: "Pakistan", countryCode: "PK"),
        CityInfo(id: "Asia/Dhaka", name: "Dhaka", country: "Bangladesh", countryCode: "BD"),
        CityInfo(id: "Asia/Bangkok", name: "Bangkok", country: "Thailand", countryCode: "TH"),
        
        // Europe
        CityInfo(id: "Europe/London", name: "London", country: "United Kingdom", countryCode: "GB"),
        CityInfo(id: "Europe/Paris", name: "Paris", country: "France", countryCode: "FR"),
        CityInfo(id: "Europe/Berlin", name: "Berlin", country: "Germany", countryCode: "DE"),
        CityInfo(id: "Europe/Moscow", name: "Moscow", country: "Russia", countryCode: "RU"),
        CityInfo(id: "Europe/Rome", name: "Rome", country: "Italy", countryCode: "IT"),
        CityInfo(id: "Europe/Madrid", name: "Madrid", country: "Spain", countryCode: "ES"),
        CityInfo(id: "Europe/Amsterdam", name: "Amsterdam", country: "Netherlands", countryCode: "NL"),
        CityInfo(id: "Europe/Brussels", name: "Brussels", country: "Belgium", countryCode: "BE"),
        CityInfo(id: "Europe/Vienna", name: "Vienna", country: "Austria", countryCode: "AT"),
        CityInfo(id: "Europe/Prague", name: "Prague", country: "Czech Republic", countryCode: "CZ"),
        CityInfo(id: "Europe/Warsaw", name: "Warsaw", country: "Poland", countryCode: "PL"),
        CityInfo(id: "Europe/Stockholm", name: "Stockholm", country: "Sweden", countryCode: "SE"),
        CityInfo(id: "Europe/Oslo", name: "Oslo", country: "Norway", countryCode: "NO"),
        CityInfo(id: "Europe/Copenhagen", name: "Copenhagen", country: "Denmark", countryCode: "DK"),
        CityInfo(id: "Europe/Lisbon", name: "Lisbon", country: "Portugal", countryCode: "PT"),
        CityInfo(id: "Europe/Istanbul", name: "Istanbul", country: "Turkey", countryCode: "TR"),
        CityInfo(id: "Europe/Athens", name: "Athens", country: "Greece", countryCode: "GR"),
        CityInfo(id: "Europe/Dublin", name: "Dublin", country: "Ireland", countryCode: "IE"),
        CityInfo(id: "Europe/Zurich", name: "Zurich", country: "Switzerland", countryCode: "CH"),
        CityInfo(id: "Europe/Budapest", name: "Budapest", country: "Hungary", countryCode: "HU"),
        
        // Americas
        CityInfo(id: "America/New_York", name: "New York", country: "United States", countryCode: "US"),
        CityInfo(id: "America/Los_Angeles", name: "Los Angeles", country: "United States", countryCode: "US"),
        CityInfo(id: "America/Chicago", name: "Chicago", country: "United States", countryCode: "US"),
        CityInfo(id: "America/Denver", name: "Denver", country: "United States", countryCode: "US"),
        CityInfo(id: "America/Anchorage", name: "Anchorage", country: "United States", countryCode: "US"),
        CityInfo(id: "Pacific/Honolulu", name: "Honolulu", country: "United States", countryCode: "US"),
        CityInfo(id: "America/Toronto", name: "Toronto", country: "Canada", countryCode: "CA"),
        CityInfo(id: "America/Vancouver", name: "Vancouver", country: "Canada", countryCode: "CA"),
        CityInfo(id: "America/Mexico_City", name: "Mexico City", country: "Mexico", countryCode: "MX"),
        CityInfo(id: "America/Sao_Paulo", name: "São Paulo", country: "Brazil", countryCode: "BR"),
        CityInfo(id: "America/Rio_Branco", name: "Rio de Janeiro", country: "Brazil", countryCode: "BR"),
        CityInfo(id: "America/Buenos_Aires", name: "Buenos Aires", country: "Argentina", countryCode: "AR"),
        CityInfo(id: "America/Bogota", name: "Bogotá", country: "Colombia", countryCode: "CO"),
        CityInfo(id: "America/Lima", name: "Lima", country: "Peru", countryCode: "PE"),
        CityInfo(id: "America/Santiago", name: "Santiago", country: "Chile", countryCode: "CL"),
        CityInfo(id: "America/Caracas", name: "Caracas", country: "Venezuela", countryCode: "VE"),
        
        // Africa
        CityInfo(id: "Africa/Cairo", name: "Cairo", country: "Egypt", countryCode: "EG"),
        CityInfo(id: "Africa/Lagos", name: "Lagos", country: "Nigeria", countryCode: "NG"),
        CityInfo(id: "Africa/Johannesburg", name: "Johannesburg", country: "South Africa", countryCode: "ZA"),
        CityInfo(id: "Africa/Nairobi", name: "Nairobi", country: "Kenya", countryCode: "KE"),
        CityInfo(id: "Africa/Casablanca", name: "Casablanca", country: "Morocco", countryCode: "MA"),
        CityInfo(id: "Africa/Algiers", name: "Algiers", country: "Algeria", countryCode: "DZ"),
        CityInfo(id: "Africa/Addis_Ababa", name: "Addis Ababa", country: "Ethiopia", countryCode: "ET"),
        CityInfo(id: "Africa/Dar_es_Salaam", name: "Dar es Salaam", country: "Tanzania", countryCode: "TZ"),
        CityInfo(id: "Africa/Kampala", name: "Kampala", country: "Uganda", countryCode: "UG"),
        CityInfo(id: "Africa/Khartoum", name: "Khartoum", country: "Sudan", countryCode: "SD"),
        
        // Oceania
        CityInfo(id: "Australia/Sydney", name: "Sydney", country: "Australia", countryCode: "AU"),
        CityInfo(id: "Australia/Melbourne", name: "Melbourne", country: "Australia", countryCode: "AU"),
        CityInfo(id: "Australia/Brisbane", name: "Brisbane", country: "Australia", countryCode: "AU"),
        CityInfo(id: "Australia/Perth", name: "Perth", country: "Australia", countryCode: "AU"),
        CityInfo(id: "Australia/Adelaide", name: "Adelaide", country: "Australia", countryCode: "AU"),
        CityInfo(id: "Pacific/Auckland", name: "Auckland", country: "New Zealand", countryCode: "NZ"),
        CityInfo(id: "Pacific/Fiji", name: "Fiji", country: "Fiji", countryCode: "FJ"),
        CityInfo(id: "Pacific/Pago_Pago", name: "Pago Pago", country: "American Samoa", countryCode: "AS"),
        
        // Middle East
        CityInfo(id: "Asia/Riyadh", name: "Riyadh", country: "Saudi Arabia", countryCode: "SA"),
        CityInfo(id: "Asia/Baghdad", name: "Baghdad", country: "Iraq", countryCode: "IQ"),
        CityInfo(id: "Asia/Beirut", name: "Beirut", country: "Lebanon", countryCode: "LB"),
        CityInfo(id: "Asia/Jerusalem", name: "Jerusalem", country: "Israel", countryCode: "IL"),
        CityInfo(id: "Asia/Amman", name: "Amman", country: "Jordan", countryCode: "JO"),
        CityInfo(id: "Asia/Qatar", name: "Doha", country: "Qatar", countryCode: "QA"),
        CityInfo(id: "Asia/Kuwait", name: "Kuwait", country: "Kuwait", countryCode: "KW"),
        CityInfo(id: "Asia/Bahrain", name: "Manama", country: "Bahrain", countryCode: "BH"),
        
        // Central Asia
        CityInfo(id: "Asia/Almaty", name: "Almaty", country: "Kazakhstan", countryCode: "KZ"),
        CityInfo(id: "Asia/Tashkent", name: "Tashkent", country: "Uzbekistan", countryCode: "UZ"),
    ]
    
    /// Returns all cities in the database, sorted by city name
    static func allCities() -> [CityInfo] {
        return CITY_DATABASE.sorted { $0.name < $1.name }
    }
    
    /// Searches cities by name, country, timezone identifier, or GMT offset (case-insensitive)
    /// - Parameter query: Search string (empty string returns all cities)
    /// - Returns: Array of matching cities, sorted by city name
    static func searchCities(query: String) -> [CityInfo] {
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            return allCities()
        }
        
        let lowercaseQuery = query.lowercased()
        let normalizedQuery = lowercaseQuery.replacingOccurrences(of: " ", with: "")
        
        return CITY_DATABASE.filter { city in
            let offset = TimezoneHelper.getTimezoneOffset(timezoneID: city.id).lowercased()
            let normalizedOffset = offset.replacingOccurrences(of: " ", with: "")
            
            return city.name.lowercased().contains(lowercaseQuery) ||
            city.country.lowercased().contains(lowercaseQuery) ||
            city.id.lowercased().contains(lowercaseQuery) ||
            normalizedOffset.contains(normalizedQuery)
        }.sorted { $0.name < $1.name }
    }
}
