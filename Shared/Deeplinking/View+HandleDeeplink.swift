// Created by Brad Bergeron on 11/22/23.

import SwiftUI

extension View {
	func handleDeeplink<Handler: DeeplinkHandler>(handler: Handler) -> some View {
		modifier(HandleDeeplinkViewModifier(handler: handler))
	}
}

// MARK: - HandleDeeplinkViewModifier

private struct HandleDeeplinkViewModifier<Handler: DeeplinkHandler>: ViewModifier {

	// MARK: Internal

	let handler: Handler

	func body(content: Content) -> some View {
		content
			.onAppear {
				registry.register(handler: handler)
			}
	}

	// MARK: Private

	@EnvironmentObject private var registry: DeeplinkRegistry

}
