//
//  Store.swift
//  gameinn
//
//  Created by Tema Sysoev on 28.05.2022.
//

import SwiftUI

struct Store: View {
    @State public var items = [Item(image: "fortnite-outfit-8-ball-vs-scratch", title: "8 ball", price: "10"), Item(image: "fortnite-outfit-agent-peely", title: "Agent Peely", price: "300"), Item(image: "fortnite-outfit-aim-1", title: "A.I.M.", price: "39"), Item(image: "fortnite-outfit-aerobic-assassin", title: "Aerobic", price: "6")]
    var body: some View {
        NavigationView{
        List{
            Section("Energy"){
                HStack{
                    
                    Image(systemName: "bolt.fill")
                        .foregroundColor(.gray)
                        
                    Text("5")
                    
                    Spacer()
                    
                    
                    Button(action: {}, label: {
                        HStack{
                            Spacer()
                            Text("20")
                            Image(systemName: "g.circle.fill")
                           
                        }
                       
                    })
                    .frame(width: 100)
                }
                HStack{
                    
                    Image(systemName: "bolt.fill")
                        .foregroundColor(.orange)
                        
                    Text("15")
                    
                    Spacer()
                    
                    
                    Button(action: {}, label: {
                        HStack{
                            Spacer()
                            Text("40")
                            Image(systemName: "g.circle.fill")
                           
                        }
                       
                    })
                    .frame(width: 100)
                }
                HStack{
                    
                    Image(systemName: "bolt.fill")
                        .foregroundColor(Color("AccentColor-1"))
                        
                    Text("25")
                    
                    Spacer()
                    
                    
                    Button(action: {}, label: {
                        HStack{
                            Spacer()
                            Text("60")
                            Image(systemName: "g.circle.fill")
                           
                        }
                       
                    })
                    .frame(width: 100)
                }
            }
            Section("Skins"){
            ForEach(items, id: \.self){item in
               
                HStack{
                    
                    Image(item.image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .cornerRadius(12.0)
                        .padding(.all, 4)
                    Text(item.title)
                    
                    Spacer()
                    
                    
                    Button(action: {}, label: {
                        HStack{
                            Spacer()
                            Text(item.price)
                            Image(systemName: "g.circle.fill")
                           
                        }
                       
                    })
                    .frame(width: 100)
                }
                }
                
            }
        }
        .background(Color("Background"))
        .navigationTitle("Store")
        }
    }
}

struct Store_Previews: PreviewProvider {
    static var previews: some View {
        Store()
    }
}
