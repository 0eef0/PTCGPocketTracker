//
//  ContentView.swift
//  TCGP Tracker
//
//  Created by Ethan Roldan on 12/3/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    // Persistent storage variables
    @Environment(\.modelContext) private var modelContext
    @Query private var decks: [Deck]
    
    // Search bar string
    @State var searchDeck:String = ""
    
    // variables used to create decks
    @State var creatingDeck:Bool = false
    @State var deckName:String = ""
    
    // variables used for random deck functionality
    @State var showingRandom:Bool = false
    @State var randomDeck:Int = 0
    
    // boolean on showing stats sheet
    @State var showingStats:Bool = false

    var body: some View {
        NavigationStack {
            List {
                Section {
                    // decks filter by search string, or displays all decks if search string is empty
                    ForEach(decks.filter { deck in
                        searchDeck.isEmpty || deck.deckName.lowercased().contains(searchDeck.lowercased())
                    }
                    .sorted(by: { $0.timestamp < $1.timestamp }), id: \.id) { deck in
                        NavigationLink(destination: DeckView(deck: deck)) {
                            Text(deck.deckName)
                        }
                    }
                    .onDelete(perform: deleteDeck)
                }
            }
            .searchable(text: $searchDeck)
            .alert("Create Deck", isPresented: $creatingDeck, actions: {
                TextField("Deck Name", text: $deckName)
                    .disableAutocorrection(true)
                
                Button("Cancel", role: .cancel, action: {
                    creatingDeck = false
                })
                Button("Create Deck", action: {
                    let newDeck = Deck(deckName: deckName, wins: 0, losses: 0)
                    
                    modelContext.insert(newDeck)
                    
                    deckName = ""
                    
                    creatingDeck = false
                })
            })
            .alert(isPresented: $showingRandom) {
                 if decks.isEmpty {
                     return Alert(
                         title: Text("No decks available"),
                         message: Text("Please create a deck before starting."),
                         dismissButton: .default(Text("OK"))
                     )
                 } else {
                     return Alert(
                         title: Text("You will play \(decks[randomDeck].deckName)"),
                         message: nil,
                         dismissButton: .default(Text("Let's do it!"), action: {
                             showingRandom = false
                         })
                     )
                 }
             }
            .sheet(isPresented: $showingStats) {
                Stats(decks: decks)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        creatingDeck = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        randomDeck = Int.random(in: 0..<decks.count)
                        showingRandom = true
                    } label: {
                        Image(systemName: "dice")
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        showingStats = true
                    } label: {
                        Image(systemName: "chart.bar.horizontal.page")
                    }
                }
            }
            .navigationTitle("Decks")
        }
    }

    private func deleteDeck(at offsets: IndexSet) {
        for index in offsets {
            let deckToDelete = decks[index]
            modelContext.delete(deckToDelete)
        }

        do {
            try modelContext.save()
        } catch {
            print("Failed to delete deck: \(error)")
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Deck.self, inMemory: true)
}
