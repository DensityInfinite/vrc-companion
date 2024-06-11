//
//  Lookup.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 31/5/2024.
//

import SwiftUI

struct LookupView: View {
    @State private var searchText: String = ""
    var body: some View {
        NavigationSplitView {
            List {
                Section("Teams") {
                    Text("Team Identifier")
                }
            }
            .navigationTitle("Lookup")
        } detail: {
            Text("Select one to view details.")
        }
        .searchable(text: $searchText)
    }
}

#Preview {
    LookupView()
}
