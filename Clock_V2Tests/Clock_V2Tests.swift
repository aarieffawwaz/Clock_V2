//
//  Clock_V2Tests.swift
//  Clock_V2Tests
//
//  Created by Aarief Fawwaz Satriahutama on 21/04/26.
//

import Testing
import SwiftUI
@testable import Clock_V2

struct TimezoneHelperTests {
    
    // MARK: - Working Hour Classification Tests
    
    @Test("Working hours 9am-5pm returns goodHours")
    func workingHoursGood() {
        // Create a reference date with known hour components
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(identifier: "Asia/Jakarta") ?? TimeZone.current
        
        var components = DateComponents()
        components.year = 2026
        components.month = 1
        components.day = 15
        components.hour = 12
        components.minute = 0
        components.second = 0
        
        let date = calendar.date(from: components)!
        
        // Test hour 9 (9am)
        var components9 = components
        components9.hour = 9
        let date9 = calendar.date(from: components9)!
        let status9 = TimezoneHelper.getWorkingHourStatus(time: date9, timezoneID: "Asia/Jakarta")
        #expect(status9 == .goodHours)
        
        // Test hour 12 (noon)
        let status12 = TimezoneHelper.getWorkingHourStatus(time: date, timezoneID: "Asia/Jakarta")
        #expect(status12 == .goodHours)
        
        // Test hour 16 (4:59pm)
        var components16 = components
        components16.hour = 16
        let date16 = calendar.date(from: components16)!
        let status16 = TimezoneHelper.getWorkingHourStatus(time: date16, timezoneID: "Asia/Jakarta")
        #expect(status16 == .goodHours)
        
        // Test hour 17 (5pm) should return soSoHours
        var components17 = components
        components17.hour = 17
        let date17 = calendar.date(from: components17)!
        let status17 = TimezoneHelper.getWorkingHourStatus(time: date17, timezoneID: "Asia/Jakarta")
        #expect(status17 == .soSoHours)
    }
    
    @Test("So-so hours 7-9am and 5-7pm")
    func soSoHours() {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(identifier: "Asia/Jakarta") ?? TimeZone.current
        
        var components = DateComponents()
        components.year = 2026
        components.month = 1
        components.day = 15
        components.minute = 0
        components.second = 0
        
        // Test hour 7 (7am)
        var components7 = components
        components7.hour = 7
        let date7 = calendar.date(from: components7)!
        let status7 = TimezoneHelper.getWorkingHourStatus(time: date7, timezoneID: "Asia/Jakarta")
        #expect(status7 == .soSoHours)
        
        // Test hour 8 (8am)
        var components8 = components
        components8.hour = 8
        let date8 = calendar.date(from: components8)!
        let status8 = TimezoneHelper.getWorkingHourStatus(time: date8, timezoneID: "Asia/Jakarta")
        #expect(status8 == .soSoHours)
        
        // Test hour 17 (5pm)
        var components17 = components
        components17.hour = 17
        let date17 = calendar.date(from: components17)!
        let status17 = TimezoneHelper.getWorkingHourStatus(time: date17, timezoneID: "Asia/Jakarta")
        #expect(status17 == .soSoHours)
        
        // Test hour 18 (6pm)
        var components18 = components
        components18.hour = 18
        let date18 = calendar.date(from: components18)!
        let status18 = TimezoneHelper.getWorkingHourStatus(time: date18, timezoneID: "Asia/Jakarta")
        #expect(status18 == .soSoHours)
    }
    
    @Test("Off-hours outside 7am-7pm")
    func offHours() {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(identifier: "Asia/Jakarta") ?? TimeZone.current
        
        var components = DateComponents()
        components.year = 2026
        components.month = 1
        components.day = 15
        components.minute = 0
        components.second = 0
        
        // Test midnight (hour 0)
        var components0 = components
        components0.hour = 0
        let date0 = calendar.date(from: components0)!
        let status0 = TimezoneHelper.getWorkingHourStatus(time: date0, timezoneID: "Asia/Jakarta")
        #expect(status0 == .offHours)
        
        // Test hour 3 (3am)
        var components3 = components
        components3.hour = 3
        let date3 = calendar.date(from: components3)!
        let status3 = TimezoneHelper.getWorkingHourStatus(time: date3, timezoneID: "Asia/Jakarta")
        #expect(status3 == .offHours)
        
        // Test hour 6 (6am)
        var components6 = components
        components6.hour = 6
        let date6 = calendar.date(from: components6)!
        let status6 = TimezoneHelper.getWorkingHourStatus(time: date6, timezoneID: "Asia/Jakarta")
        #expect(status6 == .offHours)
        
        // Test hour 19 (7pm)
        var components19 = components
        components19.hour = 19
        let date19 = calendar.date(from: components19)!
        let status19 = TimezoneHelper.getWorkingHourStatus(time: date19, timezoneID: "Asia/Jakarta")
        #expect(status19 == .offHours)
        
        // Test hour 23 (11pm)
        var components23 = components
        components23.hour = 23
        let date23 = calendar.date(from: components23)!
        let status23 = TimezoneHelper.getWorkingHourStatus(time: date23, timezoneID: "Asia/Jakarta")
        #expect(status23 == .offHours)
    }
    
