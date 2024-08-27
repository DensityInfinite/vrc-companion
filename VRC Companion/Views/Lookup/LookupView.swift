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
        NavigationStack {
            DemoView(title: "Lookup", titleStyle: .automatic)
        }
        .searchable(text: $searchText)
    }
}

#Preview {
    LookupView()
}
