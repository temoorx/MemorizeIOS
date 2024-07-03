//
//  ContentView.swift
//  Memorize
//
//  Created by Mac on 25/06/2024.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var viewModel: EmojisMemoryGame
    
    typealias Card = MemorizeGame<String>.Card

    private let aspectRatio: CGFloat = 2/3
    

    
    var body: some View {
        
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
            
            cards
                .foregroundColor(viewModel.color)
                .padding()
            HStack {
                Text("Score: \(viewModel.score)").animation(nil)
                Spacer()
                Button("Shuffle"){
                    withAnimation{
                        viewModel.shuffle()
                    }
                    
                }
            }
            .font(.largeTitle)
            .padding()
            
        }
      
    }
    
    private var cards : some View {
        AspectVGrid(viewModel.cards, aspectRatio: aspectRatio) {
            card in CardView(card)
                .aspectRatio(aspectRatio ,contentMode: .fit)
                .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                .zIndex(scoreChange(causedBy: card) != 0 ? 100: 0)
                .padding(4)
                .onTapGesture {
                    choose(card)
                    
                }
        }
            
        }
        private func choose(_ card: Card){
            withAnimation(){
                let scoreBeforeChoosing = viewModel.score
                viewModel.choose(card)
                let scoreChange = viewModel.score - scoreBeforeChoosing
                lastScoreChange = (scoreChange, causedByCardId: card.id)
            }
        }
        
        @State private var lastScoreChange = (0, causedByCardId: "")
        
         private func scoreChange(causedBy card: Card) -> Int{
            let (amount, id) = lastScoreChange
            return card.id == id ? amount : 0
        }
        
    }
    
    

#Preview {
    EmojiMemoryGameView(
    viewModel: EmojisMemoryGame())
}
