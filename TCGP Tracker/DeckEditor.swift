//
//  DeckEditor.swift
//  TCGP Tracker
//
//  Created by Ethan Roldan on 12/3/24.
//

import SwiftUI

struct DeckEditor: View {
    @Binding var deck:Deck
    
//    @State var expansion:String = ""
    
    var body: some View {
        ScrollView {
            ForEach(0..<20, id: \.self) { index in
                HStack {
                    TextField("Card \(index + 1)", text: $deck.deckList[index])
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .disableAutocorrection(true)
                    
//                    Picker(selection: $expansion, label: Text("Expansion")) {
//                        Text("[Expansion unset]").tag("none")
//                        Text("Promo").tag("promo")
//                        Text("Genetic Apex").tag("geneticApex")
//                    }
//                    .frame(width: UIScreen.main.bounds.width / 2)
                }

            }
        }
    }
}
