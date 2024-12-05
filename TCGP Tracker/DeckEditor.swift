//
//  DeckEditor.swift
//  TCGP Tracker
//
//  Created by Ethan Roldan on 12/3/24.
//

import SwiftUI

struct DeckEditor: View {
    @Binding var deck:Deck
    
    var body: some View {
        ScrollView {
            ForEach(0..<20, id: \.self) { index in
                TextField("Card \(index + 1)", text: $deck.deckList[index])
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .disableAutocorrection(true)
            }
        }
    }
}
