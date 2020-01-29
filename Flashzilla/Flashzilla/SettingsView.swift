//
//  SettingsView.swift
//  Flashzilla
//
//  Created by Matthew Mohrman on 1/14/20.
//  Copyright © 2020 Matthew Mohrman. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var retryIncorrectResponses = false
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        Toggle(isOn: $retryIncorrectResponses) {
                            Text("Retry incorrect responses")
                        }
                    }
                }
                Spacer()
            }
            .navigationBarTitle(Text("Settings"))
            .navigationBarItems(trailing:
                Button("Done", action: dismiss)
            )
        }
        .onAppear(perform: loadSettings)
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func dismiss() {
        saveSettings()
        presentationMode.wrappedValue.dismiss()
    }
    
    func loadSettings() {
        retryIncorrectResponses = UserDefaults.standard.bool(forKey: "RetryIncorrectResponses")
    }
    
    func saveSettings() {
        UserDefaults.standard.set(retryIncorrectResponses, forKey: "RetryIncorrectResponses")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
