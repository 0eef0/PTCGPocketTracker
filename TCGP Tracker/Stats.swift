//
//  Stats.swift
//  TCGP Tracker
//
//  Created by Ethan Roldan on 12/4/24.
//

import SwiftUI
import SwiftData

struct Stats: View {
    @State var decks:[Deck]
    
    @State var wins = 0;
    @State var losses = 0;
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 10) {
                HStack {
                    Spacer()
                    VStack {
                        Text(String(wins))
                            .font(.system(.title, design: .rounded))
                            .fontWeight(.bold)
                        Text("Wins")
                            .font(.system(.title, design: .rounded))
                            .fontWeight(.bold)
                            .foregroundStyle(.green)
                    }
                    Spacer()
                    VStack {
                        Text(String(losses))
                            .font(.system(.title, design: .rounded))
                            .fontWeight(.bold)
                        Text("Losses")
                            .font(.system(.title, design: .rounded))
                            .fontWeight(.bold)
                            .foregroundStyle(.red)
                    }
                    Spacer()
                }
                
                let ratio = losses == 0 ? "N/A" : String(format: "%.2f", Double(wins) / Double(losses))
                Text("W/L Ratio: \(ratio)")
                    .font(.system(.title, design: .rounded))
                    .fontWeight(.bold)
                
                Spacer()
            }
            .navigationTitle("Overall Stats")
            
            Spacer()
        }
        .presentationDetents([.height(275)])
        .presentationDragIndicator(.visible)
        .onAppear {
            for deck in decks {
                wins += deck.wins
                losses += deck.losses
            }
        }
    }
}
