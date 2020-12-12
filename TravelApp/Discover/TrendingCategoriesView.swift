//
//  TrendingCategoriesView.swift
//  TravelApp
//
//  Created by Alex Beattie on 11/20/20.
//

import SwiftUI

struct TrendingCategoriesView: View {
    
    let users: [User] = [
        .init(id: 0, name: "Amy Adams", imageName: "amy"),
        .init(id: 1, name: "Billy Childs", imageName: "billy"),
        .init(id: 2, name: "Sam Smith", imageName: "sam"),
    ]
    var body: some View {
        
        VStack (alignment: .leading) {
          
            HStack {
                Text("Trending Creators").font(.system(size: 14, weight: .semibold))
                Spacer()
                Text("Sea All").font(.system(size: 12, weight: .semibold))
            }.padding(.horizontal).padding(.top)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 12) {
                    ForEach(users, id: \.self) { user in
                       NavigationLink(
                        destination:NavigationLazyView(
                            UserDetailsView(user: user)),
                        label: {
                            DiscoverUserView(user: user)
                        })
                        
                    }
                }.padding(.horizontal).padding(.top,6)
                .padding(.bottom)
            }
        }
    }
}


struct DiscoverUserView: View {
    let user: User
    var body: some View {
    VStack {
        Image(user.imageName)
            .resizable()
            .scaledToFill()
            .frame(width: 60, height: 60)
            .cornerRadius(30)
            .foregroundColor(Color(.label))
        Text(user.name).font(.system(size: 11, weight: .semibold))
            .multilineTextAlignment(.center)
            .foregroundColor(Color(.label))

        }
        .frame(width: 60)
        .cornerRadius(5)
        .shadow(color: .init(.sRGB, white:0.8, opacity:1), radius: 4, x: 0.0, y: 2)
    }
}

struct TrendingCategoriesView_Previews: PreviewProvider {
    static var previews: some View {
//        TrendingCategoriesView()
        DiscoverView()
    }
}
