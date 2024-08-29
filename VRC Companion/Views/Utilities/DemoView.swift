//
//  DemoView.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 25/8/2024.
//

import SwiftUI

/// Presents a full screen demo reminder.
///
/// - Parameters:
///   - title: The title of the full screen view.
///   - titleStyle: The desired display style for the nagivation bar title.
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
