// Created by Brad Bergeron on 11/24/23.

import Foundation

struct ProjectDeeplink: Deeplink {
	let accountID: String
	let projectID: String
}

struct ProjectDeeplinkHandler: DeeplinkHandler {
	static let path = "/view/:accountID/:projectID"

	static func parse(path: String) -> Result<ProjectDeeplink, Error> {
		.success(.init(accountID: "1", projectID: "1"))
	}

	let handler: (ProjectDeeplink) -> Void

	func handle(_ deeplink: ProjectDeeplink) {
		handler(deeplink)
	}
}

