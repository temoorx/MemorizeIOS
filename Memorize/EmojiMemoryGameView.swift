//
//  ContentView.swift
//  Memorize
//
//  Created by Mac on 25/06/2024.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojisMemoryGame
    var body: some View {
        
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
            ScrollView{
                    cards
            }    .padding()
            Button("Shuffle"){
                viewModel.shuffle()
            }
        
        }
    }
    
    var cards : some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
            ForEach(viewModel.cards.indices, id: \.self){
                index in CardView(viewModel.cards[index])
                    .aspectRatio(2/3,contentMode: .fit)
                    .padding(4)
            }
        }
        .foregroundColor(.orange)
    }
    
//    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
//        Button(action: {
//            if cardCount < emojis.count{
//            cardCount += offset
//            }
//        }, label: {
//            Image(systemName: symbol)
//        })
//        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
//    }
//    
//    var cardAdder : some View{
//        cardCountAdjuster(by: +1, symbol: "rectangle.stack.badge.plus.fill")
//    }
//    var cardRemover : some View {
//        cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
//
//    }
}


struct CardView: View {
    let card: MemorizeGame<String>.Card
    init( _ card: MemorizeGame<String>.Card) {
        self.card = card
    }
    var body: some View {
        ZStack{
            let base = RoundedRectangle(cornerRadius: 12)
            Group{
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.1)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base.fill()
                .opacity(card.isFaceUp ? 0 : 1)
        }
        
    }
}


#Preview {
    EmojiMemoryGameView(
    viewModel: EmojisMemoryGame())
}
