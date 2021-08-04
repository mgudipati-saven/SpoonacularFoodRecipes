//
//  WebService.swift
//  FoodRecipes
//
//  Created by Murty Gudipati on 03/08/21.
//

import Foundation
import Combine
import CoreData

class WebService {
  private init() { }
  static let shared = WebService()

  var cancellables = Set<AnyCancellable>()

  func fetch(recipeSearch: ComplexSearch, context: NSManagedObjectContext) {
    if let url = SpoonacularAPIResources.url(with: recipeSearch.parameters) {
      print(url)
      URLSession.shared.dataTaskPublisher(for: url)
        .map(\.data)
        .decode(type: ComplexSearchResponse.self, decoder: JSONDecoder())
        .receive(on: DispatchQueue.main)
        .sink {
          print("Completion \($0)")
        } receiveValue: { response in
          for recipe in response.results {
            Recipe.update(from: recipe, in: context)
          }
        }
        .store(in: &cancellables)
    }
  }
}
