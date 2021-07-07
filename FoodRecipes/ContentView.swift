//
//  ContentView.swift
//  FoodRecipes
//
//  Created by Murty Gudipati on 02/07/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
  @StateObject var recipes = Recipes()

  var body: some View {
    List {
      ForEach(recipes.results) { recipe in
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

          Text(recipe.title)
            .font(.system(.title, design: .rounded))
            .fontWeight(.black)
            .foregroundColor(.white)

          VStack {
            Spacer()
            HStack {
              Spacer()
              Image(systemName: "heart.fill")
                .foregroundColor(.red)

              Text("\(recipe.aggregateLikes)")
                .font(.footnote)
                .bold()
                .foregroundColor(.white)
            }
          }
          .padding(10)

          VStack {
            Spacer()
            HStack {
              Image(systemName: "clock")
                .foregroundColor(.white)

              Text("\(recipe.readyInMinutes)m")
                .font(.footnote)
                .bold()
                .foregroundColor(.white)

              Spacer()
            }
          }.padding(10)
        }
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
