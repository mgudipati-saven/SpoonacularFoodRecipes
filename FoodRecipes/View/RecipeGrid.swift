//
//  RecipeGrid.swift
//  FoodRecipes
//
//  Created by Murty Gudipati on 12/07/21.
//

import SwiftUI

struct RecipeGrid: View {

  var gridItemLayout = [ GridItem(spacing: 20), GridItem(spacing: 20) ]

  var body: some View {
    ScrollView(.vertical) {
      LazyVGrid(columns: gridItemLayout, spacing: 20) {
        ForEach(1..<10) { index in
          VStack(alignment: .leading) {
            ZStack {
              Image("recipe\(index)")
                .resizable()
                .scaledToFill()
                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .frame(height: 250)
                .cornerRadius(25)
                .overlay(Color.black.opacity(0.1).cornerRadius(25))
                .shadow(color: Color.primary.opacity(0.3), radius: 1)

              aggregateLikes
              readyInMinutes
            }

            Text("Chicken Curry")
              .font(.system(.caption, design: .rounded))
              .bold()

            Text("Asian")
              .font(.system(.footnote, design: .rounded))
              .foregroundColor(.gray)
          }
        }
      }
      .padding()
    }
  }

  var aggregateLikes: some View {
    VStack {
      Spacer()
      HStack {
        Spacer()
        HStack {
          Image(systemName: "heart.fill")
            .foregroundColor(.red)

          Text("25")
            .font(.footnote)
            .bold()
            .foregroundColor(.white)
        }
        .padding(5)
        .background(Color.black.opacity(0.3))
        .cornerRadius(25)
      }
    }
    .padding(10)
  }

  var readyInMinutes: some View {
    VStack {
      HStack {
        HStack {
          Image(systemName: "clock")
            .foregroundColor(.white)

          Text("35 mins")
            .font(.footnote)
            .bold()
            .foregroundColor(.white)
        }
        .padding(5)
        .background(Color.black.opacity(0.3))
        .cornerRadius(25)

        Spacer()
      }
      Spacer()
    }
    .padding(10)
  }

}

struct RecipeGrid_Previews: PreviewProvider {
  static var previews: some View {
    RecipeGrid()
  }
}
