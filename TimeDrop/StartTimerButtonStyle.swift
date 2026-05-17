//
//  StartTimerButtonStyle.swift
//  TimeDrop
//
//  Created by Maciej Krzyżanowski on 17/05/2026.
//

import SwiftUI

struct StartTimerButtonStyle: PrimitiveButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(10)
            .background(Color.accentColor)
            .foregroundColor(.white)
            .cornerRadius(10)
    }
}
