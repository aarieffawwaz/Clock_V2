import SwiftUI

enum WorkingHourStatus {
    case goodHours      // 9am-5pm → Happy
    case soSoHours      // 7am-9am, 5pm-7pm → Mid
    case offHours       // Outside of above → Sad
}

struct TimezoneHelper {
    
    /// Given a base time and a timezone identifier, return the Date object representing that time in the specified timezone
    static func getTimeInTimezone(baseTime: Date, timezoneID: String) -> Date {
        // A Date object is an absolute point in time. 
        // We only need to use a Calendar with the target TimeZone to extract components.
        // This helper is used in ShareFormatter to extract strings for that city.
        return baseTime
    }
    
    /// Given a time and timezone ID, extract the hour of day in that timezone and return the working hour status
    static func getWorkingHourStatus(time: Date, timezoneID: String) -> WorkingHourStatus {
        let timeZone = TimeZone(identifier: timezoneID) ?? TimeZone.current
        var calendar = Calendar.current
        calendar.timeZone = timeZone
        
        let components = calendar.dateComponents([.hour], from: time)
        let hour = components.hour ?? 0
        
        if hour >= 9 && hour < 17 {
            return .goodHours      // 9am-4:59pm (hours 9-16)
        } else if (hour >= 7 && hour < 9) || (hour >= 17 && hour < 19) {
            return .soSoHours      // 7-8am (hours 7-8) or 5-6pm (hours 17-18)
        } else {
            return .offHours       // All other hours
        }
    }
    
    /// Return a color based on the working hour status
    static func getWorkingHourColor(status: WorkingHourStatus) -> Color {
        switch status {
        case .goodHours:
            return .green
        case .soSoHours:
            return .yellow
        case .offHours:
            return .red
        }
    }
    
    /// Given a 2-letter ISO country code, generate a Unicode flag emoji
    static func generateFlagEmoji(countryCode: String) -> String {
        let code = countryCode.uppercased()
        guard code.count == 2 else { return "🌍" }
        
        let regionalIndicatorA: UInt32 = 0x1F1E6  // 🇦
        let codePointA: UInt32 = 65  // ASCII for "A"
        
        var result = ""
        for char in code {
            guard let asciiScalar = char.asciiValue else { return "🌍" }
            let regionIndicator = regionalIndicatorA + UInt32(asciiScalar) - codePointA
            if let scalar = UnicodeScalar(regionIndicator) {
                result.append(Character(scalar))
            } else {
                return "🌍"
            }
        }
        
        return result
    }
    
    /// Given a timezone ID, return a formatted string like "GMT+8", "GMT-5", "UTC+0"
    static func getTimezoneOffset(timezoneID: String) -> String {
        guard let timeZone = TimeZone(identifier: timezoneID) else {
            return "UTC+0"
        }
        
        let secondsFromGMT = timeZone.secondsFromGMT()
        let hours = secondsFromGMT / 3600
        
        if hours >= 0 {
            return "GMT+\(hours)"
        } else {
            return "GMT\(hours)"
        }
    }
    
    /// Return a dynamic gradient for the 24-hour slider based on the availability of all selected cities.
    /// Priority: Off Hours (Red) > So-So Hours (Yellow) > Good Hours (Green)
    static func dynamicSliderGradient(cities: [City]) -> LinearGradient {
        guard !cities.isEmpty else {
            // Default gradient if no cities are selected
            return sliderColorGradient()
        }
        
        var stops: [Gradient.Stop] = []
        let calendar = Calendar.current
        let todayMidnight = calendar.startOfDay(for: Date())
        
        // Sample every 30 minutes for a smooth but performant gradient (48 samples)
        for minutes in stride(from: 0, through: 1440, by: 30) {
            let timeAtPoint = calendar.date(byAdding: .minute, value: minutes, to: todayMidnight) ?? todayMidnight
            
            // Find the "worst" status among all cities at this time point
            var worstStatus: WorkingHourStatus = .goodHours
            
            for city in cities {
                let status = getWorkingHourStatus(time: timeAtPoint, timezoneID: city.id)
                if status == .offHours {
                    worstStatus = .offHours
                    break // Red is the highest priority, no need to check further
                } else if status == .soSoHours {
                    worstStatus = .soSoHours
                }
            }
            
            stops.append(.init(color: getWorkingHourColor(status: worstStatus), location: Double(minutes) / 1440.0))
        }
        
        return LinearGradient(
            gradient: Gradient(stops: stops),
            startPoint: .leading,
            endPoint: .trailing
        )
    }
    
    /// Return a gradient for the 24-hour slider showing working hours
    static func sliderColorGradient() -> LinearGradient {
        return LinearGradient(
            gradient: Gradient(stops: [
                .init(color: .red, location: 0.0),           // 0:00
                .init(color: .red, location: 7.0/24.0),     // 7:00 (End of Red)
                .init(color: .yellow, location: 7.0/24.0),  // 7:00 (Start of Yellow)
                .init(color: .yellow, location: 9.0/24.0),  // 9:00 (End of Yellow)
                .init(color: .green, location: 9.0/24.0),   // 9:00 (Start of Green)
                .init(color: .green, location: 17.0/24.0),  // 17:00 (End of Green)
                .init(color: .yellow, location: 17.0/24.0), // 17:00 (Start of Yellow)
                .init(color: .yellow, location: 19.0/24.0), // 19:00 (End of Yellow)
                .init(color: .red, location: 19.0/24.0),    // 19:00 (Start of Red)
                .init(color: .red, location: 1.0)           // 24:00
            ]),
            startPoint: .leading,
            endPoint: .trailing
        )
    }
}
