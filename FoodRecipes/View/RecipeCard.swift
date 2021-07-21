//
//  RecipeCard.swift
//  FoodRecipes
//
//  Created by Murty Gudipati on 09/07/21.
//

import SwiftUI

struct RecipeCard: View {
  let recipe: Recipe

  var body: some View {
    ZStack {
      Image(uiImage: recipe.image ?? UIImage())
        .resizable()
        .aspectRatio(contentMode: .fill)
        .frame(height: 200)
        .cornerRadius(20)
        .overlay(
          Color.black
            .cornerRadius(20)
            .opacity(0.6)
        )

      Text(recipe.title ?? "")
        .font(.system(.title, design: .rounded))
        .fontWeight(.black)
        .foregroundColor(.white)

      aggregateLikes
      readyInMinutes
    }
  }

  var aggregateLikes: some View {
    VStack {
      Spacer()
      HStack {
        Spacer()
        Image(systemName: "heart.fill")
          .foregroundColor(.red)

        Text("\(recipe.aggregateLikes ?? 0)")
          .font(.footnote)
          .bold()
          .foregroundColor(.white)
      }
    }
    .padding(10)
  }

  var readyInMinutes: some View {
    VStack {
      Spacer()
      HStack {
        Image(systemName: "clock")
          .foregroundColor(.white)

        Text("\(recipe.readyInMinutes ?? 0)m")
          .font(.footnote)
          .bold()
          .foregroundColor(.white)

        Spacer()
      }
    }
    .padding(10)
  }
}

struct RecipeCard_Previews: PreviewProvider {
    static var previews: some View {
      RecipeCard(recipe: Recipe.samples[0])
        .frame(height: 200)
    }
}
