//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Mac on 26/06/2024.
//

import Foundation

struct MemorizeGame<CardContent>{
    private(set) var cards: Array<Card>
    
    init(numberOfPairsOfCard: Int, cardContentFactory: (Int)-> CardContent){
        cards = []
        
        for pairIndex in 0..<max(2,numberOfPairsOfCard){
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    func choose(_ card: Card){
    }
    
    mutating func shuffle(){
        cards.shuffle()
    }
    
    struct Card{
        var isFaceUp = true
        var isMatched = false
        var content: CardContent
    }
}
