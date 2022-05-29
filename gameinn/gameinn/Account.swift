//
//  Account.swift
//  gameinn
//
//  Created by Tema Sysoev on 28.05.2022.
//

import SwiftUI

struct Account: View {
    var body: some View {
        NavigationView{
        List{
            Section{
                HStack{
                    Spacer()
                VStack{
                Image("author 1")
                    .resizable()
                    .frame(width: 70, height: 70)
                    .cornerRadius(30.0)
                   
                Text("@john_appleseed")
                }
                    Spacer()
                }
                .padding()
              
            }
            
            Section{
                HStack{
                    Label("Pulse: 86", systemImage: "waveform.path.ecg")
                        .imageScale(.small)
                        .foregroundColor(.red)
                    Spacer()
                    Label("-23", systemImage: "arrow.down")
                        .imageScale(.small)
                        .foregroundColor(.red)
                        .font(.footnote)
                        .frame(width: 75)
                }
                     
                HStack{
                    Label("Energy: 130", systemImage: "bolt.fill")
                        .imageScale(.small)
                        .foregroundColor(.orange)
                    Spacer()
                    Label("+12", systemImage: "arrow.up")
                        .imageScale(.small)
                        .foregroundColor(.green)
                        .font(.footnote)
                        .frame(width: 75)
                }
                      
                HStack{
                    Label("Ginns: 437", systemImage: "g.circle.fill")
                        .imageScale(.small)
                        .foregroundColor(Color("AccentColor-1"))
                        
                    Spacer()
                    Label("+49", systemImage: "arrow.up")
                        .imageScale(.small)
                        .foregroundColor(.green)
                        .font(.footnote)
                        .frame(width: 75)
                       
                }
                
            }
            Button(action: {}, label: {
                Label("About", systemImage: "info.circle")
            })
            
        }
        .background(Color("Background"))
        .navigationTitle("Account")
        }
       
    }
}

struct Account_Previews: PreviewProvider {
    static var previews: some View {
        Account()
    }
}
