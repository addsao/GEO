//
//  ContentView.swift
//  Homework1
//
//  Created by MAY 02 on 14/9/26.
//

import SwiftUI

struct ContentView: View {
    @State private var input1 = ""
    @State private var inputa = ""
    @State private var inputb = ""
    @State private var output1 = ""
    @State private var output2 = ""
    @State private var output3 = ""
    @State private var output4 = ""
    @State private var output5 = ""
    @State private var output6 = ""


    var body: some View {
        VStack (spacing: 1) {
            Text("Number Tools")
                .font(.largeTitle)
                .bold()
            Text("Small numbers, big probabilities!")
            VStack(spacing: 10) {
                Text("Single Number (n)")
                    .font(.system(size: 14, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack {
                    TextField("", text: $input1)
                    if !input1.isEmpty {
                        Button(action: {
                            input1 = "" // Xóa sạch chữ trong box
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                        }
                        .padding(.trailing, 8)

                    }
                }
                .frame(maxWidth: .infinity, alignment: .init(horizontal: .leading, vertical: .center))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color(.systemGray), lineWidth: 0.5)
                )
                .background(Color.white)

                HStack(spacing: 5) {
                    Button("n²\nSquare") {
                        if let n = Int(input1) {
                            let square = n*n
                            output1 = "\(square)"
                        } else {
                            output1 = "err."
                        }
                    }
                        .padding(10)
                        .font(.system(size: 16))
                        .background(Color(.systemBlue).opacity(0.5))
                        .cornerRadius(5)
                        .foregroundColor(.white)
                        Button("n³\nCube") {
                            if let n = Int(input1) {
                                let cube = n*n*n
                                output2 = "\(cube)"
                            } else {
                                output2 = "err."
                            }
                    }
                        .padding(10)
                        .font(.system(size: 16))
                        .background(Color(.systemPurple).opacity(0.5))
                        .cornerRadius(5)
                        .foregroundColor(.white)
                    Button("n!\nFactorial") {
                            if let n = Int(input1) {
                                let factorial = n < 1 ? 1 : (1...n).reduce(1, *)
                                output3 = "\(factorial)"
                            } else {
                                output3 = "err."
                            }
                        }
                        .padding(10)
                        .font(.system(size: 16))
                        .background(Color(.systemPink).opacity(0.5))
                        .cornerRadius(5)
                        .foregroundColor(.white)
                    Button("Prime?\nYes") {
                            if let n = Int(input1) {
                                let prime = n > 1 && (2..<n).allSatisfy { n % $0 != 0 }
                                output4 = "\(prime)"
                            } else {
                                output4 = "err."
                            }
                        }
                        .padding(10)
                        .font(.system(size: 16))
                        .background(Color(.systemGreen).opacity(0.5))
                        .cornerRadius(5)
                        .foregroundColor(.white)
                    }


            }
                .frame(maxHeight:150)
                .padding(10)
                .background(Color(.systemBlue).opacity(0.2))
                .cornerRadius(10)
                .shadow(color: Color.white.opacity(0.3), radius: 5)
                .padding(10)
            VStack(spacing: 10) {
                Text("Results for n = \(input1)")
                    .font(.system(size: 14, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack(spacing: 5) {
                    Text("n²\n\(output1)")
                        .frame(maxWidth: 50)
                        .multilineTextAlignment(.center)
                        .padding(10)
                        .font(.system(size: 16))
                        .background(Color(.systemBlue).opacity(0.5))
                        .cornerRadius(5)
                        .foregroundColor(.white)
                    Text("n³\n\(output2)")
                        .frame(maxWidth: 50)
                        .multilineTextAlignment(.center)
                        .padding(10)
                        .font(.system(size: 16))
                        .background(Color(.systemPurple).opacity(0.5))
                        .cornerRadius(5)
                        .foregroundColor(.white)
                    Text("n!\n\(output3)")
                        .frame(maxWidth: 50)
                        .multilineTextAlignment(.center)
                        .padding(10)
                        .font(.system(size: 16))
                        .background(Color(.systemPink).opacity(0.5))
                        .cornerRadius(5)
                        .foregroundColor(.white)
                    Text("Prime?\n\(output4)")
                        .frame(maxWidth: 50)
                        .multilineTextAlignment(.center)
                        .padding(10)
                        .font(.system(size: 16))
                        .background(Color(.systemGreen).opacity(0.5))
                        .cornerRadius(5)
                        .foregroundColor(.white)
                    }


            }
                .padding(10)
                .background(Color(.systemRed).opacity(0.2))
                .cornerRadius(10)
                .shadow(color: Color.white.opacity(0.3), radius: 5)
                .padding(10)
            VStack(spacing: 10) {
                Text("Two Numbers (a, b)")
                    .font(.system(size: 14, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack(spacing: 5) {
                    Text("Enter a:")
                        .font(.system(size: 14, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Enter b:")
                        .font(.system(size: 14, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                HStack(spacing: 5) {
                    TextField("", text: $inputa)
                        .frame(maxWidth: .infinity, alignment: .init(horizontal: .leading, vertical: .center))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("", text: $inputb)
                        .frame(maxWidth: .infinity, alignment: .init(horizontal: .leading, vertical: .center))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }

                HStack(spacing: 5) {
                    Button("UCLN (GCD)") {
                            if let n1 = Int(inputa), let n2 = Int(inputb) {
                                var x = abs(n1)
                                var y = abs(n2)
                                while y != 0 {
                                    (x, y) = (y, x % y)
                                }
                                
                                output5 = "\(x)"
                            } else {
                                output5 = "err."
                            }
                        }
                        .frame(maxWidth: 130)
                        .padding(10)
                        .font(.system(size: 16))
                        .background(Color(.systemPink).opacity(0.5))
                        .cornerRadius(5)
                        .foregroundColor(.white)
                    Button("BCNN (LCM)") {
                            if let n1 = Int(inputa), let n2 = Int(inputb) {
                                if n1 == 0 || n2 == 0 {
                                    output6 = "0"
                                } else {
                                    var x = abs(n1)
                                    var y = abs(n2)
                                    while y != 0 {
                                        (x, y) = (y, x % y)
                                    }
                                    // BCNN = (a * b) / UCLN
                                    let bcnn = (abs(n1) * abs(n2)) / x
                                    output6 = "\(bcnn)"
                                }
                            } else {
                                output6 = "err."
                            }
                        }
                        .frame(maxWidth: 130)
                        .padding(10)
                        .font(.system(size: 16))
                        .background(Color(.systemGreen).opacity(0.5))
                        .cornerRadius(5)
                        .foregroundColor(.white)
                    }


            }
                .padding(10)
                .background(Color(.systemBlue).opacity(0.2))
                .cornerRadius(10)
                .shadow(color: Color.white.opacity(0.3), radius: 5)
                .padding(10)
            VStack(spacing: 10) {
                Text("Results for a = \(inputa), b = \(inputb)")
                    .font(.system(size: 14, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack(spacing: 5) {

                    Text("UCLN (GCD)\n\(output5)")
                        .frame(maxWidth: 130)
                        .multilineTextAlignment(.center)
                        .padding(10)
                        .font(.system(size: 16))
                        .background(Color(.systemBlue).opacity(0.5))
                        .cornerRadius(5)
                        .foregroundColor(.white)
                    Text("BCNN (LCM)\n\(output6)")
                        .frame(maxWidth: 130)
                        .multilineTextAlignment(.center)
                        .padding(10)
                        .font(.system(size: 16))
                        .background(Color(.systemPurple).opacity(0.5))
                        .cornerRadius(5)
                        .foregroundColor(.white)
                    }


            }
                .padding(10)
                .background(Color(.systemRed).opacity(0.2))
                .cornerRadius(10)
                .shadow(color: Color.white.opacity(0.3), radius: 5)
                .padding(10)
            HStack {
                Button("🗑️ Clear all") {
                    input1 = ""
                    inputa = ""
                    inputb = ""
                    output1 = ""
                    output2 = ""
                    output3 = ""
                    output4 = ""
                    output5 = ""
                    output6 = ""
                }
                .foregroundStyle(.red)
                .frame(maxWidth: 130)
                .padding(10)
                .font(.system(size: 16))
                .background(Color(.systemRed).opacity(0.3))
                .cornerRadius(5)
                .foregroundColor(.white)
                
                Button("?⃝ Help") {


                }
                    .foregroundStyle(.blue)
                    .frame(maxWidth: 130)
                    .padding(10)
                    .font(.system(size: 16))
                    .background(Color(.systemBlue).opacity(0.3))
                    .cornerRadius(5)
                    .foregroundColor(.white)
                
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
