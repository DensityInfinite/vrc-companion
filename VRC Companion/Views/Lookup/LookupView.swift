//
//  Lookup.swift
//  VRC Companion
//
//  Created by Douglas Jiang on 31/5/2024.
//

import SwiftUI

// This view is a stub/dev view. Development for this is in progress.
struct LookupView: View {
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                DemoView(title: "Lookup", titleStyle: .automatic)
                Spacer()
                
                Button(action: {
                    markAsNewInstall()
                }, label: {
                    ZStack {
                        Text("Show Welcome on Next Launch")
                            .font(.headline)
                            .foregroundStyle(.accent)
                            .frame(height: 45)
                            .containerRelativeFrame(.horizontal, { length, axis in
                                if axis == .vertical {
                                    return 45
                                } else {
                                    return length / 1.3
                                }
                            })
                            .background(RoundedRectangle(cornerRadius: 12).foregroundStyle(.secondary).opacity(0.3))
                    }
                })
                .padding(.bottom, 35)
            }
        }
        .searchable(text: $searchText)
    }
}

extension LookupView {
    /// Clears the saved key to present the welcome screen on next appearance of `UpcomingView`.
    ///
    /// This method should only be used for demonstration and marking purposes only. It will be moved into a settings view in the future.
    func markAsNewInstall() {
        UserDefaults.standard.removeObject(forKey: "oldInstall")
    }
}

#Preview {
    LookupView()
}
