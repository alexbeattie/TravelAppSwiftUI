//
//  CategoryDetailsView.swift
//  TravelApp
//
//  Created by Alex Beattie on 11/21/20.
//

import SwiftUI
import KingfisherSwiftUI
class CategoryDetailsViewModel: ObservableObject {
    @Published var isLoading = true
    @Published var places = [Place]()
    @Published var errorMessage = ""
    init(name: String) {
        let urlString = "http://travel.letsbuildthatapp.com/travel_discovery/category/?name=\(name.lowercased())".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        //real networking here
        guard let url = URL(string:urlString) else {
            
            self.isLoading = false
            
            return
            
        }
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
           
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                if let statusCode = (resp as? HTTPURLResponse)?.statusCode, statusCode >= 400{
                    self.isLoading = false
                    self.errorMessage = "Bad Request: \(statusCode)"
                    return
                }
                guard let data = data else { return }
                do {
                    self.places = try JSONDecoder().decode([Place].self, from: data)
                } catch {
                    print("Failed to get JSON", error)
                    self.errorMessage = error.localizedDescription
                }
                self.isLoading = false
                //self.places = [1]
            }
        }.resume()
        
        //fake networking here
      
    }
}
struct CategoryDetailsView: View {
    
    private let name: String
    @ObservedObject private var vm: CategoryDetailsViewModel
    
    init(name: String) {
        print("Loaded a Category Details view and making a network requesto for \(name)")
        self.name = name
        self.vm = .init(name: name)
    }
//    @ObservedObject var vm = CategoryDetailsViewModel()

    var body: some View {
        ZStack {
            
            if vm.isLoading {
                VStack {
                    ActivityIndicatorView()
                    Text("Loading").foregroundColor(.white).font(.system(size: 14, weight: .semibold))
                }
                .padding()
                .background(Color.black)
                .cornerRadius(8)
            } else {
                ZStack {
                    if !vm.errorMessage.isEmpty {
                        VStack {
                            Image(systemName: "xmark.octagon.fill").font(.system(size: 64, weight: .semibold)).foregroundColor(Color.red).padding()
                            Text(vm.errorMessage)
                        }
                    }
                    ScrollView {
                        ForEach(vm.places, id:\.self) { place in
                            VStack (alignment: .leading, spacing:0) {
//                                Image(place.thumbnail).resizable().scaledToFill()
                                KFImage(URL(string: place.thumbnail)!).resizable().scaledToFill()
                                Text(place.name).font(.system(size: 12, weight: .semibold))
                                    .padding()
                            }.asTile()
                            .padding()
                            
                            
                        }
                    }
                }
            }
        }
        .navigationBarTitle(name, displayMode: .inline)
    }
}

struct CategoryDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CategoryDetailsView(name: "Food")
        }
        DiscoverView()
    }
}
