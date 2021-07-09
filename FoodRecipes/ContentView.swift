//
//  ContentView.swift
//  FoodRecipes
//
//  Created by Murty Gudipati on 02/07/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
  @State var recipeSearch = ComplexSearch(query: "pasta")
  @State private var showFilter = false

  var body: some View {
    NavigationView {
      RecipeList(recipeSearch)
        .toolbar {
          filter
        }
        .sheet(isPresented: $showFilter) {
          FilterRecipes(recipeSearch: $recipeSearch)
        }
        .navigationTitle("Recipes")
    }
  }

  var filter: some View {
    Button("Filter") { showFilter.toggle() }
  }
}

struct RecipeList: View {
  @ObservedObject var recipeFetcher: SpoonacularRecipeFetcher

  init(_ recipeSearch: ComplexSearch) {
    recipeFetcher = SpoonacularRecipeFetcher(recipeSearch: recipeSearch)
  }

  var body: some View {
    List {
      ForEach(recipeFetcher.results) { recipe in
        RecipeCard(recipe: recipe)
      }
    }
    .listStyle(PlainListStyle())
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
