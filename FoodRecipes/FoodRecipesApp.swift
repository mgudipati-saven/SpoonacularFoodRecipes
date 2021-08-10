//
//  FoodRecipesApp.swift
//  FoodRecipes
//
//  Created by Murty Gudipati on 02/07/21.
//

import SwiftUI

@main
struct FoodRecipesApp: App {
  let persistenceController = PersistenceController.shared
  let webservice = WebService.shared
  let recipeSearch = ComplexSearch(query: "pasta")

  init() {
    webservice.fetch(recipeSearch: recipeSearch, context: persistenceController.container.viewContext)
  }

  var body: some Scene {
    WindowGroup {
      RecipeListView(recipeSearch: recipeSearch)
        .environment(\.managedObjectContext, persistenceController.container.viewContext)
    }
  }
}
