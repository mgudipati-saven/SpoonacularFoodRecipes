//
//  RecipeDetail.swift
//  FoodRecipes
//
//  Created by Murty Gudipati on 12/07/21.
//

import SwiftUI

struct RecipeDetail: View {
  var body: some View {
    ScrollView {
      VStack {
        Image("pasta")
          .resizable()
          .scaledToFill()
          .frame(minWidth: 0, maxWidth: .infinity)
          .frame(height: 350)
          .clipped()

        VStack(spacing: 10) {
          Text("Pasta").font(.system(.title3, design: .rounded)).bold()
          HStack(spacing: 2) {
            Image(systemName: "star.fill").foregroundColor(.yellow)
            Image(systemName: "star.fill").foregroundColor(.yellow)
            Image(systemName: "star.fill").foregroundColor(.yellow)
            Image(systemName: "star.fill").foregroundColor(.yellow)
            Image(systemName: "star.fill").foregroundColor(.yellow)
          }
          HStack {
            ImageTag(image: "clock", tag1: "35", tag2: "mins")
            ImageTag(image: "person.2.fill", tag1: "3", tag2: "servings")
            ImageTag(image: "flame", tag1: "350", tag2: "Cal")
            ImageTag(image: "square.stack.3d.up.fill", tag1: "", tag2: "Easy")
          }
        }
        .padding()
        .background(Color.white.opacity(0.95))
        .cornerRadius(15)
        .shadow(radius: 2)
        .offset(y: -70)
        .padding(.bottom, -70)

        VStack(alignment: .leading) {
          Text("Ingredients")
            .font(.system(.title3, design: .rounded))
            .bold()

          ScrollView(.horizontal) {
            HStack(spacing: 10) {
              IngredientCard(name: "White Bread", image: "white-bread", amount: "2 slices")
              IngredientCard(name: "Whole Chicken", image: "whole-chicken", amount: "1 pound")
              IngredientCard(name: "Pineapple", image: "pineapple", amount: "2 pounds")
            }
            .frame(height: 162)
          }
        }
        .padding()
      }
    }
    .edgesIgnoringSafeArea(.top)
  }
}

struct IngredientCard: View {
  let name: String
  let image: String
  let amount: String

  var body: some View {
    VStack(alignment: .leading, spacing: 5) {
      Image(image)
        .resizable()
        .frame(width: 100, height: 100)
        .padding(5)
        .overlay(Color.gray.opacity(0.1).cornerRadius(20))

      Spacer()

      Text(name)
        .font(.system(.caption, design: .rounded))

      Text(amount)
        .font(.system(.footnote, design: .rounded))
        .foregroundColor(.gray)
    }
  }
}

struct ImageTag: View {
  let image: String
  let tag1: String
  let tag2: String

  var body: some View {
    VStack(spacing: 2) {
      Image(systemName: image).font(.title2)
        .padding()
        .background(Color.white)
        .clipShape(Circle())
        .padding(5)

      Text(tag1).bold()
      Text(tag2).font(.footnote)
    }
    .frame(width: 70)
    .padding(.bottom)
    .background(Color.orange.clipShape(Capsule()))
  }
}


struct RecipeDetail_Previews: PreviewProvider {
  static var previews: some View {
    RecipeDetail()
  }
}
