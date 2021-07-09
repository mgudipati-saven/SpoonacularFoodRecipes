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

struct ComplexSearchResponse: Codable {
  let results: [Recipe]
}

struct ComplexRecipeSearch {
  var query: String
  var cuisine: Cuisine?

  var parameters: [String:String] {
    var params = [String:String]()
    params["query"] = query
    params["addRecipeNutrition"] = "true"
    params["cuisine"] = cuisine?.rawValue

    return params
  }
}

enum Cuisine: String, CaseIterable, Identifiable {
  case African, American, British, Cajun, Caribbean, Chinese, EasternEuropean
  case European, French, German, Greek, Indian, Irish, Italian, Japanese
  case Jewish, Korean, LatinAmerican, Mediterranean, Mexican, MiddleEastern
  case Nordic, Southern, Spanish, Thai, Vietnamese

  var id: String { self.rawValue }
}

