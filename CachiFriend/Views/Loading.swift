//
//  Loading.swift
//  CachiFriend
//
//  Created by Samuel Chavez on 29/03/26.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            Spacer()
            ProgressView()
                .tint(Color.primary)
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color.dark.opacity(0.4))
    }
}

#Preview {
    LoadingView()
}
