// Created by Brad Bergeron on 11/24/23.

import Foundation

struct AccountDeeplink: Deeplink {
	let accountID: String
}

struct AccountDeeplinkHandler: DeeplinkHandler {
	static let path = "/view/:accountID"

	static func parse(path: String) -> Result<AccountDeeplink, Error> {
		.success(.init(accountID: "1"))
	}

	let handler: (AccountDeeplink) -> Void

	func handle(_ deeplink: AccountDeeplink) {
		handler(deeplink)
	}
}
