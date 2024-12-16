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
}
