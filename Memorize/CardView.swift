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
            TimelineView(.animation) { timeline in
                if card.isFaceUp || !card.isMatched {
                    Pie(endAngle: .degrees(card.bonusPercentRemaining * 360))
                            .opacity(0.4)
                            .overlay{
                                cardContents.padding(5)
                            }
                            .padding(5)
                            .cardify(isFaceUp: card.isFaceUp)
                            .transition(.opacity)
                } else{
                    Color.clear
                }
            }
           
                
            
        }
        
        
    }
        var cardContents: some View{
            Text(card.content)
                .font(.system(size: 200))
                .minimumScaleFactor(0.1)
                .aspectRatio(1, contentMode: .fit)
                .rotationEffect(.degrees(card.isMatched ? 360:0))
                .animation(.spin(duration: 1), value: card.isMatched)
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
