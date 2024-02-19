//
//  Event.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 19/2/2024.
//

import SwiftUI

struct Event: View {
    var body: some View {
        NavigationSplitView {
            List {
                Text("Divisions")
            }
            .navigationTitle("Event Identifier")
        } detail: {
            Text("Select one to view details.")
        }
    }
}

#Preview {
    Event()
}
