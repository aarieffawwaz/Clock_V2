//
//  TimeSlider.swift
//  Clock_V2
//
//  Created by Aarief Fawwaz Satriahutama on 21/04/26.
//

import SwiftUI

struct TimeSlider: View {
    @Binding var minutesSinceMidnight: Int
    let baseDate: Date
    let cities: [City]
    
    private var displayDate: Date {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day], from: baseDate)
        components.hour = minutesSinceMidnight / 60
        components.minute = minutesSinceMidnight % 60
        return calendar.date(from: components) ?? baseDate
    }
    
    private var timeString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: displayDate)
    }
    
    private var adjustmentString: String {
        let now = Date()
        let nowMinutes = Calendar.current.dateComponents([.hour, .minute], from: now)
        let nowTotalMinutes = (nowMinutes.hour ?? 0) * 60 + (nowMinutes.minute ?? 0)
        
        let adjustmentMinutes = minutesSinceMidnight - nowTotalMinutes
        
        if adjustmentMinutes == 0 {
            return "(now)"
        }
        
        let absAdjustment = abs(adjustmentMinutes)
        let hours = absAdjustment / 60
        let mins = absAdjustment % 60
        let sign = adjustmentMinutes > 0 ? "+" : "-"
        
        if hours == 0 {
            return "(\(sign)\(mins)m)"
        } else if mins == 0 {
            return "(\(sign)\(hours)h)"
        } else {
            return "(\(sign)\(hours)h \(mins)m)"
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Slider with gradient background
            ZStack(alignment: .leading) {
                // Gradient background
                TimezoneHelper.dynamicSliderGradient(cities: cities)
                    .frame(height: 10)
                    .cornerRadius(5)
                
                // Slider
                Slider(
                    value: Binding(
                        get: { Double(minutesSinceMidnight) },
                        set: { minutesSinceMidnight = Int($0.rounded()) }
                    ),
                    in: 0...1440,
                    step: 5
                )
                .accentColor(.clear) // Hides the native track to show the gradient track below
            }
            .padding(.vertical, 8)
            
            // Time display (Minimalist)
            HStack {
                Text(timeString)
                    .font(.system(size: 17, weight: .bold))
                
                Spacer()
                
                Text(adjustmentString)
                    .font(.system(size: 15))
                    .foregroundColor(.secondary)
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }
}

#Preview {
    @Previewable @State var minutes: Int = 915  // 15:15 (3:15 PM)
    
    TimeSlider(minutesSinceMidnight: $minutes, baseDate: Date(), cities: [])
        .padding()
        .background(Color.gray.opacity(0.1))
}
