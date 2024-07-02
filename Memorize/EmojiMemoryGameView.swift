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
                .padding(4)
                .onTapGesture {
                    withAnimation(){
                        viewModel.choose(card)
                    }
                    
                }
            
        }
    }
    
    
    

}

#Preview {
    EmojiMemoryGameView(
    viewModel: EmojisMemoryGame())
}
