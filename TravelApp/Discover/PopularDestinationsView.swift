//
//  PopularDestinationsView.swift
//  TravelApp
//
//  Created by Alex Beattie on 11/20/20.
//

import SwiftUI
import MapKit

struct PopularDestinationsView: View {
    
    let destinations: [Destination] = [
        .init(name: "Paris", country: "France", imageName: "eifell", latitude: 48.855014, longitude: 2.341231),
        .init(name: "Tokyo", country: "Japan", imageName: "japan", latitude: 35.67988, longitude: 139.7695),
        .init(name: "New York", country: "US", imageName: "newyork", latitude: 40.71592, longitude: -74.0055),

    ]
    var body: some View {
        
        VStack (alignment: .leading) {
            HStack {
                Text("Popular Destinations").font(.system(size: 14, weight: .semibold))
                Spacer()
                Text("Sea All").font(.system(size: 12, weight: .semibold))
            }.padding(.horizontal).padding(.top)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 2) {
                    ForEach(destinations, id: \.self) { destination in
                        Spacer()
                        NavigationLink(
                            destination: PopularDestinationDetailsView(destination: destination),
                            label: {
                                PopularDestinationTile(destination: destination)
                                    .foregroundColor(.black)
//                                /*@START_MENU_TOKEN@*/Text("Navigate")/*@END_MENU_TOKEN@*/
                            })
//                        .modifier(TileModifier())
                        
                            .padding(.bottom)

                    }
                }.padding(.horizontal)
                
                
            }
            
        }
        
    }
}
struct PopularDestinationDetailsView: View {
//    typealias Body = <#type#>
    
    
    let destination: Destination

    @State var region: MKCoordinateRegion
        
    init(destination: Destination) {
        
        self.destination = destination
        self._region = State(initialValue: MKCoordinateRegion(center: .init(latitude: destination.latitude, longitude: destination.longitude), span: .init(latitudeDelta: 0.1, longitudeDelta: 0.1)))
    }
        
    var body: some View {
        ScrollView {
            Image(destination.imageName).resizable().scaledToFill().frame(height:150).clipped()
            VStack(alignment: .leading) {
                Text(destination.name)
                    .font(.system(size: 18, weight: .bold))
                Text(destination.country)
                HStack {
                    ForEach(0..<5, id: \.self) { num in
                        Image(systemName: "star.fill")
                            .foregroundColor(.orange)
                    }
                }.padding(.top, 2)
                Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing")
                    .padding(.top, 8)
                    .font(.system(size: 14))

                HStack { Spacer() }
            }.padding(.horizontal)
            
            HStack  {
                Text("Location").font(.system(size: 18, weight: .semibold))

                Spacer()
            }.padding(.horizontal)
            Map(coordinateRegion: $region).frame(height:200)
        }.navigationBarTitle(destination.name, displayMode: .inline)
    }
}
struct PopularDestinationTile: View {
    let destination: Destination
    var body: some View {
        VStack (alignment: .leading, spacing: 0) {
            Image(destination.imageName).resizable()
                .scaledToFill()
                .frame(width: 125, height: 125)
                .cornerRadius(4)
                .padding(.horizontal,6)
                .padding(.vertical, 6)
            
            Text(destination.name)
                .font(.system(size: 12, weight: .semibold))
                .padding(.horizontal, 12)
                
            
            Text(destination.country)
                .font(.system(size: 12, weight: .semibold))
                .padding(.horizontal, 12)
                .padding(.bottom, 8)
                .foregroundColor(.gray)
            }
        .asTile()

    }
}
struct PopularDestinationsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                PopularDestinationDetailsView(destination: .init(name: "Paris", country: "France", imageName: "eifell", latitude: 48.855014, longitude: 2.341231))
                
//                (destination: .init(name: "Paris", country: "France", imageName: "japan", latitude: 48.870897155844254, longitude: 2.3385062341288303))
                
//                    .init(name: "Paris", country: "France", imageName: "eifell", latitude: 48.855014, longitude: 2.341231),

            }
        }
        DiscoverView()
        PopularDestinationsView()
//        DiscoverView()
    }
}
