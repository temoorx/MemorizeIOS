//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Mac on 26/06/2024.
//

import Foundation

struct MemorizeGame<CardContent> where CardContent: Equatable{
    private(set) var cards: Array<Card>
    private(set) var score = 0
    
    init(numberOfPairsOfCard: Int, cardContentFactory: (Int)-> CardContent){
        cards = []
        
        for pairIndex in 0..<max(2,numberOfPairsOfCard){
            let content = cardContentFactory(pairIndex)
            cards.append(Card(id: "\(pairIndex+1)a", content: content))
            cards.append(Card(id: "\(pairIndex+1)b", content: content))
        }
    }
    
    var indexofOnlyFaceUpCard: Int?{
        get { cards.indices.filter{index in cards[index].isFaceUp}.only
        }
        set{ cards.indices.forEach{ cards[$0].isFaceUp = (newValue == $0)}
        }
    }
    
    mutating func choose(_ card: Card){
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched{
                if let potentialMatchIndex = indexofOnlyFaceUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content{
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                        score += 2
                    }else{
                        if cards[chosenIndex].hasBeenSeen{
                            score -= 1
                        }
                        if cards[potentialMatchIndex].hasBeenSeen{
                            score -= 1
                        }
                    }
                }
                else{
                    indexofOnlyFaceUpCard = chosenIndex
                }
                
            }
            
            cards[chosenIndex].isFaceUp = true
        }
        
    }
    
    
    mutating func shuffle(){
        cards.shuffle()
    }
    
    struct Card : Equatable, Identifiable{
        var id: String
        
        var isFaceUp = false {
            didSet{
                if oldValue && !isFaceUp {
                    hasBeenSeen = true
                }
            }
        }
        var hasBeenSeen = false
        var isMatched = false
        var content: CardContent
    }
}

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
