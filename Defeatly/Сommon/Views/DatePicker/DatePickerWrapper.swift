//
//  DatePickerWrapper.swift
//  Defeatly
//
//  Created by Pfriedrix on 27.08.2023.
//

import SwiftUI

struct DatePickerWrapper: View {
    @Binding var showDatePicker: Bool
    @Binding var day: Date
    @Binding var range: ClosedRange<Date>
    
    var body: some View {
        ZStack {
            VStack { }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background(.clear)
            .contentShape(Rectangle())
            .onTapGesture {
                showDatePicker = false
            }
            datePicker
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
        }
        .opacity(showDatePicker ? 1 : 0)
    }
    
    var datePicker: some View {
        DatePicker(selection: $day, in: range, displayedComponents: .date) { }
            .datePickerStyle(.graphical)
            .frame(width: 290)
            .padding(.horizontal, 12)
            .background(.regularMaterial)
            .cornerRadius(12)
            .shadow(radius: 12)
            .padding(.horizontal)
            .tint(.red)
            .scaleEffect(showDatePicker ? 1 : 0.1, anchor: .top)
            .opacity(showDatePicker ? 1 : 0)
            .offset(y: showDatePicker ? 60 : 30)
            .animation(.spring().speed(2.0), value: showDatePicker)
    }
}
