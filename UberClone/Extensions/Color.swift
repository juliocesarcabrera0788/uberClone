//
//  Color.swift
//  UberClone
//
//  Created by Julio Cabrera on 2024-07-07.
//

import Foundation
import SwiftUI

extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let backgroundColor = Color("BackgroundColor")
    let secundaryBackgroundColor = Color("SecundaryBackgroundColor")
    let primaryTextColor = Color("PrimaryTextColor")
}