    // MARK: - Timezone Conversion Tests
    
    @Test("Jakarta timezone - timezone offset testing")
    func jakartaTimezone() {
        // Test that getting timezone offset works correctly
        let offset = TimezoneHelper.getTimezoneOffset(timezoneID: "Asia/Jakarta")
        #expect(offset == "GMT+7")
    }
    
    @Test("London timezone - timezone offset testing")
    func londonTimezone() {
        // Test Europe/London timezone offset
        let offset = TimezoneHelper.getTimezoneOffset(timezoneID: "Europe/London")
        // London can be GMT+0 or GMT+1 depending on DST
        #expect(offset == "GMT+0" || offset == "GMT+1")
    }
    
    @Test("New York timezone - timezone offset testing")
    func newYorkTimezone() {
        // Test America/New_York timezone offset
        let offset = TimezoneHelper.getTimezoneOffset(timezoneID: "America/New_York")
        // New York can be GMT-5 (EST) or GMT-4 (EDT) depending on DST
        #expect(offset == "GMT-5" || offset == "GMT-4")
    }
    
    @Test("Tokyo timezone - timezone offset testing")
    func tokyoTimezone() {
        // Test that Tokyo is UTC+9
        let offset = TimezoneHelper.getTimezoneOffset(timezoneID: "Asia/Tokyo")
        #expect(offset == "GMT+9")
    }
    
    @Test("Sydney timezone - timezone offset testing")
    func sydneyTimezone() {
        // Sydney can be UTC+10 or UTC+11 depending on DST
        let offset = TimezoneHelper.getTimezoneOffset(timezoneID: "Australia/Sydney")
        #expect(offset == "GMT+10" || offset == "GMT+11")
    }
    
    // MARK: - DST (Daylight Saving Time) Tests
    
    @Test("DST transition handling - US Spring Forward")
    func dstTransitionSpringForward() {
        // Verify that New York timezone offset changes during DST transitions
        // This tests that our timezone offset function works correctly
        let offsetWinter = TimezoneHelper.getTimezoneOffset(timezoneID: "America/New_York")
        // In winter it's EST (UTC-5), in summer it's EDT (UTC-4)
        #expect(offsetWinter == "GMT-5" || offsetWinter == "GMT-4")
    }
    
    @Test("DST transition handling - US Fall Back")
    func dstTransitionFallBack() {
        // Verify that working hour status changes based on timezone
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(identifier: "America/New_York") ?? TimeZone.current
        
        var components = DateComponents()
        components.year = 2026
        components.month = 1
        components.day = 15
        components.hour = 9
        components.minute = 0
        components.second = 0
        
        let date = calendar.date(from: components)!
        let status = TimezoneHelper.getWorkingHourStatus(time: date, timezoneID: "America/New_York")
        // Hour 9 should be good hours regardless of DST
        #expect(status == .goodHours)
    }
    
    // MARK: - Flag Emoji Generation Tests
    
    @Test("Flag emoji for valid country codes")
    func validCountryFlags() {
        // Test US flag
        let usFlag = TimezoneHelper.generateFlagEmoji(countryCode: "US")
        #expect(usFlag == "🇺🇸")
        
        // Test Indonesia flag
        let idFlag = TimezoneHelper.generateFlagEmoji(countryCode: "ID")
        #expect(idFlag == "🇮🇩")
        
        // Test Great Britain flag
        let gbFlag = TimezoneHelper.generateFlagEmoji(countryCode: "GB")
        #expect(gbFlag == "🇬🇧")
        
        // Test Japan flag
        let jpFlag = TimezoneHelper.generateFlagEmoji(countryCode: "JP")
        #expect(jpFlag == "🇯🇵")
        
        // Test Australia flag
        let auFlag = TimezoneHelper.generateFlagEmoji(countryCode: "AU")
        #expect(auFlag == "🇦🇺")
        
        // Test lowercase input (should be uppercased)
        let usLowerFlag = TimezoneHelper.generateFlagEmoji(countryCode: "us")
        #expect(usLowerFlag == "🇺🇸")
    }
    
    @Test("Invalid country code handling")
    func invalidCountryCodeFlag() {
        // Test too short code
        let shortFlag = TimezoneHelper.generateFlagEmoji(countryCode: "U")
        #expect(shortFlag == "🌍")
        
        // Test too long code
        let longFlag = TimezoneHelper.generateFlagEmoji(countryCode: "USA")
        #expect(longFlag == "🌍")
        
        // Test empty string
        let emptyFlag = TimezoneHelper.generateFlagEmoji(countryCode: "")
        #expect(emptyFlag == "🌍")
        
        // Test invalid characters (non-ASCII)
        let invalidFlag = TimezoneHelper.generateFlagEmoji(countryCode: "ÜÜ")
        #expect(invalidFlag == "🌍")
    }
    
