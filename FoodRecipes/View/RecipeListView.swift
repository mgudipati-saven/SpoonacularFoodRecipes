//
//  RecipeListView.swift
//  FoodRecipes
//
//  Created by Murty Gudipati on 02/07/21.
//

import SwiftUI
import CoreData

struct RecipeListView: View {
  @Environment(\.managedObjectContext) var context

  @State var recipeSearch: ComplexSearch
  @State private var showFilter = false

  let webservice = WebService.shared

  var body: some View {
    NavigationView {
      RecipeList(recipeSearch)
        .toolbar {
          filter
        }
        .sheet(isPresented: $showFilter) {
          FilterRecipes(recipeSearch: $recipeSearch)
            .environment(\.managedObjectContext, context)
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
  @FetchRequest var recipes: FetchedResults<Recipe>

  init(_ recipeSearch: ComplexSearch) {
    let request = NSFetchRequest<Recipe>(entityName: "Recipe")
    request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
    request.predicate = NSPredicate.all
    _recipes = FetchRequest(fetchRequest: request)
  }

  var body: some View {
    List {
      ForEach(recipes) { recipe in
        ZStack(alignment: .leading) {
          NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
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

//struct ContentView_Previews: PreviewProvider {
//  static var previews: some View {
//    RecipeListView()
//  }
//}
