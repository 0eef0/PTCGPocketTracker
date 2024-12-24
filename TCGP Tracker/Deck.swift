//
//  Deck.swift
//  TCGP Tracker
//
//  Created by Ethan Roldan on 12/3/24.
//

import Foundation
import SwiftData
import SwiftUI

@Model
final class Deck {
    var id = UUID()
    var deckName:String
    var deckListIDs:[Int]
    var deckListExpansions:[String]
    var wins:Int
    var losses:Int
    var lastResult:String
    var timestamp:Date
    
    init(deckName: String, wins: Int, losses: Int) {
        self.deckName = deckName
        self.deckListIDs = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        self.deckListExpansions = ["","","","","","","","","","","","","","","","","","","",""]
        self.wins = wins
        self.losses = losses
        self.lastResult = ""
        self.timestamp = Date()
    }
    
    func win() {
        self.wins += 1
        self.lastResult = "w"
    }
    func lose() {
        self.losses += 1
        self.lastResult = "l"
    }
    func undo() {
        if(self.lastResult == "w") {
            self.wins -= 1
        } else {
            self.losses -= 1
        }
    }
    func deckListString() -> String {
        var result = "\(deckName)\n"
        
        var cardCounts: [String: Int] = [:]
        var orderOfAppearance: [String] = []
        
        for i in 0..<deckListExpansions.count {
            let expansion = deckListExpansions[i]
            let id = deckListIDs[i]
            let key = "\(expansion) \(id)"
            
            if cardCounts[key] == nil {
                orderOfAppearance.append(key)
            }
            
            cardCounts[key, default: 0] += 1
        }
        
        for key in orderOfAppearance {
            let count = cardCounts[key]!
            if count > 1 {
                result += "\(key) x\(count)\n"
            } else {
                result += "\(key)\n"
            }
        }
        
        return result
    }
}
