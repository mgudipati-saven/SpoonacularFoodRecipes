//
//  Recipes.swift
//  FoodRecipes
//
//  Created by Murty Gudipati on 03/07/21.
//

import SwiftUI
import Combine

class Recipes: ObservableObject {
  @Published var results = [Recipe]()

  var cancellables = Set<AnyCancellable>()

  //  let url = URL(string: "https://api.spoonacular.com/recipes/1123/information?apiKey=0198c82840ed492bb38338ec5ac01519")!

    let url = URL(string: "https://api.spoonacular.com/recipes/complexSearch?query=pasta&addRecipeNutrition=true&number=2&apiKey=0198c82840ed492bb38338ec5ac01519")!

  var fetchRecipeImage = PassthroughSubject<Recipe, Never>()

  init() {
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


