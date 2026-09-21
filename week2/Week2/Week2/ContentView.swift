//
//  ContentView.swift
//  Week2
//
//  Created by MAY 02 on 21/9/26.
//

import SwiftUI

struct ContentView: View {
    @State var searchText: String = ""
    @State var places: [Place] = [
        Place(name: "HCMIU", lat: 10.8506, long: 106.7719),
        Place(name: "Home", lat: 10, long: 30),
        Place(name: "Work", lat: 20, long: 50),
        Place(name: "Study", lat: 30, long: 40)
    ]

    var filteredPlaces: [Place] {
        searchText.isEmpty ? places : places.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "mappin")
                    .imageScale(.large)
                    .fixedSize(horizontal: true, vertical: true)
                
                Text("My Place")
                    .font(.largeTitle)
                
                Text("Save places you love!")
                    .font(.system(size: 14, weight: .regular, design: .default))
                    .foregroundColor(.secondary)
                
                TextField("Search", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(10)
                
                List(filteredPlaces) { place in
                    HStack(spacing: 12) {
                        VStack(alignment: .leading) {
                            Text(place.name)
                                .font(.headline)
                            Text("\(place.lat), \(place.long)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundStyle(Color.gray)
                    }
                }
                
                NavigationLink(destination: AddPlaceView(onSave: { newPlace in
                    places.append(newPlace)
                })) {
                    HStack {
                        Image(systemName: "plus")
                        Text("Add Place")
                    }
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.black)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 1)
                    .padding()
                }

                Text("Total places: \(places.count)")
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
