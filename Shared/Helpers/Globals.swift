//
//  Globals.swift
//  Zeitgeist
//
//  Created by Daniel Eden on 13/12/2020.
//  Copyright © 2020 Daniel Eden. All rights reserved.
//

import Foundation

typealias UDValuePair<T> = (key: String, value: T)

var APP_VERSION = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "0.0.0"
var UD_STORE_NAME = "group.me.daneden.Zeitgeist.shared"
let UD_STORE = UserDefaults(suiteName: UD_STORE_NAME)

struct UDValues {
  typealias Value = UDValuePair
  
  static let activeSupporterSubscription = ("activeSupporterSubscription", false)
  
  // Notifications
  static let notificationsEnabled = ("notificationsEnabled", false)
  static let allowDeploymentNotifications = ("allowDeploymentNotifications", true)
  static let allowDeploymentErrorNotifications = ("allowDeploymentErrorNotifications", true)
  static let allowDeploymentReadyNotifications = ("allowDeploymentReadyNotifications", true)
}

#if os(macOS)
var IS_MACOS: Bool = true
#else
var IS_MACOS: Bool = false
#endif
