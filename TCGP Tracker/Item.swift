//
//  Item.swift
//  TCGP Tracker
//
//  Created by Ethan Roldan on 12/3/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
