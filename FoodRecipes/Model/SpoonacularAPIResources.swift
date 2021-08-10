//
//  SpoonacularAPIResources.swift
//  FoodRecipes
//
//  Created by Murty Gudipati on 02/07/21.
//

import Foundation

struct SpoonacularAPIResources {
  enum EndPoint: String {
    case recipes
  }

  static var 

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

struct ComplexSearchResponse: Codable {
  let results: [SpoonacularRecipe]
}

struct ComplexSearch {
  var query: String
  var cuisine: Cuisine?
  var diet: Diet?

  var parameters: [String:String] {
    var params = [String:String]()
    params["query"] = query
//    params["addRecipeNutrition"] = "true"
    params["cuisine"] = cuisine?.rawValue
    params["diet"] = diet?.rawValue
    
    return params
  }
}

enum Cuisine: String, CaseIterable, Identifiable {
  case African, American,
       British,
       Cajun, Caribbean, Chinese,
       European,
       French,
       German, Greek,
       Indian, Irish, Italian,
       Japanese, Jewish,
       Korean,
       Mediterranean, Mexican,
       Nordic,
       Southern, Spanish,
       Thai,
       Vietnamese
  case LatinAmerican = "Latin American"
  case MiddleEastern = "Middle Eastern"
  case EasternEuropean = "Eastern European"

  var id: String { self.rawValue }
}

enum Diet: String, CaseIterable, Identifiable {
  case Ketogenic, Vegetarian, Vegan, Pescetarian, Paleo, Primal, Whole30
  case GlutenFree = "Gluten Free"
  case LactoVegetarian = "Lacto-Vegetarian"
  case OvoVegetarian = "Ovo-Vegetarian"

  var id: String { self.rawValue }
}
