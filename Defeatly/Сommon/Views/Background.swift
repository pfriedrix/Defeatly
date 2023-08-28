//
//  Background.swift
//  Defeatly
//
//  Created by Pfriedrix on 28.08.2023.
//

import SwiftUI

struct Background: View {
    var body: some View {
        LinearGradient(colors: [.brown, .brown.opacity(0.9), .green], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
    }
}
