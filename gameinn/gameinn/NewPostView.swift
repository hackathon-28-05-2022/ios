//
//  NewPostView.swift
//  gameinn
//
//  Created by Tema Sysoev on 29.05.2022.
//

import SwiftUI

struct NewPostView: View {
    @State private var title = ""
    @State private var text = "Text"
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Button(action: {}, label: {Text("Post")})
                    .buttonStyle(.bordered)
            }
        TextField("Title", text: $title)
                .font(.largeTitle)
                .padding(.top)
        TextEditor(text: $text)
                
        }
        .padding()
    }
}

struct NewPostView_Previews: PreviewProvider {
    static var previews: some View {
        NewPostView()
    }
}
