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
  var image: UIImage? = nil

  enum CodingKeys: String, CodingKey {
    case id, title, summary, aggregateLikes, readyInMinutes
    case url = "image"
  }
}

struct ComplexSearchResponse: Codable {
  let results: [Recipe]
}
