//
//  DiscoverCategoriesView.swift
//  TravelApp
//
//  Created by Alex Beattie on 11/20/20.
//

import SwiftUI

struct DiscoverCategoriesView: View {
    let categories: [Category] = [
        .init(name: "Art", imageName: "paintpalette.fill"),
        .init(name: "Sport", imageName: "sportscourt.fill"),
        .init(name: "Life Events", imageName: "music.mic"),
        .init(name: "Food", imageName: "music.mic"),
        .init(name: "Food", imageName: "music.mic"),
    ]
    
    var body: some View {
       
        ScrollView(.horizontal, showsIndicators: false) {
           
            HStack(alignment: .top, spacing: 12) {
                ForEach(categories, id: \.self) { category in
                    VStack(spacing: 12) {                        
                        Image(systemName: category.imageName)
                            .font(.system(size: 16))
                            .foregroundColor(Color(#colorLiteral(red: 1, green: 0.605704248, blue: 0.2485194504, alpha: 1)))
                            .frame(width: 68, height: 68)
                            .background(Color.white)
                            .cornerRadius(68)
                        .shadow(color: .init(.sRGB, white:0.8, opacity:1), radius: 4, x: 0.0, y: 2)
                        Text(category.name).font(.system(size: 12, weight: .semibold)).multilineTextAlignment(.center).foregroundColor(.white)
                    }.frame(width:68)
                }
            }.padding(.horizontal)
        }
    }
}
struct DiscoverCategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverCategoriesView()
        DiscoverView()
    }
}
