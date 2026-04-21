//
//  ContentView.swift
//  Clock_V2
//
//  Created by Aarief Fawwaz Satriahutama on 21/04/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var cities: [City]
    @State private var adjustedMinutes: Int = {
        let now = Date()
        let components = Calendar.current.dateComponents([.hour, .minute], from: now)
        return (components.hour ?? 0) * 60 + (components.minute ?? 0)
    }()
    @State private var showAddCitySheet: Bool = false
    
    private var adjustedDate: Date {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day], from: Date())
        components.hour = adjustedMinutes / 60
        components.minute = adjustedMinutes % 60
        return calendar.date(from: components) ?? Date()
    }
    
    private var meetingViability: (label: String, systemImage: String, color: Color, desc: String) {
        guard !cities.isEmpty else {
            return ("No Cities", "globe", .gray, "Add cities to see viability.")
        }
        
        let statuses = cities.map { TimezoneHelper.getWorkingHourStatus(time: adjustedDate, timezoneID: $0.id) }
        
        if statuses.contains(.offHours) {
            return ("Poor Timing", "xmark.circle.fill", .red, "Someone is outside working hours.")
        } else if statuses.contains(.soSoHours) {
            return ("Fair Timing", "exclamationmark.triangle.fill", .yellow, "Outside working hours for some.")
        } else {
            return ("Perfect Timing", "checkmark.circle.fill", .green, "Everyone is in working hours.")
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Main Section: City Cards List
                    if cities.isEmpty {
                        VStack(spacing: 16) {
                            Spacer()
                            
                            Image(systemName: "globe")
                                .font(.system(size: 48))
                                .foregroundColor(.gray)
                            
                            Text("No cities selected")
                                .font(.system(size: 18, weight: .semibold))
                            
                            Text("Tap + to add one")
                                .font(.system(size: 16))
                                .foregroundColor(.secondary)
                            
                            Spacer()
                        }
                        .frame(maxWidth: .infinity)
                    } else {
                        List {
                            ForEach(cities, id: \.id) { city in
                                CityCard(
                                    cityName: city.name,
                                    countryCode: city.countryCode,
                                    timezoneID: city.id,
                                    displayTime: adjustedDate
                                )
                                .listRowInsets(EdgeInsets(top: 6, leading: 16, bottom: 6, trailing: 16))
                                .listRowBackground(Color.clear)
                                .listRowSeparator(.hidden)
                            }
                            .onDelete(perform: deleteCities)
                        }
                        .listStyle(.plain)
                    }
                    
                    Spacer()
                    
                    // Bottom Section: Time Slider & Controls
                    VStack(spacing: 16) {
                        // Meeting Viability Banner
                        HStack(spacing: 12) {
                            Image(systemName: meetingViability.systemImage)
                                .font(.title2)
                                .foregroundColor(meetingViability.color)
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text(meetingViability.label)
                                    .font(.system(size: 15, weight: .bold))
                                
                                Text(meetingViability.desc)
                                    .font(.system(size: 13))
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .background(meetingViability.color.opacity(0.1))
                        .cornerRadius(12)
                        .padding(.horizontal, 16)
                        .padding(.top, 8)

                        TimeSlider(
                            minutesSinceMidnight: $adjustedMinutes,
                            baseDate: Date(),
                            cities: cities
                        )
                        
                        HStack {
                            Button(action: resetToNow) {
                                Image(systemName: "arrow.counterclockwise")
                                    .font(.system(size: 20, weight: .bold))
                            }
                            .buttonStyle(.borderedProminent)
                            .buttonBorderShape(.circle)
                            .tint(.blue)
                            .controlSize(.large)
                            
                            Spacer()
                            
                            Button(action: shareSnapshot) {
                                Image(systemName: "square.and.arrow.up")
                                    .font(.system(size: 20, weight: .bold))
                                    .offset(y: -2) // Optically center the share icon
                            }
                            .buttonStyle(.borderedProminent)
                            .buttonBorderShape(.circle)
                            .tint(.blue)
                            .controlSize(.large)
                        }
                        .padding(.horizontal, 24)
                        .padding(.bottom, 16)
                    }
                    .background(Color(.systemBackground))
                    .shadow(color: Color.black.opacity(0.05), radius: 10, y: -5)
                }
            }
            .navigationTitle("Match Zone")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showAddCitySheet = true
                    } label: {
                        Image(systemName: "plus")
                            .font(.system(size: 15, weight: .bold))
                    }
                    .buttonStyle(.borderedProminent)
                    .buttonBorderShape(.circle)
                    .tint(.blue)
                    .controlSize(.small)
                }
            }
        }
        .sheet(isPresented: $showAddCitySheet) {
            AddCitySheet()
        }
    }
    
    private func deleteCities(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(cities[index])
            }
        }
    }
    
    private func resetToNow() {
        let components = Calendar.current.dateComponents([.hour, .minute], from: Date())
        let nowMinutes = (components.hour ?? 0) * 60 + (components.minute ?? 0)
        withAnimation {
            adjustedMinutes = nowMinutes
        }
    }
    
    private func shareSnapshot() {
        let text = ShareFormatter.copyableText(cities: cities, adjustedDate: adjustedDate)
        
        let pasteboard = UIPasteboard.general
        pasteboard.string = text
        
        let scenes = UIApplication.shared.connectedScenes
        guard let windowScene = scenes.first as? UIWindowScene,
              let window = windowScene.windows.first else { return }
        
        let shareVC = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        window.rootViewController?.present(shareVC, animated: true)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: City.self, inMemory: true)
}
