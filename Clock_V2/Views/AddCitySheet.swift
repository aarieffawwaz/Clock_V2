import SwiftUI
import SwiftData

struct AddCitySheet: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var searchText: String = ""
    
    var filteredCities: [CityInfo] {
        if searchText.trimmingCharacters(in: .whitespaces).isEmpty {
            return Array(CityDatabase.searchCities(query: "").prefix(20))
        }
        return CityDatabase.searchCities(query: searchText)
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredCities.indices, id: \.self) { index in
                    let cityInfo = filteredCities[index]
                    CityListItem(cityInfo: cityInfo, onTap: {
                        addCity(cityInfo)
                    })
                    .listRowSeparator(index == 0 ? .hidden : .visible, edges: .top)
                }
            }
            .listStyle(.plain)
            .overlay {
                if filteredCities.isEmpty && !searchText.isEmpty {
                    ContentUnavailableView.search(text: searchText)
                } else if filteredCities.isEmpty && searchText.isEmpty {
                    ContentUnavailableView {
                        Label("No Cities", systemImage: "globe")
                    } description: {
                        Text("Search for a city or country to add it to your list.")
                    }
                }
            }
            .navigationTitle("Choose a City")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText, placement: .automatic, prompt: "Search cities or countries")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(role: .cancel) {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .symbolRenderingMode(.hierarchical)
                            .foregroundStyle(.secondary)
                            .font(.title2)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
    
    private func addCity(_ cityInfo: CityInfo) {
        let city = City(
            id: cityInfo.id,
            name: cityInfo.name,
            country: cityInfo.country,
            countryCode: cityInfo.countryCode
        )
        modelContext.insert(city)
        dismiss()
    }
}

// MARK: - City List Item Component

struct CityListItem: View {
    let cityInfo: CityInfo
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 12) {
                Text(TimezoneHelper.generateFlagEmoji(countryCode: cityInfo.countryCode))
                    .font(.title3)
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(cityInfo.name)
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.primary)
                    
                    Text(cityInfo.country)
                        .font(.system(size: 13))
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Text(TimezoneHelper.getTimezoneOffset(timezoneID: cityInfo.id))
                    .font(.system(size: 13))
                    .foregroundColor(.secondary)
            }
            .padding(.vertical, 4)
        }
    }
}

// MARK: - Preview

#Preview {
    AddCitySheet()
        .modelContainer(for: City.self, inMemory: true)
}
