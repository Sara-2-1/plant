//
//  Plant .swift
//  plantapp
//
//  Created by Sarah ali  on 21/04/1446 AH.
//

import Foundation

struct Plant: Identifiable {
    var id = UUID()
    var name: String
    var room: String
    var light: String
    var wateringDays: String
    var waterAmount: String
    var isChecked: Bool = false
}
