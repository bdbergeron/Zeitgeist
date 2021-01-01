//
//  Zeitgeist.swift
//  Zeitgeist
//
//  Created by Daniel Eden on 27/06/2020.
//  Copyright © 2020 Daniel Eden. All rights reserved.
//

import SwiftUI

typealias ZeitgeistButtonStyle = DefaultButtonStyle

@main
struct Zeitgeist: App {
  #if os(macOS)
  // swiftlint:disable weak_delegate
  @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
  @AppStorage(UDKey.showInMenuBar.rawValue) private var showInMenuBar = false
  #else
  @State var showInMenuBar = true
  #endif
  var vercelNetwork: VercelFetcher = VercelFetcher.shared
  @Environment(\.scenePhase) var scenePhase
  
  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(vercelNetwork)
        .onAppear(perform: self.loadFetcherItems)
        .accentColor(Color("AccentColor"))
        .onChange(of: showInMenuBar) { showInMenuBar in
          if showInMenuBar && appDelegate.statusBar == nil {
            appDelegate.statusBar = StatusBarController()
          } else if !showInMenuBar {
            appDelegate.statusBar = nil
          }
        }
    }.commands {
      CommandGroup(replacing: .newItem, addition: {})
    }.handlesExternalEvents(matching: ["*"])
    
    #if os(macOS)
    Settings {
      TabView {
        AccountSettingsView()
          .environmentObject(vercelNetwork)
          .fixedSize()
          .tabItem {
            Label("Account", systemImage: "person.crop.circle")
          }
        
        AppearanceSettingsView()
          .fixedSize()
          .tabItem {
            Label("Appearance", systemImage: "paintpalette")
          }
      }.padding().fixedSize()
    }
    #endif
  }
  
  func loadFetcherItems() {
    if vercelNetwork.settings.token != nil {
      vercelNetwork.tick()
    }
  }
}
