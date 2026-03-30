//
//  SecondaryButton.swift
//  CachiFriend
//
//  Created by Samuel Chavez on 29/03/26.
//

import SwiftUI

struct SecondaryButton: View {

    let label: String
    let disabled: Bool
    let action: () -> Void

    init(label: String,
         disabled: Bool = false,
         action: @escaping () -> Void) {
        self.label = label
        self.disabled = disabled
        self.action = action
    }

    var body: some View {
        Button(action: self.action) {
            Text(self.label)
                .foregroundStyle(Color.secondary)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .padding(.horizontal)
                .background(RoundedRectangle(cornerRadius: 10).stroke(self.disabled ? Color.tertiary.opacity(0.5) : Color.secondary))
        }
        .disabled(self.disabled)
    }
}

#Preview {
    Group {
        SecondaryButton(label: "Botón") {}
        SecondaryButton(label: "Botón", disabled: true) {}
    }.padding()
}
