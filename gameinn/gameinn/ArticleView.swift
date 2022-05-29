//
//  ArticleView.swift
//  gameinn
//
//  Created by Tema Sysoev on 28.05.2022.
//

import SwiftUI
struct Article: Hashable{
    let title: String
    let text: String
    
    let id: Int
    let author: String
    let likeCounter: Int
    
    let date: Date
    let imageURL: String?
}
struct AdJSON: Codable{
    let id: Int
    let url: String
    let image: String
    let view_count: Int
    let owner: AuthorJSON
    let created_at: String
}
struct Ad: Codable{
    let id: Int
    let url: String
    let image: String
   
}
struct ArticleView: View {
    @State private var loading = true
    @State public var title: String
    @State public var text: String
    @State public var imageURL: String?
    @State public var id: Int
    @State private var liked = false
    @State private var disliked = false
    
    @State private var showLikeAlert = false
    @State private var showDislikeAlert = false
    
    @State private var comments = [Comments]()
    @State private var ads = [Ad]()
    private func loadComments(){
        Task{
            do{
                guard let url = URL(string: "http://192.168.50.168:8023/api/comments/\(id)")
                else
                {
                    return
                }
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                request.addValue(token, forHTTPHeaderField: "x-api-key")
                let (data, _) = try await URLSession.shared.data(from: url)
                print(data)
                
                let jsonFeed = try JSONDecoder().decode(CommentsJSON.self, from: data)
                print(jsonFeed)
                for comment in jsonFeed.results{
                    comments.append(Comments(text: comment.body, author: comment.author.username, likeCounter: comment.likes_count, dislikeCounter: comment.dislikes_count))
                }
            }
         catch {
            print(error)
        }
            loading = false
        }
    }
    private func loadAd(){
        Task{
            do{
                guard let url = URL(string: "http://192.168.50.168:8023/api/advert/list/")
                else
                {
                    return
                }
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                request.addValue(token, forHTTPHeaderField: "x-api-key")
                let (data, _) = try await URLSession.shared.data(from: url)
                print(data)
                
                let jsonFeed = try JSONDecoder().decode([AdJSON].self, from: data)
                print(jsonFeed)
                for ad in jsonFeed {
                    ads.append(Ad(id: ad.id, url: ad.url, image: ad.image))
                }
            }
         catch {
            print(error)
        }
            loading = false
        }
    }
    var body: some View {
        VStack(alignment: .center){
        ScrollView(.vertical){
        
      
            AsyncImage(url: URL(string: imageURL ?? "https://cdn.vox-cdn.com/thumbor/JYWQ5Ep1Qrd4BJMry4Mr4cLyWlM=/0x0:1456x747/1820x1213/filters:focal(612x258:844x490):format(webp)/cdn.vox-cdn.com/uploads/chorus_image/image/69990832/https___bucketeer_e05bbc84_baa3_437e_9518_adb32be77984.s3.amazonaws.com_public_images_418f3acf_2d81_4f05_ad62_2c875ec2c33f_4463x2289.0.png")) { image in
                image.resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
              
                .frame(maxWidth: .infinity)
        Text(text)
                .padding()
            .multilineTextAlignment(.leading)
            .lineLimit(nil)
            
            if !ads.isEmpty{
                HStack{
                Text("Ad")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
            Link(destination: URL(string: ads[0].url)!, label: {
                
                AsyncImage(url: URL(string: ads[0].image)) { image in
                    image.resizable()
                        .scaledToFill()
                        .onAppear{
                            do{
                                guard let url = URL(string: "http://192.168.50.168:8023/api/advert/add_view/\(ads[0].id)/")
                                else
                                {
                                    return
                                }
                                var request = URLRequest(url: url)
                                request.httpMethod = "GET"
                                request.addValue(token, forHTTPHeaderField: "x-api-key")
                            }
                        }
                } placeholder: {
                    ProgressView()
                }
                .padding(.horizontal)
                
               
                    .frame(maxWidth: .infinity)
            })
            }
            HStack{
            Text("Comments:")
                .bold()
                .padding(.horizontal)
                .font(.title)
                Spacer()
            }
            
            if loading {
                ProgressView()
            } else{
            ForEach(comments, id: \.self){ comment in
                CommentsView(author: comment.author, text: comment.text, likeCounter: comment.likeCounter, dislikeCounter: comment.dislikeCounter)
            }
            }
        }
        .onAppear{
            loadAd()
            loadComments()
            
        }
       
           
           
            
        }
        .alert("You will lose -1 ⚡️", isPresented: $showLikeAlert) {
            Button("Like", role: .destructive){
                do{
                    guard let url = URL(string: "http://192.168.50.168:8023/api/posts/like/\(id)")
                    else
                    {
                        return
                    }
                    
                    var request = URLRequest(url: url)
                    request.httpMethod = "GET"
                    request.addValue(token, forHTTPHeaderField: "x-api-key")
                    liked = true
                }
               
            }
            Button("Cancel", role: .cancel){
                showLikeAlert = false
            }
               }
        .alert("You will lose -1 ⚡️", isPresented: $showDislikeAlert) {
            Button("Dislike", role: .destructive){
                do{
                    guard let url = URL(string: "http://192.168.50.168:8023/api/posts/dislike/\(id)")
                    else
                    {
                        return
                    }
                    
                    var request = URLRequest(url: url)
                    request.httpMethod = "GET"
                    request.addValue(token, forHTTPHeaderField: "x-api-key")
                    disliked = true
                }
            }
            Button("Cancel", role: .cancel){
                showDislikeAlert = false
            }
               }
        .frame(maxWidth: .infinity)
        .background(Color("Background"))
        .navigationTitle(title)
        .toolbar{
            ToolbarItem(placement: .bottomBar){
                HStack{
                    Spacer()
                    
                    Button(action: {
                        showLikeAlert = true
                    }, label: {
                      
                       
                            Image(systemName: liked ? "heart.fill":"heart")
                                .foregroundColor(.accentColor)
                     
                        
                      
                    })
                   
                   
                    Spacer()
                          
                                
                    
                    Button(action: {
                        
                    }, label: {
                        Label{
                            Text("Comment")
                        } icon: {
                            Image(systemName: "bubble.right")
                              
                        }
                        
                        .foregroundColor(.gray)
                       
                        
                       
                    })
                    Spacer()
                    Button(action: {
                      showDislikeAlert = true
                    }, label: {
                        Label{
                            Text("Dislike")
                        } icon: {
                            Image(systemName: disliked ? "heart.slash.fill":"heart.slash")
                              
                        }
                        
                        .foregroundColor(.gray)
                       
                        
                       
                    })
                    Spacer()
                  
                      
                    
            }
                .disabled(liked || disliked)
            }
        }
        
    }
}

struct ArticleView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleView(title: "Axie inifinity", text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", id: 1)
    }
}
