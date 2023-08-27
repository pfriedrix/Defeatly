//
//  MainView.swift
//  Defeatly
//
//  Created by Pfriedrix on 22.08.2023.
//

import SwiftUI

struct MainView: View {
    var interactor: MainBusinessLogic?
    
    @ObservedObject var viewModel = MainViewModel()
    @State var showDatePicker = false
    
    var body: some View {
        VStack(spacing: 0) {
            header
            content
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(
            LinearGradient(colors: [.brown, .brown.opacity(0.8), .white], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
        )
        .overlay {
            DatePickerWrapper(showDatePicker: $showDatePicker, day: $viewModel.day, range: $viewModel.range)
                .onChange(of: viewModel.day) { newDay in
                    updateDay(by: newDay)
                }
        }
        .onAppear {
            interactor?.getLimits()
        }
    }
    
    var content: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 0) {
                itemsView
            }
        }
        .offset(y: viewModel.showContent ? 0 : 1000)
        .animation(.easeOut(duration: 0.5), value: viewModel.showContent)
    }
    
    var header: some View {
        HStack {
            Button {
                if let prev = Calendar.current.date(byAdding: .day, value: -1, to: viewModel.day) {
                    viewModel.day = prev
                }
            } label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(viewModel.model == nil ? .white.opacity(0.5) : .white)
                    .font(.system(size: 24, weight: .bold))
            }
            .disabled(viewModel.model == nil)
            
            Spacer()
            
            if let model = viewModel.model {
                Button {
                    showDatePicker.toggle()
                } label: {
                    Text("\(model.day) day")
                        .foregroundColor(.white)
                        .font(.system(size: 24, weight: .bold))
                }
                .buttonStyle(.plain)
            }
            
            Spacer()
            
            Button {
                if let next = Calendar.current.date(byAdding: .day, value: 1, to: viewModel.day) {
                    viewModel.day = next
                }
            } label: {
                Image(systemName: "chevron.right")
                    .foregroundColor(viewModel.disableNextButton ? .white.opacity(0.5) : .white)
                    .font(.system(size: 24, weight: .bold))
            }
            .disabled(viewModel.disableNextButton)
        }
        .padding(.horizontal)
        .padding(.bottom)
        .frame(minWidth: 0, maxWidth: .infinity)
        .background(
            Color.brown
                .opacity(0.85)
                .cornerRadius(12, corners: [.bottomLeft, .bottomRight])
                .ignoresSafeArea()
                .shadow(radius: 4)
        )
        .offset(y: viewModel.showContent ? 0 : -100)
        .animation(.easeOut(duration: 0.3), value: viewModel.showContent)
    }
    
    var itemsView: some View {
        VStack(spacing: 0) {
            ForEach(MainModel.CodingKeys.allCases, id: \.self) { type in
                if let value = viewModel.getValue(by: type, viewModel.model) {
                    CellView(name: type.rawValue, value: value, prev: viewModel.getValue(by: type, viewModel.prevModel))
                }
            }
        }
        .padding(.bottom)
        .opacity(viewModel.showContent ? 1 : 0)
    }
    
    private func updateDay(by day: Date) {
        interactor?.getByDay(by: day, isPrevDay: false)
        viewModel.prevModel = nil
    }
}
