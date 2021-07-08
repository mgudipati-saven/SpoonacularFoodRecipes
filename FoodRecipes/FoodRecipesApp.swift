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

    var body: some Scene {
        WindowGroup {
          ContentView(recipeSearch: ComplexRecipeSearch(query: "pasta"))
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
