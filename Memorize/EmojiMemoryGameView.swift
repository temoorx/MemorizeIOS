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
    private let dealAnimation :Animation = .easeOut(duration: 1)
    private let dealInterval: TimeInterval = 0.15
    private let deckWidth: CGFloat = 50
    

    
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
                deck.foregroundColor(viewModel.color)
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
            card in 
            if isDealt(card){
                CardView(card)
                    .matchedGeometryEffect(id: card.id, in: dealingNameSpace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
                    .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
                    .zIndex(scoreChange(causedBy: card) != 0 ? 100: 0)
                    .padding(4)
                    .onTapGesture {
                        choose(card)
                    }
                  
            }
           
        }
            
    }
    
    @State private var dealt = Set<Card.ID>()
    
    private func isDealt (_ card: Card) -> Bool{
        dealt.contains(card.id)
    }
    
    private var undealtCard: [Card]{
        viewModel.cards.filter{!isDealt($0)}
    }
    
    @Namespace private var dealingNameSpace
    
    private var deck: some View{
        ZStack{
            ForEach(undealtCard){
                card in CardView(card)
                    .matchedGeometryEffect(id: card.id, in: dealingNameSpace)
                
            }
        }.frame(width: 50, height: deckWidth / aspectRatio)
            .onTapGesture {
              deal()
            }
    }
    
    private func deal(){
        var delay: TimeInterval = 0
        for card in viewModel.cards {
            withAnimation(dealAnimation.delay(delay)){
                _ = dealt.insert(card.id)
            }
            delay += dealInterval
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
