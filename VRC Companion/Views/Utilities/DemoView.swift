//
//  DemoView.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 25/8/2024.
//

import SwiftUI

struct DemoView: View {
    var title: String
    var titleStyle: NavigationBarItem.TitleDisplayMode
    
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "truck.box.badge.clock")
                    .font(.title)
                    .imageScale(.large)
                Text("This screen is not included in this demo.")
                    .font(.headline)
                Text("Development continues after task submission.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(titleStyle)
        }
    }
}

#Preview {
    DemoView(title: "Uh oh", titleStyle: .automatic)
}
