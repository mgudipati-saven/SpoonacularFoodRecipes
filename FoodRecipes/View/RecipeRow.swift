//
//  RecipeRow.swift
//  FoodRecipes
//
//  Created by Murty Gudipati on 09/07/21.
//

import SwiftUI

struct RecipeRow: View {
  var recipe: Recipe

  var body: some View {
    HStack(alignment: .top, spacing: 20) {
      thumbnail

      VStack(alignment: .leading) {
        Text(recipe.title)
          .lineLimit(2)
          .font(.system(.title2, design: .rounded))

        Text(recipe.title)
          .lineLimit(1)
          .font(.system(.body, design: .rounded))

        Text(recipe.title)
          .lineLimit(1)
          .font(.system(.subheadline, design: .rounded))
          .foregroundColor(.gray)
      }
    }
  }

  var thumbnail: some View {
    ZStack {
      if recipe.image != nil {
        Image(uiImage: recipe.image!)
          .resizable()
          .aspectRatio(contentMode: .fill)
      } else {
        ProgressView()
      }
      Color.gray.opacity(0.2)
    }
    .frame(width: 100, height: 98)
    .cornerRadius(20)
    .clipped()
  }
}

struct RecipeRow_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      RecipeRow(recipe: Recipe.samples[0])
        .previewLayout(.sizeThatFits)

      RecipeRow(recipe: Recipe.samples[0])
        .previewLayout(.sizeThatFits)
        .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
  }
}
