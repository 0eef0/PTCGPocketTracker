//
//  Stats.swift
//  TCGP Tracker
//
//  Created by Ethan Roldan on 12/4/24.
//

import SwiftUI
import SwiftData

struct Stats: View {
    @State var decks: [Deck]
    
    @State var bestDeck: Deck = Deck(deckName: "", wins: -1, losses: 1)
    @State var worstDeck: Deck = Deck(deckName: "", wins: -1, losses: 1)
    @State var wins = 0
    @State var losses = 0
    
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
                
                let bestWinLossRatio = Double(bestDeck.wins) / Double(bestDeck.losses)
                let worstWinLossRatio = Double(worstDeck.wins) / Double(worstDeck.losses)

                let bestRatioString = String(format: "%.2f", bestWinLossRatio)
                let worstRatioString = String(format: "%.2f", worstWinLossRatio)

                Text("Best Deck: \(bestDeck.deckName) (\(bestRatioString))")
                    .font(.body)
                    .fontWeight(.bold)

                Text("Worst Deck: \(worstDeck.deckName) (\(worstRatioString))")
                    .font(.body)
                    .fontWeight(.bold)
                
                Spacer()
            }
            .navigationTitle("Overall Stats")
            
            Spacer()
        }
        .presentationDetents([.height(325)])
        .presentationDragIndicator(.visible)
        .onAppear {
            var totalWins = 0
            var totalLosses = 0
            var localBestDeck: Deck? = nil
            var localWorstDeck: Deck? = nil
            
            for deck in decks {
                totalWins += deck.wins
                totalLosses += deck.losses
                
                let currentDeckRatio = Double(deck.wins) / Double(deck.losses)
                
                if let best = localBestDeck {
                    if currentDeckRatio > Double(best.wins) / Double(best.losses) {
                        localBestDeck = deck
                    }
                } else {
                    localBestDeck = deck
                }
                
                if let worst = localWorstDeck {
                    if currentDeckRatio < Double(worst.wins) / Double(worst.losses) {
                        localWorstDeck = deck
                    }
                } else {
                    localWorstDeck = deck
                }
            }
            
            if let bestDeck = localBestDeck {
                self.bestDeck = bestDeck
            }
            if let worstDeck = localWorstDeck {
                self.worstDeck = worstDeck
            }
            self.wins = totalWins
            self.losses = totalLosses
        }
    }
}
