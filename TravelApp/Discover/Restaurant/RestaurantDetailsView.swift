//
//  RestaurantDetailsView.swift
//  TravelApp
//
//  Created by Alex Beattie on 12/8/20.
//

import SwiftUI
struct RestaurantDetails: Codable {
    let description: String
    let popularDishes: [Dish]
    let photos: [String]
    let reviews: [Review]
}
struct Dish: Codable, Hashable {
    let name, price, photo: String
    let numPhotos: Int
}
struct Review: Codable, Hashable {
    let user: ReviewUser
    let rating: Int
    let text: String
}
struct ReviewUser: Codable, Hashable {
    let id: Int
    let username, firstName, lastName, profileImage : String
    let followers, following: Int
//    let posts: [Post]
}
//struct Post: Codable, Hashable {
//    let title, imageUrl, views: String
//    let hashtags: [String]
//}

class RestaurantDetailsViewModel:ObservableObject {
   
    @Published var isLoading = true
    @Published var details: RestaurantDetails?
    
    
    init() {
        // nested json
        //https://travel.letsbuildthatapp.com/travel_discovery/restaurant?id=0
        let urlString = "https://travel.letsbuildthatapp.com/travel_discovery/restaurant?id=0"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, resp, error) in
            //handle errors
            guard let data = data else { return }
            DispatchQueue.main.async {
                
                do {
                    self.details = try JSONDecoder().decode(RestaurantDetails.self, from: data)
//                    print(self.details?.reviews)
                } catch {
                    print("you fucked up")
                }
            }
            
        }.resume()
    
    }
    
}
struct RestaurantDetailsView: View {
    
    @ObservedObject var vm = RestaurantDetailsViewModel()
    let restaurant: Restaurant
    var body: some View {
        
        
        
        ScrollView {
            ZStack (alignment: .bottomLeading){
                Image(restaurant.imageName).resizable().scaledToFill()
                LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black]), startPoint: .center, endPoint: .bottom)
                HStack {
                    
                    VStack (alignment: .leading, spacing:4){
                        Text(restaurant.name).foregroundColor(.white)
                            .font(.system(size: 18, weight: .bold))
                        HStack {
                            ForEach(0..<5, id: \.self) { num in
                                Image(systemName: "star.fill").foregroundColor(.orange)
                            }
                        }
                    }.padding()
                    Spacer()
                    NavigationLink(
                        destination: RestaurantPhotosView(),
                        label: {
                            Text("ssssssm photos").foregroundColor(.white)
                                .font(.system(size: 18, weight: .bold))
                                .frame(width: 80, height: 100).multilineTextAlignment(.trailing)

                        })
                    
                }
                
            }
            
            VStack (alignment: .leading, spacing: 8) {
                
                Text("Location & Description")
                    .font(.system(size: 18, weight: .bold))

                Text("Tokyo & Japan")
                HStack {
                    ForEach(0..<5, id: \.self) { num in
                        Image(systemName: "dollarsign.circle.fill").foregroundColor(.orange)
                    }
                    
                }
                HStack { Spacer() }

            }.padding(.top).padding(.horizontal)
            Text(vm.details?.description ?? "")
                .padding(.top, 8)
                .font(.system(size: 14, weight: .regular)).padding(.horizontal).padding(.bottom)

            
            HStack {
                Text("Popular Dishees")
                    .font(.system(size: 18, weight: .bold))
                Spacer()
            }.padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack (spacing: 4) {
                    ForEach(vm.details?.popularDishes ?? [], id: \.self) { dish in
                        DishCell(dish: dish)

                    }
                }.padding(.horizontal)
            }
            if let reviews = vm.details?.reviews {
                ReviewsList(reviews: reviews)
            }
            
            
        }
        .navigationBarTitle("Restaurant Details", displayMode: .inline)
    }
    let sampleDishPhotos = [
        "https://letsbuildthatapp-videos.s3.us-west-2.amazonaws.com/0d1d2e79-2f10-4cfd-82da-a1c2ab3638d2",
        "https://letsbuildthatapp-videos.s3.us-west-2.amazonaws.com/3a352f87-3dc1-4fa7-affe-fb12fa8691fe",
        "https://letsbuildthatapp-videos.s3.us-west-2.amazonaws.com/0d1d2e79-2f10-4cfd-82da-a1c2ab3638d2"
        
    
    ]
}
struct ReviewsList: View {
    let reviews: [Review]
    var body: some View {
        HStack {
            Text("Customer Reviews")
                .font(.system(size: 18, weight: .bold))
            Spacer()
        }
        .padding(.horizontal)

//        if let reviews = vm.details?.reviews {
            ForEach(reviews, id: \.self) { review in
                VStack (alignment: .leading) {
                    HStack {
                        KFImage(URL(string: review.user.profileImage)).resizable().scaledToFit().frame(width:44).cornerRadius(22)
                        VStack (alignment: .leading, spacing:4){
                            Text("\(review.user.firstName)")
                                .font(.system(size: 14, weight: .bold))
                            HStack (spacing: 4){
                                ForEach(0..<review.rating, id: \.self) { num in
                                    Image(systemName: "star.fill").foregroundColor(.orange)
                                        .font(.system(size: 12, weight: .bold))

                                }
                                ForEach(0..<5 - review.rating, id: \.self) { num in
                                    Image(systemName: "star.fill").foregroundColor(.gray)

                                }
                            }.font(.system(size: 12, weight: .bold))

                        }
                        Spacer()
                        Text("Dec 30")
                            .font(.system(size: 14, weight: .bold))
                    }
                    Text(review.text)

                }
            }.padding(.top)
           .padding(.horizontal)
//        }
    }
    
}
struct DishCell: View {
    let dish: Dish

    var body: some View {
        VStack (alignment: .leading){
            ZStack(alignment: .bottomLeading) {
                
                KFImage(URL(string: dish.photo))
                    .resizable().scaledToFill()
                    .cornerRadius(4)
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray))
                    .shadow(radius: 2)
                    .padding(.vertical, 2)
                LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black]), startPoint: .center, endPoint: .bottom)

                Text(dish.price).foregroundColor(.white).font(.system(size: 13, weight: .bold))
                    .padding(.horizontal, 6)
                    .padding(.bottom, 4)
                
            }.frame(height:120)

            Text(dish.name).font(.system(size: 16, weight: .regular))
            Text("\(dish.numPhotos) photos").foregroundColor(.gray).font(.system(size: 12, weight: .regular))
            
        }
    }
}
import KingfisherSwiftUI

struct RestaurantDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            
            RestaurantDetailsView(restaurant: .init(name: "Japan's Finest Tapas", imageName: "japan"))
        }
    }
}
