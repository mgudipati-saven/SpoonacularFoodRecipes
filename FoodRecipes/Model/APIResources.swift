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

  static func url(with parameters: [String:String]) -> URL? {
    var components = URLComponents()
    components.scheme = "https"
    components.host = "api.spoonacular.com"
    components.path = "/recipes/complexSearch"
    components.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }

    let apiKey = Bundle.main.object(forInfoDictionaryKey: "Spoonacular API Key") as? String
    components.queryItems?.append(URLQueryItem(name: "apiKey", value: apiKey))

    return components.url
  }
}

extension URLComponents {
  mutating func setQueryItems(with parameters: [String:String]) {
    self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
  }
}
