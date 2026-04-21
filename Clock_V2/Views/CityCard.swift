//
//  CityCard.swift
//  Clock_V2
//
//  Created by Copilot on 21/04/26.
//

import SwiftUI

struct CityCard: View {
    let cityName: String
    let countryCode: String
    let timezoneID: String
    let displayTime: Date
    
    var body: some View {
        HStack(spacing: 16) {
            // Left: Country flag emoji
            Text(TimezoneHelper.generateFlagEmoji(countryCode: countryCode))
                .font(.system(size: 32))
            
            // Middle: City Name and Timezone offset
            VStack(alignment: .leading, spacing: 2) {
                Text(cityName)
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(.primary)
                
                Text("\(timezoneID.components(separatedBy: "/").last?.replacingOccurrences(of: "_", with: " ") ?? timezoneID) (\(TimezoneHelper.getTimezoneOffset(timezoneID: timezoneID)))")
                    .font(.system(size: 13))
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            // Right: Large formatted time
            Text(formatTime(displayTime))
                .font(.system(size: 22, weight: .semibold, design: .default))
                .monospacedDigit()
            
            // Far Right: Status image
            statusImage(for: TimezoneHelper.getWorkingHourStatus(time: displayTime, timezoneID: timezoneID))
                .resizable()
                .scaledToFit()
                .frame(width: 32, height: 32)
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background(Color(.secondarySystemGroupedBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
    }
    
    private func formatTime(_ date: Date) -> String {
        let timeZone = TimeZone(identifier: timezoneID) ?? TimeZone.current
        var calendar = Calendar.current
        calendar.timeZone = timeZone
        
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.timeStyle = .short
        
        return formatter.string(from: date)
    }
    
    private func statusImage(for status: WorkingHourStatus) -> Image {
        switch status {
        case .goodHours:
            return Image("Happy")
        case .soSoHours:
            return Image("Mid")
        case .offHours:
            return Image("Sad")
        }
    }
    
    private func statusLabel(for status: WorkingHourStatus) -> String {
        switch status {
        case .goodHours:
            return "Good Hours"
        case .soSoHours:
            return "So-So Hours"
        case .offHours:
            return "Off Hours"
        }
    }
}

#Preview {
    VStack(spacing: 16) {
        CityCard(
            cityName: "Jakarta",
            countryCode: "ID",
            timezoneID: "Asia/Jakarta",
            displayTime: {
                var components = DateComponents()
                components.hour = 15
                components.minute = 35
                components.second = 0
                return Calendar.current.date(from: components) ?? Date()
            }()
        )
        
        CityCard(
            cityName: "Los Angeles",
            countryCode: "US",
            timezoneID: "America/Los_Angeles",
            displayTime: {
                var components = DateComponents()
                components.hour = 2
                components.minute = 30
                components.second = 0
                return Calendar.current.date(from: components) ?? Date()
            }()
        )
        
        CityCard(
            cityName: "London",
            countryCode: "GB",
            timezoneID: "Europe/London",
            displayTime: {
                var components = DateComponents()
                components.hour = 10
                components.minute = 15
                components.second = 0
                return Calendar.current.date(from: components) ?? Date()
            }()
        )
        
        Spacer()
    }
    .padding()
}
