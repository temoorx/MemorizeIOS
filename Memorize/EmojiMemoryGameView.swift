//
//  ContentView.swift
//  Memorize
//
//  Created by Mac on 25/06/2024.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var viewModel: EmojisMemoryGame
    
    private let aspectRatio: CGFloat = 2/3
    
    var body: some View {
        
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
            
            cards
                .animation(.default, value: viewModel.cards)
                .padding()
            Button("Shuffle"){
                viewModel.shuffle()
            }
            
        }
    }
    
    private var cards : some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) {
            card in CardView(card)
                .aspectRatio(aspectRatio ,contentMode: .fit)
                .padding(4)
                .onTapGesture {
                    viewModel.choose(card)
                }
            
        }.foregroundColor(.orange)
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
            .opacity(card.isFaceUp || !card.isMatched ? 1: 0)
            
        }
    }
}

#Preview {
    EmojiMemoryGameView(
    viewModel: EmojisMemoryGame())
}
