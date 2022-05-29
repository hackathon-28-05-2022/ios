//
//  ContentView.swift
//  gameinn
//
//  Created by Tema Sysoev on 28.05.2022.
//

import SwiftUI


public var token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjUzODI2NjgwLCJpYXQiOjE2NTM4MjYzODAsImp0aSI6IjNlMjVkZGY1ODU0YjQ2ODNiNjlkZTU0MGQ3MjIxMWU4IiwidXNlcl9pZCI6Mn0.UU1cawRpFgZHheF2swTe9gxHiCsEylI92byQTHzrA-M"
struct ContentView: View {
    @State private var currentPage = 0
    @State private var articles = [Article]()
    @State private var loading = true
    var body: some View {
        if loading{
            ProgressView()
                .onAppear(){
                    loadFeed()
                }
        } else{
        TabView(selection: $currentPage) {
           
         
            
            Feed(articles: articles).tabItem {
            Image(systemName: "text.justifyleft")
            Text("Feed")
        }.tag(1)
                
                
             
                
        
            Store().tabItem {
            Image(systemName: "cart")
            Text("Store")
        }.tag(2)
            
            Account().tabItem {
                Image(systemName: "person.crop.circle")
                Text("Account")
            }.tag(3)
            
            
        
            
    }
            
       
        .preferredColorScheme(.dark)
        
        }
    }
    private func auth(){
        
       
       

    }
    private func loadFeed(){
        Task{
            do{
                guard let url = URL(string: "http://192.168.50.168:8023/api/posts/list/by_raiting/")
                else
                {
                    return
                }
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                request.addValue(token, forHTTPHeaderField: "x-api-key")
                let (data, _) = try await URLSession.shared.data(from: url)
                print(data)
               
                let jsonFeed = try JSONDecoder().decode(FeedJSON.self, from: data)
                print(jsonFeed)
                for article in jsonFeed.results{
                    articles.append(Article(title: article.title, text: article.body, id: article.id, author: article.author.username, likeCounter: article.likes_count, date: ISO8601DateFormatter().date(from: article.created_at) ?? Date.now, imageURL: article.image_url))
                }
            }
         catch {
            print(error)
        }
            loading = false
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
