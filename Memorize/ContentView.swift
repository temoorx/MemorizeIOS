//
//  ContentView.swift
//  Memorize
//
//  Created by Mac on 25/06/2024.
//

import SwiftUI

struct ContentView: View {
    let emojis: Array<String> = ["👻","🎃","💀","🕷️"]
    var body: some View {
        HStack {
            ForEach(emojis.indices, id: \.self){
              index in CardView(content: emojis[index])
            }
        }
        .padding()
        .foregroundColor(.orange)
    }
}


struct CardView: View {
    let content: String
    @State var isFaceUp: Bool = false
    var body: some View {
        ZStack{
            let base = RoundedRectangle(cornerRadius: 12)
            if isFaceUp{
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            else{
               base.foregroundColor(.orange)
            }
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
        
    }
}


#Preview {
    ContentView()
}
