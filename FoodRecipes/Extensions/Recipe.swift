//
//  Recipe.swift
//  FoodRecipes
//
//  Created by Murty Gudipati on 03/08/21.
//

import Foundation
import CoreData

extension Recipe {
  static func update(from spoonacularRecipe: SpoonacularRecipe, in context: NSManagedObjectContext) {
    print(spoonacularRecipe)
    let request = fetchRequest(NSPredicate(format: "id = %@", String(spoonacularRecipe.id)))
    let results = (try? context.fetch(request)) ?? []
    let recipe = results.first ?? Recipe(context: context)
    recipe.id = Int64(spoonacularRecipe.id)
    recipe.title = spoonacularRecipe.title
    try? context.save()
  }

  static func fetchRequest(_ predicate: NSPredicate) -> NSFetchRequest<Recipe> {
    let request = NSFetchRequest<Recipe>(entityName: "Recipe")
    request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
    request.predicate = predicate
    return request
  }
}
