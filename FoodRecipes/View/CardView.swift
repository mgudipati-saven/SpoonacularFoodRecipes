//
//  CardView.swift
//  FoodRecipes
//
//  Created by Murty Gudipati on 13/07/21.
//

import SwiftUI

struct CardView: View {
  var body: some View {
    VStack(spacing: 10) {
      Image("pasta")
        .resizable()
        .aspectRatio(contentMode: .fit)

      HStack {
        VStack(alignment: .leading, spacing: 5) {
          Text("Pasta With Tuna")
            .font(.system(.headline, design: .rounded))
            .lineLimit(3)

          readyInMinutes
        }
      }


      Spacer()
    }
    .cornerRadius(10)
    .overlay(
      RoundedRectangle(cornerRadius: 10)
        .stroke(borderColor, lineWidth: 1)
    )
    .padding([.top, .horizontal], 10)
  }

  let borderColor = Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1)

  var readyInMinutes: some View {
    HStack {
      Image(systemName: "clock")
        .foregroundColor(.gray)

      Text("30-45 MIN")
        .font(.footnote)
        .bold()
        .foregroundColor(.gray)

      Spacer()
    }
  }
}

struct CardView_Previews: PreviewProvider {
  static var previews: some View {
    CardView()
  }
}
