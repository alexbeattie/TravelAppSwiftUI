//
//  UserDetailsView.swift
//  TravelApp
//
//  Created by Alex Beattie on 12/10/20.
//

import SwiftUI
import KingfisherSwiftUI

struct UserDetails: Decodable {
    let username, firstName, lastName, profileImage: String
    let followers, following: Int
    let posts: [Post]
}

struct Post: Decodable, Hashable {
    let title, imageUrl, views: String
    let hashtags: [String]
}

class UserDetailsViewModel: ObservableObject {
    @Published var userDetails: UserDetails?
    
    init(userId: Int) {
        guard let url = URL(string: "https://travel.letsbuildthatapp.com/travel_discovery/user?id=\(userId)") else { return }
        URLSession.shared.dataTask(with: url) { (data, url, error) in
            DispatchQueue.main.async {
                
                guard let data = data else { return }
                do {
                    self.userDetails = try JSONDecoder().decode(UserDetails.self, from: data)
                } catch let jsonError {
                    print("decoding failed for UserDetails", jsonError)
                }
                print(data)
            }

            
        }.resume()
    }
}

struct UserDetailsView: View {
    
    // Observed Object (View Model)
//    @ObservedObject var vm = UserDetailsViewModel()
    @ObservedObject var vm: UserDetailsViewModel
    
    
    
    let user: User
    
    init(user: User) {
        self.user = user
//        user.id
        self.vm = .init(userId: user.id)
    }
    var body: some View {
        ScrollView {
            VStack (spacing: 12){
                
                Image(user.imageName).resizable().scaledToFill().frame(width: 60).clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/).shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/).padding(.horizontal).padding(.top)
                Text("\(self.vm.userDetails?.firstName ?? "") \(self.vm.userDetails?.lastName ?? "") ").font(.system(size: 14, weight: .semibold))
                HStack {
                    
                    // opt + 8
                    Text("@\(self.vm.userDetails?.username ?? "") •")
                    Image(systemName: "hand.thumbsup.fill").font(.system(size: 14, weight: .semibold))
                    Text("2451")
                }.font(.system(size: 14, weight: .regular))
                Text("YouTube Vlogger & Creator").font(.system(size: 14, weight: .regular))
                    .foregroundColor(Color(.lightGray))
                HStack (spacing: 12) {
                    
                    VStack {
                        
                        Text("59,394").font(.system(size: 13, weight: .semibold))
                        Text("followers").font(.system(size: 9, weight: .regular))
                    }
                    Spacer()
                        .frame(width:0.5, height: 12).background(Color(.lightGray)).padding(.bottom, 8)
                    VStack {
                        
                        Text("2,112").font(.system(size: 13, weight: .semibold))
                        Text("followers").font(.system(size: 9, weight: .regular))
                    }
                }
                HStack (spacing:16){
                    Button(action: {}, label: {
                        HStack {
                            Spacer()
                            Text("Follow")
                                .foregroundColor(Color(.white))
                            Spacer()
                        }.padding(.vertical, 8)
                        .background(Color.orange).cornerRadius(100)
                    })
                    Button(action: {}, label: {
                        HStack {
                            Spacer()
                            Text("Contact")
                                .foregroundColor(Color(.black))
                            Spacer()
                        }.padding(.vertical, 8)
//                        .background(Color(white: 0.9))
                        .cornerRadius(100)
                    })
                }
               
                .font(.system(size: 12, weight: .semibold))
                ForEach(vm.userDetails?.posts ?? [], id:\.self) { post in

                    VStack (alignment: .leading) {
                        KFImage(URL(string: post.imageUrl)).resizable()
                                                        .scaledToFill()
                                                        .frame(height:200)
                                                        .clipped()
                        HStack {
                            Image(user.imageName).resizable()
                                .scaledToFit()
                                .frame(height:44)
                                .clipShape(Circle())
                            VStack (alignment: .leading) {
                                
                                Text(post.title).font(.system(size: 14, weight: .semibold))
                                Text("\(post.views) views").font(.system(size: 12, weight: .regular)).foregroundColor(.gray)
                            }
                        }.padding(.horizontal, 8)
                        HStack {
                            ForEach(post.hashtags, id: \.self) { hashtag in
                                
                                Text("#\(hashtag)")
                                    .foregroundColor(Color(#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)))
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 4)
                                    .background(Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 0.5))).cornerRadius(20)
                                    .font(.system(size: 13, weight: .regular))
                            }
                        }.padding(.bottom).padding(.horizontal, 8)
                            
                    }
                    
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(color:.init(white:0.8), radius: 5, x: 0, y: 4)
                }
 
            }.padding(.horizontal)

        }.navigationBarTitle(user.name, displayMode: .inline)
    }
}
struct UserDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
        NavigationView {
            
            UserDetailsView(user: .init(id: 0, name: "Amy Adams", imageName: "amy"))
        }
    }
}
