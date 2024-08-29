//
//  VRC_CompanionApp.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 19/2/2024.
//

import SwiftUI
import SwiftData

@main
struct VRC_CompanionApp: App {
    // Model container is initiated before declaring ContentView to avoid crashes below
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            TeamInfoModel.self,
            LocationModel.self,
            IDInfoModel.self
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
                .modelContainer(sharedModelContainer)
        }
    }
}
