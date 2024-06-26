//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Mac on 26/06/2024.
//

import Foundation

struct MemorizeGame<CardContent>{
    var cards: Array<Card>
    
    func choose(card: Card){
    }
    
    struct Card{
        var isFaceUp: Bool
        var isMatched: Bool
        var content: CardContent
    }
}