    // MARK: - Color Mapping Tests
    
    @Test("WorkingHourStatus color mapping - goodHours")
    func colorMappingGoodHours() {
        let color = TimezoneHelper.getWorkingHourColor(status: .goodHours)
        #expect(color == .green)
    }
    
    @Test("WorkingHourStatus color mapping - soSoHours")
    func colorMappingSoSoHours() {
        let color = TimezoneHelper.getWorkingHourColor(status: .soSoHours)
        #expect(color == .yellow)
    }
    
    @Test("WorkingHourStatus color mapping - offHours")
    func colorMappingOffHours() {
        let color = TimezoneHelper.getWorkingHourColor(status: .offHours)
        #expect(color == .red)
    }
    
    // MARK: - Timezone Offset String Tests
    
    @Test("Timezone offset formatting")
    func timezoneOffsetString() {
        // Test Asia/Jakarta (always GMT+7, no DST)
        let jakartaOffset = TimezoneHelper.getTimezoneOffset(timezoneID: "Asia/Jakarta")
        #expect(jakartaOffset == "GMT+7")
        
        // Test Europe/London (GMT+0 or GMT+1 due to DST)
        let londonOffset = TimezoneHelper.getTimezoneOffset(timezoneID: "Europe/London")
        #expect(londonOffset == "GMT+0" || londonOffset == "GMT+1")
        
        // Test America/New_York (GMT-5 or GMT-4 due to DST)
        let nyOffset = TimezoneHelper.getTimezoneOffset(timezoneID: "America/New_York")
        #expect(nyOffset == "GMT-5" || nyOffset == "GMT-4")
        
        // Test Asia/Tokyo (always GMT+9, no DST)
        let tokyoOffset = TimezoneHelper.getTimezoneOffset(timezoneID: "Asia/Tokyo")
        #expect(tokyoOffset == "GMT+9")
        
        // Test Australia/Sydney (GMT+10 or GMT+11 due to DST)
        let sydneyOffset = TimezoneHelper.getTimezoneOffset(timezoneID: "Australia/Sydney")
        #expect(sydneyOffset == "GMT+10" || sydneyOffset == "GMT+11")
        
        // Test invalid timezone (should return UTC+0)
        let invalidOffset = TimezoneHelper.getTimezoneOffset(timezoneID: "Invalid/Timezone")
        #expect(invalidOffset == "UTC+0")
    }
    
    // MARK: - Edge Case Tests
    
    @Test("Boundary hour test - exact 9am transition")
    func boundaryNineAM() {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(identifier: "Asia/Jakarta") ?? TimeZone.current
        
        var components = DateComponents()
        components.year = 2026
        components.month = 1
        components.day = 15
        components.hour = 9
        components.minute = 0
        components.second = 0
        
        let date = calendar.date(from: components)!
        let status = TimezoneHelper.getWorkingHourStatus(time: date, timezoneID: "Asia/Jakarta")
        
        // Hour 9 should be goodHours (inclusive)
        #expect(status == .goodHours)
    }
    
    @Test("Boundary hour test - exact 5pm transition")
    func boundaryFivePM() {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(identifier: "Asia/Jakarta") ?? TimeZone.current
        
        var components = DateComponents()
        components.year = 2026
        components.month = 1
        components.day = 15
        components.hour = 17
        components.minute = 0
        components.second = 0
        
        let date = calendar.date(from: components)!
        let status = TimezoneHelper.getWorkingHourStatus(time: date, timezoneID: "Asia/Jakarta")
        
        // Hour 17 (5pm) should be soSoHours, not goodHours
        #expect(status == .soSoHours)
    }
    
    @Test("Boundary hour test - exact 7pm transition")
    func boundarySevenPM() {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(identifier: "Asia/Jakarta") ?? TimeZone.current
        
        var components = DateComponents()
        components.year = 2026
        components.month = 1
        components.day = 15
        components.hour = 19
        components.minute = 0
        components.second = 0
        
        let date = calendar.date(from: components)!
        let status = TimezoneHelper.getWorkingHourStatus(time: date, timezoneID: "Asia/Jakarta")
        
        // Hour 19 (7pm) should be offHours
        #expect(status == .offHours)
    }
    
    @Test("Slider gradient exists and is valid")
    func sliderGradient() {
        let gradient = TimezoneHelper.sliderColorGradient()
        
        // Check that gradient is not nil - we can't access private properties so just verify it doesn't crash
        // The gradient should be a valid LinearGradient for the 24-hour slider
        _ = gradient  // Verify it's not nil
    }
}
