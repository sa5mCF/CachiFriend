//
//  Card.swift
//  CachiFriend
//
//  Created by Samuel Chavez on 29/03/26.
//

import SwiftUI

struct BigCard: View {

    let loading: Bool
    let topText: String
    let bottomText: String
    let height: CGFloat
    let color: Color

    init(loading: Bool = false,
         topText: String,
         bottomText: String,
         height: CGFloat = 160,
         color: Color = .primary) {
        self.loading = loading
        self.bottomText = bottomText
        self.topText = topText
        self.height = height
        self.color = color
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(self.loading ? Color.tertiary.opacity(0.5) : self.color)
            VStack(alignment: .leading) {
                if self.loading {
                    Spacer()
                    ProgressView()
                        .tint(Color.white)
                    Spacer()
                } else {
                    Text(topText)
                        .foregroundStyle(Color.white)
                    Spacer()
                    HStack {
                        Spacer()
                        Text(bottomText)
                            .foregroundStyle(Color.white)
                    }
                }
            }
            .padding()
        }
        .frame(maxWidth: .infinity)
        .frame(height: height)
    }
}

#Preview {
    Group {
        BigCard(topText: "Tus ingresos", bottomText: "$ 10M")
        BigCard(loading: true, topText: "", bottomText: "")
    }.padding()
}
