//
//  DetailView.swift
//  Defeatly
//
//  Created by Pfriedrix on 27.08.2023.
//

import SwiftUI
import Charts

struct DetailView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var viewModel = DetailViewModel()
    var interactor: DetailBusinessLogic?
    let type: MainModel.CodingKeys
    
    var body: some View {
        VStack(spacing: 0) {
            CellView(name: type.rawValue, value: viewModel.totalValue)
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    if #available(iOS 16.0, *) {
                        Chart(viewModel.losses, id: \.date) {
                            LineMark(
                                x: .value("Date", $0.date),
                                y: .value("Losses", $0.value)
                            )
                            PointMark(
                                x: .value("Date", $0.date),
                                y: .value("Losses", $0.value)
                            )
                        }
                        .frame(height: 200)
                        .padding(.horizontal, 4)
                        .padding(.top)
                    }
                    if !viewModel.equipmentModels.isEmpty {
                        Text("Visual Confirmed Models")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding(.top)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                        ForEach(viewModel.equipmentModels, id: \.model) {
                            CellView(name: $0.model , value: $0.total, iconName: type.rawValue)
                        }
                    }
                }.padding(.horizontal)
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .navigationTitle(type.rawValue.uppercased())
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.headline)
                        .foregroundColor(.white)
                }
            }
        }
        .background(
            Background()
        )
        .onAppear {
            interactor?.getTotalValue(type: type)
            interactor?.getModels(type: type)
            interactor?.getLosses(type: type)
        }
    }
    
    func configure() -> some View {
        var view = self
        let repo = DefaultDataRepository.shared
        let interactor = DetailInteractor(repo: repo)
        let presenter = DetailPresenter()
        view.interactor = interactor
        interactor.presenter = presenter
        presenter.view = view
        return view
    }
}

struct PreviewDetailView: PreviewProvider {
    static var previews: some View {
        DetailView(type: .personnel)
    }
}
