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
        var result = "\(deckName)\n\n"
        
        var cardCounts: [String: Int] = [:]
        var orderOfAppearance: [String] = []
        
        let glossary:PKMNGlossary = PKMNGlossary()
        
        for i in 0..<deckListExpansions.count {
            let expansion = deckListExpansions[i]
            let id = deckListIDs[i]
            var key = ""
            
            if id > 0 {
                key = switch expansion {
                case "GeneticApex":
                    if id - 1 >= 0 && id - 1 < glossary.GeneticApex.count {
                        "\(glossary.GeneticApex[id - 1]) (Genetic Apex)"
                    } else {
                        "Card Not Found"
                    }
                case "PromoA":
                    if id - 1 >= 0 && id - 1 < glossary.PromoA.count {
                        "\(glossary.PromoA[id - 1]) (Promo A)"
                    } else {
                        "Card Not Found"
                    }
                case "MythicalIsland":
                    if id - 1 >= 0 && id - 1 < glossary.MythicalIsland.count {
                        "\(glossary.MythicalIsland[id - 1]) (Mythical Island)"
                    } else {
                        "Card Not Found"
                    }
                default:
                    "Card Not Found"
                }
            } else {
                key = "Card Not Found"
            }
            
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
