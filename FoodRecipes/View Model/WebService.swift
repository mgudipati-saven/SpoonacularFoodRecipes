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

  var fetchRecipeImage = PassthroughSubject<SpoonacularRecipe, Never>()

  func fetchRecipeDetails(for id: Int) {
    cancellables.forEach { cancellable in
      cancellable.cancel()
    }

    if let url = URL(string: "https://api.spoonacular.com/recipes/\(id)/information?apiKey=0198c82840ed492bb38338ec5ac01519") {
      print(url)
      URLSession.shared.dataTaskPublisher(for: url)
        .map(\.data)
        .decode(type: SpoonacularRecipe.self, decoder: JSONDecoder())
        .receive(on: DispatchQueue.main)
        .sink {
          print("Completion \($0)")
        } receiveValue: { response in
          self.recipe = response
          self.fetchRecipeImage.send(response)
        }
        .store(in: &cancellables)

      fetchRecipeImage
        .flatMap { recipe -> AnyPublisher<SpoonacularRecipe, Never> in
          if let url = URL(string: recipe.url!) {
            return URLSession.shared.dataTaskPublisher(for: url)
              .compactMap { (data, response) in
                UIImage(data: data)
              }
              .map { image -> SpoonacularRecipe in
                var recipe = recipe
                recipe.image = image
                return recipe
              }
              .replaceError(with: recipe)
              .eraseToAnyPublisher()
          } else {
            return Just(recipe)
              .eraseToAnyPublisher()
          }
        }
        .receive(on: DispatchQueue.main)
        .sink { [unowned self] recipe in
          self.recipe = recipe
        }
        .store(in: &cancellables)
    }
  }
}
