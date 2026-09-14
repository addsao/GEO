//
//  ContentView.swift
//  Lab1
//
//  Created by MAY 02 on 14/9/26.
//

import SwiftUI

struct ContentView: View {
    @State private var inputN = ""
    @State private var result = ""
    var body: some View {
        VStack {
            Text("Calculate n²")
                .font(.system(size: 40))
                .bold()
                .padding()
            Text("Enter a number:")
                .frame(maxWidth:.infinity, alignment: .leading)
                .font(.system(size:30))
            TextField("", text: $inputN)
                .font(.system(size: 40))
                .textFieldStyle(.roundedBorder)
                .padding()
            Button("Calculate n²") {
                if let n = Int(inputN) {
                    let square = n*n
                    result = "\(square)"
                } else {
                    result = "Please input a valid number."
                }
            }
                .font(.system(size: 30))
                .padding()
            Text("Results: \(result)")
                .font(.system(size: 30))
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
