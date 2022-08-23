//
//  PostalService.swift
//  Zeitgeist
//
//  Created by Daniel Eden on 05/06/2021.
//

import Foundation

enum ZPSError: Error {
	case FieldCastingError(field: Any?)
	case EventTypeCastingError(eventType: Any?)
}

enum ZPSEventType: String {
	case deployment
	case deploymentReady = "deployment-ready"
	case deploymentError = "deployment-error"
	case projectCreated = "project-created"
	case projectRemoved = "project-removed"
	
	var emojiPrefix: String {
		switch self {
		case .deployment:
			return "⏱ "
		case .deploymentReady:
			return "✅ "
		case .deploymentError:
			return "🛑 "
		case .projectCreated:
			return "📂 "
		case .projectRemoved:
			return "🗑 "
		}
	}
}

struct ZPSNotificationPayload: Hashable {
	let deploymentId: String
	let userId: String
	let title: String?
	let body: String
	let category: ZPSEventType
}

enum ZPSNotificationCategory: String {
	case deployment, project
}
