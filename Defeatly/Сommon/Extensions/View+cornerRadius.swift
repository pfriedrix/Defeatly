//
//  View+cornerRadius.swift
//  Defeatly
//
//  Created by Pfriedrix on 22.08.2023.
//

import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
}
