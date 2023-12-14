// Created by Brad Bergeron on 11/22/23.

import SwiftUI

// MARK: - DeeplinkRegistry

class DeeplinkRegistry: ObservableObject {

	// MARK: Internal

	func register<Handler: DeeplinkHandler>(handler: Handler) {
		let identifier = ObjectIdentifier(Handler.self)
		handlers[identifier] = handler
		deeplinkParsers[Handler.path] = AnyDeeplinkParser(parse: Handler.parse(path:))
	}

	func handler<T: Deeplink, Handler: DeeplinkHandler>(for deeplink: T) -> Handler? where Handler.DeeplinkType == T {
		let identifier = ObjectIdentifier(T.self)
		guard let handler = handlers[identifier] as? Handler else { return nil }
		return handler
	}

	func deeplink(forPath path: String) -> Deeplink? {
		guard let parser = deeplinkParsers[path] else { return nil }
		let parseResult = parser.parse(path: path)
		switch parseResult {
		case .success(let deeplink):
			return deeplink
		case .failure:
			// TODO: Handle error
			return nil
		}
	}

	// MARK: Private

	private var handlers = [ObjectIdentifier : any DeeplinkHandler]()
	private var deeplinkParsers = [String: AnyDeeplinkParser]()

}

// MARK: - DeeplinkParser

private struct AnyDeeplinkParser {

	// MARK: Lifecycle

	init<T: Deeplink>(parse: @escaping (String) -> Result<T, Error>) {
		self.parse = { path in
			parse(path).map(AnyDeeplink.init)
		}
	}

	// MARK: Internal

	func parse(path: String) -> Result<AnyDeeplink, Error> {
		parse(path)
	}

	// MARK: Private

	private let parse: (String) -> Result<AnyDeeplink, Error>

}

// MARK: - AnyDeeplink

private struct AnyDeeplink: Deeplink {
	init<T: Deeplink>(_ deeplink: T) { }
}
