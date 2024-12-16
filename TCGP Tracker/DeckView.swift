//
//  DeckView.swift
//  TCGP Tracker
//
//  Created by Ethan Roldan on 12/3/24.
//

import SwiftUI
import SwiftData

struct DeckView: View {
    @State var deck:Deck
    
    let gridItems = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationStack {
            Divider()
            
            VStack(spacing: 10) {
                HStack {
                    Spacer()
                    VStack {
                        Text(String(deck.wins))
                            .font(.system(.title, design: .rounded))
                            .fontWeight(.bold)
                        Text("Wins")
                            .font(.system(.title, design: .rounded))
                            .fontWeight(.bold)
                            .foregroundStyle(.green)
                    }
                    Spacer()
                    VStack {
                        Text(String(deck.losses))
                            .font(.system(.title, design: .rounded))
                            .fontWeight(.bold)
                        Text("Losses")
                            .font(.system(.title, design: .rounded))
                            .fontWeight(.bold)
                            .foregroundStyle(.red)
                    }
                    Spacer()
                }
                
                let ratio = deck.losses == 0 ? "N/A" : String(format: "%.2f", Double(deck.wins) / Double(deck.losses))
                Text("W/L Ratio: \(ratio)")
                    .font(.system(.title, design: .rounded))
                    .fontWeight(.bold)
                
                HStack {
                    Button {
                        deck.win()
                    } label: {
                        Text("Win")
                            .font(.system(.body, design: .rounded))
                            .fontWeight(.bold)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    Button {
                        deck.lose()
                    } label: {
                        Text("Lose")
                            .font(.system(.body, design: .rounded))
                            .fontWeight(.bold)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    Button {
                        deck.undo()
                    } label: {
                        Text("Undo")
                            .font(.system(.body, design: .rounded))
                            .fontWeight(.bold)
                            .padding()
                            .background(Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
            .navigationTitle(deck.deckName)
            
            Spacer()
            
            ScrollView {
                LazyVGrid(columns: gridItems, spacing: 10) {
                    ForEach(0..<20, id: \.self) { index in
                        if let uiImage = UIImage(named: "\(deck.deckListExpansions[index])_\(String(format: "%03d", deck.deckListIDs[index]))") {
                            Image(uiImage: uiImage)
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.main.bounds.width / 2.25)
                                .clipped()
                        } else {
                            Text("No Card Found")
                                .padding(.vertical, UIScreen.main.bounds.width / 2.25 * 1.4 / 2)
                        }
                    }
                    
//                    ForEach(0..<20, id: \.self) { index in
//                        HStack {
//                            TextField("Card \(index + 1)", value: $deck.deckListIDs[index].cardID, formatter: formatter)
//                                .textFieldStyle(RoundedBorderTextFieldStyle())
//                                .keyboardType(.decimalPad)
//                            
//                            Picker(selection: $deck.deckListExpansions[index].cardExpansion, label: Text("Expansion")) {
//                                Text("[Expansion unset]").tag("")
//                                Text("Promo").tag("PromoA")
//                                Text("Genetic Apex").tag("GeneticApex")
//                            }
//                            .frame(width: UIScreen.main.bounds.width / 2)
//                        }
//                    }
                }
                .padding()
            }
            
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: DeckEditor(deck: $deck)) {
                        Text("Edit Deck")
                    }
                }
            }
        }
    }
}
