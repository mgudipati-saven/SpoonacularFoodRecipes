//
//  Recipe.swift
//  FoodRecipes
//
//  Created by Murty Gudipati on 02/07/21.
//

import Foundation
import SwiftUI

struct Recipe: Codable, Identifiable {
  let id: Int
  let title: String
  let url: String
  let summary: String
  let aggregateLikes: Int
  let readyInMinutes: Int
  let servings: Int
  var image: UIImage? = nil

  enum CodingKeys: String, CodingKey {
    case id, title, summary, aggregateLikes, readyInMinutes, servings
    case url = "image"
  }

  static let samples = [
    Recipe(
      id: 654959,
      title: "Pasta With Tuna",
      url: "https://spoonacular.com/recipeImages/654959-312x231.jpg",
      summary: "Pasta With Tuna might be just the main course you are searching for. One serving contains <b>421 calories</b>, <b>24g of protein</b>, and <b>10g of fat</b>. For <b>$1.68 per serving</b>, this recipe <b>covers 28%</b> of your daily requirements of vitamins and minerals. 1 person were impressed by this recipe. Head to the store and pick up flour, onion, peas, and a few other things to make it today. It is a good option if you're following a <b>pescatarian</b> diet. All things considered, we decided this recipe <b>deserves a spoonacular score of 92%</b>. This score is excellent. Try <a href=\"https://spoonacular.com/recipes/pasta-and-tuna-salad-ensalada-de-pasta-y-atn-226303\">Pastan and Tuna Salad (Ensalada de Pasta y Atún)</a>, <a href=\"https://spoonacular.com/recipes/tuna-pasta-565100\">Tuna Pasta</a>, and <a href=\"https://spoonacular.com/recipes/tuna-pasta-89136\">Tuna Pasta</a> for similar recipes.",
      aggregateLikes: 2,
      readyInMinutes: 45,
      servings: 4
    )
  ]
}
