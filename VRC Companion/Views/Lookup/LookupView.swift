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
            VStack {
                Spacer()
                DemoView(title: "Lookup", titleStyle: .automatic)
                Spacer()
                // Button to reset the saved version and show the welcome screen on next launch or when the user opens ContentView() again. (For marking and demonstration purposes only)
                Button(action: {
                    removeSavedVersion()
                }, label: {
                    ZStack {
                        Text("Show Welcome on Next Launch")
                            .font(.headline)
                            .foregroundStyle(.blue)
                            .frame(height: 45)
                            .containerRelativeFrame(.horizontal, { length, axis in
                                if axis == .vertical {
                                    return length / 3.0
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
    // FOR DEMONSTRATION PURPOSES ONLY. A function to clear the saved key and allows presentation of the welcome screen again.
    func removeSavedVersion() {
        UserDefaults.standard.removeObject(forKey: "oldInstall")
    }
}

#Preview {
    LookupView()
}
