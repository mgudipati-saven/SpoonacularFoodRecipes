//
//  SpoonacularRecipeFetcher.swift
//  FoodRecipes
//
//  Created by Murty Gudipati on 03/07/21.
//

import SwiftUI
import Combine

class SpoonacularRecipeFetcher: ObservableObject {
  @Published var results = [Recipe]()

  var recipeSearch: ComplexSearch {
    didSet { fetch() }
  }

  var cancellables = Set<AnyCancellable>()

  var fetchRecipeImage = PassthroughSubject<Recipe, Never>()

  init(recipeSearch: ComplexSearch) {
    self.recipeSearch = recipeSearch
    fetch()
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
          self.results = response.results
          for recipe in self.results {
            self.fetchRecipeImage.send(recipe)
          }
        }
        .store(in: &cancellables)

      fetchRecipeImage
        .flatMap { recipe -> AnyPublisher<Recipe, Never> in
          if let url = URL(string: recipe.url) {
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
          if let index = self.results.firstIndex(where: { $0.id == recipe.id} ) {
            self.results[index] = recipe
          }
        }
        .store(in: &cancellables)
    }
  }
}


