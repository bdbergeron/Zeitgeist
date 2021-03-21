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
  @State var teamID = "-1"
  @State var deploymentID: String?
  @State var deeplink: Deeplinker.Deeplink?
  
  #if os(macOS)
  // swiftlint:disable weak_delegate
  @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
  #else
  @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
  @State var showInMenuBar = true
  #endif
  var vercelNetwork: VercelFetcher = VercelFetcher.shared

  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(vercelNetwork)
        .environment(\.deeplink, deeplink)
        .onAppear { self.loadFetcherItems() }
        .accentColor(Color("AccentColor"))
        .onOpenURL { url in
          let deeplinker = Deeplinker()
          guard let deeplink = deeplinker.manage(url: url) else { return }
          self.deeplink = deeplink
        }
    }.commands {
      CommandGroup(replacing: .newItem, addition: {})
      SidebarCommands()
      ToolbarCommands()
    }
  }
  
  func loadFetcherItems() {
    if vercelNetwork.settings.token != nil {
      vercelNetwork.tick()
    }
  }
}
