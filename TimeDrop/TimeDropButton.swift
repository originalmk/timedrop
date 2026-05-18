//
//  TimeDropButton.swift
//  TimeDrop
//
//  Created by Maciej Krzyżanowski on 18/05/2026.
//

import SwiftUI

struct TimeDropButton<V: View, S: PrimitiveButtonStyle>: View {
    let content: V
    let style: S
    let action: () -> Void
    let isDisabled: Bool
    
    init(style: S, content: () -> V, action: @escaping () -> Void, isDisabled: Bool) {
        self.content = content()
        self.style = style
        self.action = action
        self.isDisabled = isDisabled
    }
    
    init(style: S, content: () -> V, action: @escaping () -> Void) {
        self.init(style: style, content: content, action: action, isDisabled: false)
    }
    
    var body: some View {
        Button {
            self.action()
        } label: {
            content
                .padding(Edge.Set.horizontal, 10)
                .padding(Edge.Set.vertical, 5)
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(self.style)
        .disabled(self.isDisabled)
    }
    
    func disabled() -> Self {
        .init(style: self.style, content: { self.content }, action: self.action, isDisabled: true)
    }
}
