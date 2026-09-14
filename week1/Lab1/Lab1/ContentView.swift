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
                .foregroundColor(Color.white)
                .padding()
                .frame(maxWidth:.infinity)
                .background(Color.blue)
                .cornerRadius(10)
            Button("Calculate n³") {
                if let n = Int(inputN) {
                    let cube = n*n*n
                    result = "\(cube)"
                } else {
                    result = "Please input a valid number."
                }
            }
                .font(.system(size: 30))
                .foregroundColor(Color.white)
                .padding()
                .frame(maxWidth:.infinity)
                .background(Color.purple)
                .cornerRadius(10)
            Button("Double n") {
                if let n = Int(inputN) {
                    let double = n*2
                    result = "\(double)"
                } else {
                    result = "Please input a valid number."
                }
            }
                .font(.system(size: 30))
                .foregroundColor(Color.white)
                .padding()
                .frame(maxWidth:.infinity)
                .background(Color.green)
                .cornerRadius(10)
            Text("Results: \(result)")
                .font(.system(size: 30))
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
