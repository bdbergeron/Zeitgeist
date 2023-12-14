// Created by Brad Bergeron on 11/22/23.

import SwiftUI

// MARK: - Deeplink

protocol Deeplink { }

// MARK: - DeeplinkHandler

protocol DeeplinkHandler {
	associatedtype DeeplinkType: Deeplink
	static var path: String { get }
	static func parse(path: String) -> Result<DeeplinkType, Error>
	func handle(_ deeplink: DeeplinkType)
}
