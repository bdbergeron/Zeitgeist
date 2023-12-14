// Created by Brad Bergeron on 11/22/23.

import SwiftUI

extension View {
	func deeplinkRegistry(urlScheme: String) -> some View {
		modifier(DeeplinkRegistryViewModifier(urlScheme: urlScheme))
	}
}

// MARK: - DeeplinkRegistryViewModifier

private struct DeeplinkRegistryViewModifier: ViewModifier {

	// MARK: Lifecycle

	init(urlScheme: String) {
		self.urlScheme = urlScheme
	}

	// MARK: Internal

	func body(content: Content) -> some View {
		content
			.environmentObject(registry)
			.onOpenURL { url in
				guard
					url.scheme == urlScheme,
					let components = URLComponents(url: url, resolvingAgainstBaseURL: true),
					let deeplink = registry.deeplink(forPath: components.path)
				else {
					return
				}
				print(deeplink)
			}
	}

	// MARK: Private

	private let urlScheme: String
	private let registry = DeeplinkRegistry()

}
