//
//  SpoonacularRecipeFetcher.swift
//  FoodRecipes
//
//  Created by Murty Gudipati on 03/07/21.
//

import SwiftUI
import Combine

class SpoonacularRecipeFetcher: ObservableObject {
  @Published var previews = [Recipe]()
  @Published var selectedRecipe: Recipe?

  var recipeSearch: ComplexSearch { didSet { fetch() } }
  var cancellables = Set<AnyCancellable>()
  var fetchRecipeImage = PassthroughSubject<Recipe, Never>()

  init(recipeSearch: ComplexSearch) {
    self.recipeSearch = recipeSearch
    fetch()

    // fetch details for selected recipe
    $selectedRecipe
      .compactMap { $0 }
      .flatMap { recipe -> AnyPublisher<Recipe, Never> in
        if let url = URL(string: "https://api.spoonacular.com/recipes/\(recipe.id)/information?apiKey=0198c82840ed492bb38338ec5ac01519") {
          print(url)
          return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Recipe.self, decoder: JSONDecoder())
            .replaceError(with: recipe)
            .eraseToAnyPublisher()
        } else {
          return Just(recipe)
            .eraseToAnyPublisher()
        }
      }
      .receive(on: DispatchQueue.main)
      .sink { [unowned self] recipe in
        print(recipe)
        if let index = self.previews.firstIndex(where: { $0.id == recipe.id} ) {
          self.previews[index].aggregateLikes = recipe.aggregateLikes
          self.previews[index].readyInMinutes = recipe.readyInMinutes
          self.previews[index].servings = recipe.servings
          self.previews[index].summary = recipe.summary
        }
      }
      .store(in: &cancellables)
  }

  private func fetch() {
    cancellables.forEach { cancellable in
      cancellable.cancel()
    }

    if let url = APIResources.url(with: recipeSearch.parameters) {
      print(url)
      URLSession.shared.dataTaskPublisher(for: url)
        .map(\.data)
        .decode(type: ComplexSearchResponse.self, decoder: JSONDecoder())
        .receive(on: DispatchQueue.main)
        .sink {
          print("Completion \($0)")
        } receiveValue: { response in
          self.previews = response.results
          for recipe in self.previews {
            self.fetchRecipeImage.send(recipe)
          }
        }
        .store(in: &cancellables)

      fetchRecipeImage
        .flatMap { recipe -> AnyPublisher<Recipe, Never> in
          if let url = URL(string: recipe.url!) {
            return URLSession.shared.dataTaskPublisher(for: url)
              .compactMap { (data, response) in
                UIImage(data: data)
              }
              .map { image -> Recipe in
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
          if let index = self.previews.firstIndex(where: { $0.id == recipe.id} ) {
            self.previews[index] = recipe
          }
        }
        .store(in: &cancellables)
    }
  }
}


