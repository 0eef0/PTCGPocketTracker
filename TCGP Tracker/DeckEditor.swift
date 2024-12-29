//
//  DeckEditor.swift
//  TCGP Tracker
//
//  Created by Ethan Roldan on 12/3/24.
//

import SwiftUI

struct DeckEditor: View {
    @Binding var deck:Deck
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View {
        ScrollView {
            ForEach(0..<deck.deckListExpansions.count, id: \.self) { index in
                HStack {
                    Picker(selection: $deck.deckListExpansions[index], label: Text("Expansion")) {
                        Text("[Expansion unset]").tag("")
                        Text("Promo").tag("PromoA")
                        Text("Genetic Apex").tag("GeneticApex")
                        Text("Mythical Island").tag("MythicalIsland")
                    }
                    .frame(width: UIScreen.main.bounds.width / 2.25)
                    
                    TextField("Card \(index + 1)", value: $deck.deckListIDs[index], formatter: formatter)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.decimalPad)
                        .frame(width: UIScreen.main.bounds.width / 2.25)
                }
            }
        }
    }
}
