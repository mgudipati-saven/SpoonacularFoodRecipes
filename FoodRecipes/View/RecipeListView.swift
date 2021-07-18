//
//  RecipeListView.swift
//  FoodRecipes
//
//  Created by Murty Gudipati on 02/07/21.
//

import SwiftUI
import CoreData

struct RecipeListView: View {
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
        .navigationBarTitleDisplayMode(.automatic)
    }
  }

  var horizontalScroll: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack {
        Group {
          CardView()
          CardView()
          CardView()
          CardView()
        }
        .frame(width: 200, height: 300)
      }
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
        ZStack(alignment: .leading) {
          NavigationLink(destination: RecipeDetail(recipe: recipe)) {
            EmptyView()
          }
          .opacity(0)
          
          RecipeRow(recipe: recipe)
        }
      }
    }
    .listStyle(PlainListStyle())
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    RecipeListView()
  }
}
