//
//  Comment.swift
//  gameinn
//
//  Created by Tema Sysoev on 29.05.2022.
//

import SwiftUI
import Foundation

struct Comments: Hashable{

    let text: String
    let author: String
    
    let likeCounter: Int
    let dislikeCounter: Int
}
struct CommentsJSON: Codable{
    let count: Int
    let next: String?
    let previous: String?
    
    let results: [CommentsResultJSON]
}

struct CommentsResultJSON: Codable{
    let body: String
    let author: AuthorJSON
    let created_at: String
    let dislikes_count: Int
    let likes_count: Int
    let id: Int
}

struct CommentsView: View {
    @State public var author: String
    @State public var text: String
    
    @State public var likeCounter: Int
    @State public var dislikeCounter: Int
    @State private var liked = false
    @State private var disliked = false
    var body: some View {
        
        ZStack{
        VStack(alignment: .leading){
            HStack{
               Text(author)
                .bold()
                    .font(.footnote)
                    .foregroundColor(.primary)
                Spacer()
                Text("\(likeCounter) likes / \(dislikeCounter) dislikes")
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            Text(text)
                .font(.footnote)
            HStack{
                Spacer()
                
                Button(action: {
                   
                }, label: {
                  
                    Label{
                        Text(" Like  ")
                    } icon: {
                        Image(systemName: liked ? "heart.fill":"heart")
                           
                    }
                    .labelStyle(.iconOnly)
                    .imageScale(.small)
                    
                  
                })
               
                .foregroundColor(.gray)
              
                 
                Spacer()
                Button(action: {
                    
                }, label: {
                    Label{
                        Text("Dislike")
                    } icon: {
                        Image(systemName: disliked ? "heart.slash.fill":"heart.slash")
                          
                    }
                    .labelStyle(.iconOnly)
                    .foregroundColor(.gray)
                    .imageScale(.small)
                    
                   
                })
                Spacer()
              
                  
                
        }
            .padding(.top, 6)
        }
        .padding()
        .background(.thinMaterial)
        }
      
        .cornerRadius(13.0)
        .padding([.horizontal, .bottom])
    }
}

struct Comment_Previews: PreviewProvider {
    static var previews: some View {
        CommentsView(author: "", text: "", likeCounter: 0, dislikeCounter: 0)
    }
}
