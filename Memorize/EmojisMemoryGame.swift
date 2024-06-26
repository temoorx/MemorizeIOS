//
//  EmojisMemoryGame.swift
//  Memorize
//
//  Created by Mac on 26/06/2024.
//

import SwiftUI

class EmojisMemoryGame: ObservableObject{
    private static let emojis = ["👻","🎃","💀","🕷️","👻","🎃","💀","👻","🎃","💀",]
    
    private static func createMemoryGame() -> MemorizeGame<String>{
        return MemorizeGame(numberOfPairsOfCard: 6) { pairIndex in
            
            if emojis.indices.contains(pairIndex){
                return emojis[pairIndex]
            }else{
                return "⁉️"
            }
          
        }
    }
    
    @Published private var model = createMemoryGame()
   
    
    var cards: Array<MemorizeGame<String>.Card>{
        return model.cards
    }
    
    func shuffle(){
        model.shuffle()
    }
    
    func choose(_ card: MemorizeGame<String>.Card){
        model.choose(card)
    }
    
}
    
