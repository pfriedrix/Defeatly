//
//  CellView.swift
//  Defeatly
//
//  Created by Pfriedrix on 27.08.2023.
//

import SwiftUI

struct CellView: View {
    let name: String
    let value: Int
    let prev: Int?
    
    var body: some View {
        HStack(spacing: 0) {
            Image(name)
                .renderingMode(.template)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25)
                .foregroundColor(.white)
                .padding(8)
                .background(Circle().fill(.black.opacity(0.5)))
                .padding(.vertical, 8)
            Text(name.uppercased())
                .font(.subheadline)
                .bold()
                .foregroundColor(.white)
                .padding(.horizontal)
            Spacer()
            HStack(alignment: .top, spacing: 2) {
                Text("\(value)")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.white)
                if let prev = prev {
                    Text("+\(abs(value - prev))")
                        .font(.system(size: 12))
                        .foregroundColor(.black.opacity(0.3))
                } else {
                    // make personnel text jumping from none prev and prev
                    Text("000")
                        .opacity(0)
                }
            }
        }
        .padding(.horizontal)
        .frame(minWidth: 0, maxWidth: .infinity)
        .background(.thinMaterial)
        .cornerRadius(12)
        .padding(.horizontal)
        .shadow(radius: 2)
        .padding(.top)
        .preferredColorScheme(.dark)
    }
}
