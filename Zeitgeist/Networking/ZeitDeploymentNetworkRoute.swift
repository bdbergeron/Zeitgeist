//
//  ZeitDeploymentNetworkRoute.swift
//  Zeitgeist
//
//  Created by Daniel Eden on 13/03/2020.
//  Copyright © 2020 Daniel Eden. All rights reserved.
//

import Foundation

enum ZeitDeploymentNetworkRoute {
  case deployments
}

extension ZeitDeploymentNetworkRoute: NetworkRoute {
  
  var path: String {
    switch self {
    case .deployments:
      return "/v5/now/deployments"
    }
  }
  
  var method: NetworkMethod {
    switch self {
    case .deployments:
      return .get
    }
  }
  
  var headers: [String : String]? {
    switch self {
      default:
        return [
          "Authorization": "Bearer " + (UserDefaults.standard.string(forKey: "ZeitToken") ?? "")
        ]
    }
  }
}
