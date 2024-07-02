//
//  CardView.swift
//  Memorize
//
//  Created by Temoor on 01/07/2024.
//

import SwiftUI

struct CardView: View {
    typealias Card = MemorizeGame<String>
    
    let card: Card.Card
    
    init( _ card: Card.Card) {
        self.card = card
    }
   
    var body: some View {
        ZStack{
            
                Pie(endAngle: .degrees(180))
                    .opacity(0.4)
                    .overlay(Text(card.content)
                        .font(.system(size: 200))
                        .minimumScaleFactor(0.1)
                        .aspectRatio(1, contentMode: .fit))
                        .padding(5)
                        .rotationEffect(.degrees(card.isMatched ? 360:0))
                        .animation(.spin(duration: 1), value: card.isMatched)
                
            
        }
        .padding(5)
        .cardify(isFaceUp: card.isFaceUp)
        .opacity(card.isFaceUp || !card.isMatched ? 1: 0)
        
    }
   
    }

extension Animation {
    static func spin(duration: TimeInterval) -> Animation{
        .linear(duration: 1).repeatForever(autoreverses: false)
    }
}

#Preview {
     
    CardView(MemorizeGame<String>.Card(id: "test", content: "X"))
}
