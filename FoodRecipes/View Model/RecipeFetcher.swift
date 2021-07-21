//
//  RecipeFetcher.swift
//  FoodRecipes
//
//  Created by Murty Gudipati on 21/07/21.
//

import SwiftUI
import Combine

class RecipeFetcher: ObservableObject {
  @Published var recipe: Recipe? = nil

  var cancellables = Set<AnyCancellable>()
  var fetchRecipeImage = PassthroughSubject<Recipe, Never>()

  func fetch(for id: Int) {
    cancellables.forEach { cancellable in
      cancellable.cancel()
    }

    if let url = URL(string: "https://api.spoonacular.com/recipes/\(id)/information?apiKey=0198c82840ed492bb38338ec5ac01519") {
      print(url)
      URLSession.shared.dataTaskPublisher(for: url)
        .map(\.data)
        .decode(type: Recipe.self, decoder: JSONDecoder())
        .receive(on: DispatchQueue.main)
        .sink {
          print("Completion \($0)")
        } receiveValue: { response in
          self.recipe = response
          self.fetchRecipeImage.send(response)
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
          self.recipe = recipe
        }
        .store(in: &cancellables)
    }
  }
}
