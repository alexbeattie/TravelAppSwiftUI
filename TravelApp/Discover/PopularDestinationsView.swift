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
    @State var isShowingAttractions = true
    
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
                Button(action: { isShowingAttractions.toggle() }, label: {
                    Text("\(isShowingAttractions ? "Hide" : "Show") Attractions").font(.system(size: 14, weight: .semibold))
                })
                Toggle("", isOn: $isShowingAttractions).labelsHidden()
                
            }.padding(.horizontal)
            
            Map(coordinateRegion: $region, annotationItems: isShowingAttractions ? attractions : []) { attraction in
//                MapMarker(coordinate: .init(latitude: attraction.latitude, longitude: attraction.longitude), tint: .red)
                
                MapAnnotation(coordinate: .init(latitude: attraction.latitude, longitude: attraction.longitude)) {
//                    Text("TEST")
                    CustomMapAnnotation(attraction: attraction)
                }
            }
            .frame(height: 300)
            
            
        }.navigationBarTitle(destination.name, displayMode: .inline)
    }
    let attractions:[Attraction] = [
        .init(name: "Eifell Tower", imageName: "eifell", latitude: 48.858546528170386, longitude: 2.2944330272730094),
        .init(name: "Champs-Elysees", imageName: "newyork", latitude: 48.866867, longitude: 2.311780),
        .init(name: "Louvre Museum", imageName: "japan", latitude: 48.860288, longitude: 2.337789),
        
    ]
}
struct CustomMapAnnotation : View {
    let attraction : Attraction
    
    var body: some View {
        
    VStack {
        Image(attraction.imageName).resizable().frame(width: 80, height: 60, alignment: .center).cornerRadius(4)
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Color(.init(white: 0, alpha: 0.5)))
                        )
        Text(attraction.name)
            .font(.system(size: 12, weight: .semibold))
            .padding(.horizontal, 6)
            .padding(.vertical, 4)
            .background(LinearGradient(gradient: /*@START_MENU_TOKEN@*/Gradient(colors: [Color.red, Color.blue])/*@END_MENU_TOKEN@*/, startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/))
            .foregroundColor(Color.white)
//            .border(Color.black)
            .cornerRadius(4)
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Color(.init(white: 0, alpha: 0.5)))
                        )
        }.shadow(radius: 5)
    }
}
struct Attraction: Identifiable {
    let id = UUID().uuidString
    let name, imageName: String
    let latitude, longitude: Double
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
