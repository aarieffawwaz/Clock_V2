//
//  Clock_V2App.swift
//  Clock_V2
//
//  Created by Aarief Fawwaz Satriahutama on 21/04/26.
//

import SwiftUI
import SwiftData

@main
struct Clock_V2App: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
            City.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
