import Foundation

struct ShareFormatter {
    
    /// Generate a human-readable text snapshot of all selected cities at a given time
    /// 
    /// Example output:
    /// ```
    /// It's Thursday, 21 April 2026 at 15:35 (GMT+7).
    /// That's:
    /// - 09:35 London 🇬🇧 (good hours ✓)
    /// - 15:35 Jakarta 🇮🇩 (good hours ✓)
    /// - 23:35 Tokyo 🇯🇵 (off-hours ✗)
    /// - 10:35 New York 🇺🇸 (so-so hours ⚠)
    /// ```
    static func formatCitiesSnapshot(cities: [City], adjustedDate: Date) -> String {
        guard !cities.isEmpty else {
            return "No cities selected"
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, d MMMM yyyy"
        let dateString = dateFormatter.string(from: adjustedDate)
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        let timeString = timeFormatter.string(from: adjustedDate)
        
        let baseTZOffset = TimezoneHelper.getTimezoneOffset(timezoneID: TimeZone.current.identifier)
        let headerLine = "It's \(dateString) at \(timeString) (\(baseTZOffset))."
        
        var lines = [headerLine, "That's:"]
        
        for city in cities.sorted(by: { $0.id < $1.id }) {
            let targetTimeZone = TimeZone(identifier: city.id) ?? TimeZone.current
            timeFormatter.timeZone = targetTimeZone
            let timeStr = timeFormatter.string(from: adjustedDate)
            
            let status = TimezoneHelper.getWorkingHourStatus(time: adjustedDate, timezoneID: city.id)
            let (emoji, statusText) = statusEmoji(status)
            
            let flag = TimezoneHelper.generateFlagEmoji(countryCode: city.countryCode)
            let line = "- \(timeStr) \(city.name) \(flag) (\(statusText) \(emoji))"
            lines.append(line)
        }
        
        return lines.joined(separator: "\n")
    }
    
    /// Shorter version for quick sharing (single line or compact format)
    /// 
    /// Example output:
    /// ```
    /// Jakarta 🇮🇩 15:35 ✓ | London 🇬🇧 09:35 ✗ | Tokyo 🇯🇵 23:35 ✗
    /// ```
    static func formatCitiesSummary(cities: [City], adjustedDate: Date) -> String {
        guard !cities.isEmpty else {
            return "No cities"
        }
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        
        let summaryParts = cities.sorted(by: { $0.id < $1.id }).map { city -> String in
            let targetTimeZone = TimeZone(identifier: city.id) ?? TimeZone.current
            timeFormatter.timeZone = targetTimeZone
            let timeStr = timeFormatter.string(from: adjustedDate)
            
            let status = TimezoneHelper.getWorkingHourStatus(time: adjustedDate, timezoneID: city.id)
            let (emoji, _) = statusEmoji(status)
            
            let flag = TimezoneHelper.generateFlagEmoji(countryCode: city.countryCode)
            return "\(city.name) \(flag) \(timeStr) \(emoji)"
        }
        
        return summaryParts.joined(separator: " | ")
    }
    
    /// Generate text optimized for copy-to-clipboard (detailed but compact)
    /// 
    /// Example output:
    /// ```
    /// Timezone Snapshot - Thursday, 21 April 2026 15:35 (GMT+7)
    /// Jakarta 🇮🇩 15:35 GMT+7 ✓
    /// London 🇬🇧 09:35 GMT+1 ✗
    /// Tokyo 🇯🇵 23:35 GMT+9 ✗
    /// New York 🇺🇸 10:35 GMT-4 ⚠
    /// ```
    static func copyableText(cities: [City], adjustedDate: Date) -> String {
        guard !cities.isEmpty else {
            return "Timezone Snapshot - No cities selected"
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, d MMMM yyyy"
        let dateString = dateFormatter.string(from: adjustedDate)
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        let timeString = timeFormatter.string(from: adjustedDate)
        
        let baseTZOffset = TimezoneHelper.getTimezoneOffset(timezoneID: TimeZone.current.identifier)
        let headerLine = "Timezone Snapshot - \(dateString) \(timeString) (\(baseTZOffset))"
        
        var lines = [headerLine]
        
        for city in cities.sorted(by: { $0.id < $1.id }) {
            let targetTimeZone = TimeZone(identifier: city.id) ?? TimeZone.current
            timeFormatter.timeZone = targetTimeZone
            let timeStr = timeFormatter.string(from: adjustedDate)
            
            let status = TimezoneHelper.getWorkingHourStatus(time: adjustedDate, timezoneID: city.id)
            let (emoji, _) = statusEmoji(status)
            
            let flag = TimezoneHelper.generateFlagEmoji(countryCode: city.countryCode)
            let tzOffset = TimezoneHelper.getTimezoneOffset(timezoneID: city.id)
            
            let line = "\(city.name) \(flag) \(timeStr) \(tzOffset) \(emoji)"
            lines.append(line)
        }
        
        return lines.joined(separator: "\n")
    }
    
    private static func statusEmoji(_ status: WorkingHourStatus) -> (emoji: String, text: String) {
        switch status {
        case .goodHours:
            return ("✓", "good hours")
        case .soSoHours:
            return ("⚠", "so-so hours")
        case .offHours:
            return ("✗", "off-hours")
        }
    }
}
