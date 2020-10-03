//
//  ContentView.swift
//  Zeitgeist
//
//  Created by Daniel Eden on 13/03/2020.
//  Copyright © 2020 Daniel Eden. All rights reserved.
//

import SwiftUI
import Combine
#if os(macOS)
import Preferences
#endif


struct ContentView: View {
  @EnvironmentObject var settings: UserDefaultsManager
  #if os(macOS)
  var prefsViewController: PreferencesWindowController
  #endif
  @State var inputValue = ""
  @State var settingsPresented = false
  
  var body: some View {
    NavigationView {
      if self.settings.token == nil {
        ZStack {
          Color(TColor.secondarySystemBackground)
          LoginView()
        }
      } else if let fetcher = VercelFetcher(settings, withTimer: true) {
        DeploymentsListView()
          .environmentObject(fetcher)
          .navigationTitle(Text("Deployments"))
          .frame(minWidth: 200, idealWidth: 300)
          .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
              Button(action: { self.settingsPresented.toggle() }) {
                Label("Settings", systemImage: "slider.horizontal.3").labelStyle(IconOnlyLabelStyle())
              }.sheet(isPresented: $settingsPresented, content: {
                SettingsView(presented: $settingsPresented)
                  .environmentObject(fetcher)
                  .environmentObject(settings)
              })
            }
          }
          
        EmptyDeploymentView()
          
        #if os(macOS)
        // TODO: Fix macOS build from here, probably adding toolbars above instead
        HStack {
          Spacer()
          NavigationLink(destination: {
            SettingsView()
          }) {
            Label("Settings", systemImage: "slider.horizontal.3")
          }

          Button(action: {
            self.quitApplication()
          }) {
            Label("Quit", systemImage: "escape")
          }
        }.padding(.horizontal).padding(.vertical, 8)
        #endif
      }
    }
    .navigationViewStyle(StackNavigationViewStyle())
    .accentColor(Color(TColor.systemIndigo))
  }
  
  #if os(macOS)
  func quitApplication() {
    DispatchQueue.main.async {
      NSApp.terminate(nil)
    }
  }
  #endif
}
