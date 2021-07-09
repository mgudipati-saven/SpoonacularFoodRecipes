//
//  FilterRecipes.swift
//  FoodRecipes
//
//  Created by Murty Gudipati on 09/07/21.
//

import SwiftUI

struct FilterRecipes: View {
  @Environment(\.presentationMode) var presentationMode

  @Binding var recipeSearch: ComplexRecipeSearch

  @State private var draft: ComplexRecipeSearch

  init(recipeSearch: Binding<ComplexRecipeSearch>) {
    _recipeSearch = recipeSearch
    _draft = State(wrappedValue: recipeSearch.wrappedValue)
  }

  var body: some View {
    NavigationView {
      Form {
        TextField("Search Text", text: $draft.query)
        Picker("Cuisine", selection: $draft.cuisine) {
          Text("Any").tag(Cuisine?.none)
          ForEach(Cuisine.allCases) { (cuisine: Cuisine?) in
            Text(cuisine?.rawValue ?? "Any").tag(cuisine)
          }
        }
      }
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          cancel
        }
        ToolbarItem(placement: .navigationBarTrailing) {
          done
        }
      }
      .navigationBarTitle("Filter Recipes")
    }
  }

  var cancel: some View {
    Button("Cancel") {
      presentationMode.wrappedValue.dismiss()
    }
  }

  var done: some View {
    Button("Done") {
      recipeSearch = draft
      presentationMode.wrappedValue.dismiss()
    }
  }
}

struct FilterRecipes_Previews: PreviewProvider {
  static var previews: some View {
    FilterRecipes(recipeSearch: .constant(ComplexRecipeSearch(query: "pasta")))
  }
}
