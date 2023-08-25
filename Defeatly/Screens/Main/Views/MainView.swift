//
//  MainView.swift
//  Defeatly
//
//  Created by Pfriedrix on 22.08.2023.
//

import SwiftUI

struct MainView: View {
    var interactor: MainBusinessLogin?
    
    @ObservedObject var viewModel = MainViewModel()
    @State var showDatePicker = false
    
    var body: some View {
        VStack(spacing: 0) {
            content
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .overlay(alignment: .top) {
            header
        }
        .overlay(alignment: .top) {
            datePicker
        }
        .onAppear {
            interactor?.getLastDay()
        }
    }
    
    var header: some View {
        HStack {
            Button {
                
            } label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(.white)
                    .font(.system(size: 24, weight: .bold))
            }
            Spacer()
            Button {
                showDatePicker.toggle()
            } label: {
                Text("10 day")
                    .foregroundColor(.white)
                    .font(.system(size: 24, weight: .bold))
            }
            Spacer()
            Button {
                
            } label: {
                Image(systemName: "chevron.right")
                    .foregroundColor(.white)
                    .font(.system(size: 24, weight: .bold))
            }
        }
        .padding(.horizontal)
        .padding(.bottom)
        .frame(minWidth: 0, maxWidth: .infinity)
        .background {
            Color.brown
                .opacity(0.85)
                .cornerRadius(12, corners: [.bottomLeft, .bottomRight])
                .ignoresSafeArea()
                .shadow(radius: 12)
        }
        .offset(y: viewModel.showHeader ? 0 : -100)
        .animation(.easeOut(duration: 0.3), value: viewModel.showHeader)
    }
    
    var content: some View {
        VStack {
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    }
    
    var datePicker: some View {
        DatePicker(selection: $viewModel.day, in: viewModel.range, displayedComponents: .date) { }
            .datePickerStyle(.graphical)
            .frame(width: 290)
            .frame(maxHeight: 250)
            .padding(.top)
            .padding(.bottom, 24)
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

#if DEBUG
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .previewDevice("iPhone 14")
        MainView()
            .previewDevice("iPhone 8")
    }
}
#endif
