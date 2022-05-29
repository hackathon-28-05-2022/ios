//
//  ArticleLink.swift
//  gameinn
//
//  Created by Tema Sysoev on 28.05.2022.
//

import SwiftUI
import YouTubePlayerKit
struct ArticleLink: View {
    
    @State public var authorName: String
    @State public var authorImage: String

    @State public var title: String
    @State public var text: String
    @State public var publishDate: Date
    @State public var imageURL: String?
    @State public var liked: Bool
    @State public var likeCounter: Int
    
    @State private var image = Image("")
  
    let dateFormatter = DateFormatter()
    
    
    var body: some View {
        VStack(alignment: .leading){
            
            Label{
               Text(authorName)
                    .font(.footnote)
                    .foregroundColor(.primary)
            } icon: {
                Image(systemName: "person.circle")
                    .resizable()
                    
                    .frame(width: 30, height: 30)
                    .cornerRadius(15.0)
            }
           
        VStack(){
            AsyncImage(url: URL(string: imageURL ?? "https://cdn.vox-cdn.com/thumbor/JYWQ5Ep1Qrd4BJMry4Mr4cLyWlM=/0x0:1456x747/1820x1213/filters:focal(612x258:844x490):format(webp)/cdn.vox-cdn.com/uploads/chorus_image/image/69990832/https___bucketeer_e05bbc84_baa3_437e_9518_adb32be77984.s3.amazonaws.com_public_images_418f3acf_2d81_4f05_ad62_2c875ec2c33f_4463x2289.0.png")) { image in
                image.resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
           
               
                .frame(height: 200)
                .frame(maxWidth: 350)
            
            
            HStack{
            VStack(alignment: .leading){
        
            Text(title)
                    .foregroundColor(.white)
                    .bold()
                    .padding(.horizontal, 12)
                   
            Text(text)
                    .foregroundColor(.white)
                    .font(.footnote)
                    .padding(.horizontal, 12)
                    .lineLimit(1)
                                .multilineTextAlignment(.leading)
                                .fixedSize(horizontal: false, vertical: true)
        
        }
                Spacer()
                HStack{
                    
                      Text("\(likeCounter)")
                          .font(.footnote)
                          .foregroundColor(Color.white)
                    
                        Image(systemName: liked ? "heart.fill":"heart")
                            .foregroundColor(.white)
                   
                  
                  
                        
                }
                .padding()
            }
          
                
            .frame(height: 60)
            .frame(maxWidth: 350)
            .background(Color.accentColor)
            
            .padding(.top, -10)
        }
        .cornerRadius(13.0)
        .shadow(radius: 3.0)
        .frame(maxWidth: 350, maxHeight: 280)
    }
        .onAppear{
            dateFormatter.dateStyle = .short
        }
      
    }
}

struct ArticleLink_Previews: PreviewProvider {
    static var previews: some View {
        ArticleLink(authorName: "John Appleseed:", authorImage: "author 1", title: "Axie Infinity", text: "New game event!", publishDate: Date.now, liked: true, likeCounter: 1376)
            .preferredColorScheme(.dark)
            .background(Color("Background"))
           
    }
}
