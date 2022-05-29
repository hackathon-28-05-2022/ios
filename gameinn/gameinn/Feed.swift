//
//  Articles.swift
//  gameinn
//
//  Created by Tema Sysoev on 28.05.2022.
//

import SwiftUI
struct FeedJSON: Codable{
    let count: Int
    let next: String?
    let previous: String?
    let results: [ResultJSON]
}
struct ResultJSON: Codable{
    let title: String
    let body: String
    let author: AuthorJSON
    let created_at: String
    let id: Int
    let likes_count: Int
    let dislikes_count: Int
    let image_url: String?
}
struct AuthorJSON: Codable{
    let electricity: String
    let username: String
    let coin_balance: String
    let date_joined: String
    let pulse: String
}


struct Feed: View {
    @State private var createNewPost = false
    @State private var loading = true
    @State public var articles: [Article]
    
    @State private var pulse = 0
    @State private var energy = 0
    @State private var ginns = 0
    var body: some View {
       
        NavigationView{
            ScrollView(.vertical, showsIndicators: false){
                if loading{
                    ZStack{
                    HStack{
                        Label("Pulse: 86", systemImage: "waveform.path.ecg").padding()
                            .foregroundColor(.red)
                            .font(.footnote)
                        Label("Energy: 130", systemImage: "bolt.fill").padding(.horizontal, 7)
                            .foregroundColor(.orange)
                            .font(.footnote)
                        Label("Ginns: 437", systemImage: "g.circle.fill").padding()
                            .foregroundColor(Color("AccentColor-1"))
                            .font(.footnote)
                    }
                    .background(Color.gray.opacity(0.1))
                    }
                    .cornerRadius(13.0)
                } else {
                ZStack{
                HStack{
                    Label("Pulse: \(pulse)", systemImage: "waveform.path.ecg").padding()
                        .foregroundColor(.red)
                        .font(.footnote)
                    Label("Energy: \(energy)", systemImage: "bolt.fill").padding(.horizontal, 7)
                        .foregroundColor(.orange)
                        .font(.footnote)
                    Label("Ginns: \(ginns)", systemImage: "g.circle.fill").padding()
                        .foregroundColor(Color("AccentColor-1"))
                        .font(.footnote)
                }
                .background(Color.gray.opacity(0.1))
                }
                .cornerRadius(13.0)
                }
                ForEach(articles, id: \.self){ article in
                    NavigationLink(destination: ArticleView(title: article.title, text: article.text, id: article.id)){
                        ArticleLink(authorName: article.author, authorImage: "author 1", title: article.title, text: article.text, publishDate: article.date, imageURL: article.imageURL, liked: true, likeCounter: article.likeCounter)
                           
                                .padding()
                           
                        }
                }
                
                Link(destination: URL(string: "https://www.youtube.com/watch?v=wj7n94wmrSs")!) {
                    ArticleLink(authorName: "Lisa Witherspoon:", authorImage: "author 2", title: "Splinterlands", text: "Watch exclusive stream", publishDate: Date.now, liked: false, likeCounter: 267)
               
                    .padding()
                }
                  
            }
            .frame(maxWidth: .infinity)
            .navigationTitle("Feed")
            .background(Color("Background"))
            .toolbar{
                ToolbarItem(placement: .primaryAction){
                Button(action: {createNewPost = true}, label: {Image(systemName: "plus.circle.fill")})
                    .popover(isPresented: $createNewPost){
                        NewPostView()
                    }
                }
            }
            .onAppear{
                Task{
                    do{
                        guard let url = URL(string: "http://192.168.50.168:8023/api/user/me/")
                        else
                        {
                            return
                        }
                        var request = URLRequest(url: url)
                        request.httpMethod = "GET"
                        request.addValue(token, forHTTPHeaderField: "x-api-key")
                        let (data, _) = try await URLSession.shared.data(from: url)
                        print(data)
                        
                        let jsonFeed = try JSONDecoder().decode(AuthorJSON.self, from: data)
                        print(jsonFeed)
                        pulse = Int(jsonFeed.pulse) ?? 0
                        energy = Int(jsonFeed.electricity) ?? 0
                        ginns = Int(jsonFeed.coin_balance) ?? 0
                        loading = false
                        
                    }
                }
            }
        }
       
       
      
    }
}
/*
struct Articles_Previews: PreviewProvider {
    static var previews: some View {
        Feed(articles: <#[Article]#>)
            .preferredColorScheme(.dark)
            .background(Color("Background"))
    }
}
*/
