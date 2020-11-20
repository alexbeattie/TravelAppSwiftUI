//
//  PopularRestaurantsView.swift
//  TravelApp
//
//  Created by Alex Beattie on 11/20/20.
//

import SwiftUI

struct PopularRestaurantsView: View {
    let restaurants: [Restaurant] = [
        
        .init(name: "Japan's Finest Restaurant", imageName: "tapas"),
        .init(name: "Bar & Grill", imageName: "bar_grill"),
        
    ]
    var body: some View {
        
        VStack (alignment: .leading) {
            HStack {
                Text("Popular Places To Eat").font(.system(size: 14, weight: .semibold))
                Spacer()
                Text("Sea All").font(.system(size: 12, weight: .semibold))
            }.padding(.horizontal).padding(.top)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(restaurants, id: \.self) { restaurant in
                        HStack (spacing: 8){
                            Image(restaurant.imageName).resizable().scaledToFill()
                                .frame(width:60, height: 60).clipped()
                                .background(Color.gray)
                                .cornerRadius(5)

                                .padding(.leading, 6)
                                .padding(.vertical, 6)
                            
                            VStack (alignment: .leading) {
                                HStack {
                                    
                                    Text(restaurant.name)
                                    Spacer()
                                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                        Image(systemName: "ellipsis")
                                            .foregroundColor(.white)
                                    })
                                    
                                }
                                 HStack {
                                    Image(systemName: "star.fill")
                                    Text("4.7 • Sushi • $$")
                                }
                                Text("Tokyo, Japan")
                                    
                            }.font(.system(size: 12))
                            

                            Spacer()
                            }

                        .frame(width: 240)
                        .cornerRadius(5)
                        .asTile()
                        .padding(.bottom)
                    }
                }.padding(.horizontal)
            }
        }
    }
}

struct PopularRestaurantsView_Previews: PreviewProvider {
    static var previews: some View {
        PopularRestaurantsView()
        DiscoverView()
    }
}
