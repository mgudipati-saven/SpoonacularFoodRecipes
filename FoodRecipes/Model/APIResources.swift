//
//  APIResources.swift
//  FoodRecipes
//
//  Created by Murty Gudipati on 02/07/21.
//

import Foundation

struct APIResources {
  enum EndPoint: String {
    case recipes
  }

  static var urlComponents: URLComponents {
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = "api.spoonacular.com"
    return urlComponents
  }

  static func url(with endpoint: EndPoint) -> URL? {
    urlComponents.url?.appendingPathComponent(endpoint.rawValue)
  }
}
