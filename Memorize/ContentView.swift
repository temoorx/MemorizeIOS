//
//  ContentView.swift
//  Memorize
//
//  Created by Mac on 25/06/2024.
//

import SwiftUI

struct ContentView: View {
    let emojis: Array<String> = ["👻","🎃","💀","🕷️","👻","🎃","💀","👻","🎃","💀",]
    @State var cardCount: Int = 4
    var body: some View {
        VStack {
            ScrollView{
                cards
            }
            HStack{
                cardRemover
                Spacer()
                cardAdder
                
            }
            .imageScale(.large)
            .font(.largeTitle)
        }
        .padding()
    }
    
    var cards : some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            ForEach(0..<cardCount, id: \.self){
              index in CardView(content: emojis[index])
                    .aspectRatio(2/3,contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
    }
    
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(action: {
            if cardCount < emojis.count{
            cardCount += offset
            }
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
    
    var cardAdder : some View{
        cardCountAdjuster(by: +1, symbol: "rectangle.stack.badge.plus.fill")
    }
    var cardRemover : some View {
        cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")

    }
}


struct CardView: View {
    let content: String
    @State var isFaceUp: Bool = false
    var body: some View {
        ZStack{
            let base = RoundedRectangle(cornerRadius: 12)
            Group{
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
                base.foregroundColor(.orange).opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
        
    }
}


#Preview {
    ContentView()
}
