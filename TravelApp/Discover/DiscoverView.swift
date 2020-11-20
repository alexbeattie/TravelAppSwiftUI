//
//  ContentView.swift
//  TravelApp
//
//  Created by Alex Beattie on 11/17/20.
//

import SwiftUI
//https://lireadgroup.s3-us-west-1.amazonaws.com/bda78f98-0050-4f40-9a2c-0160d9043c06.png
//https://lireadgroup.s3-us-west-1.amazonaws.com/be17bf36-b7ad-43e0-8689-5f4c3a20e9e0.jpg
//https://lireadgroup.s3-us-west-1.amazonaws.com/c2eb637f-61d4-4762-b0c7-17d4bb2e9132.png


extension Color {
    static let discoverBackground = Color(.init(white: 0.95, alpha: 1))
//    static let discoverBackground = Color.blue
}
struct DiscoverView: View {
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
    }
    
    var body: some View {
        VStack {
            NavigationView {
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9981487393, green: 0.6986450553, blue: 0.2612254024, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.5928408504, blue: 0.2454817295, alpha: 1))]), startPoint: .top, endPoint: .center)
                        .ignoresSafeArea()
//                    Color(.init(white: 0.9, alpha: 1)).offset(y: 400)
                    Color.discoverBackground.offset(y: 400)
                    ScrollView {
                        HStack {
                            Image(systemName: "magnifyingglass")
                            Text("Where do you want to go")
                            Spacer()
                        }.font(.system(size: 14, weight: .semibold)).foregroundColor(.white)
                        
                        .padding()
                        
                        .background(Color(.init(white: 1, alpha: 0.3)))
                        .cornerRadius(10)
                        .padding(16)
                        
                        
                        DiscoverCategoriesView()
                        VStack {
                            
                            PopularDestinationsView()
                            
                            PopularRestaurantsView()
                            
                            TrendingCategoriesView()
                        }.background(Color.discoverBackground)
                        .cornerRadius(16)
                        .padding(.top, 32)
                        
                    }
                }
                .navigationTitle("Discover")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
    }
}

