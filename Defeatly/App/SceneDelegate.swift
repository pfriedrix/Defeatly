//
//  SceneDelegate.swift
//  Defeatly
//
//  Created by Pfriedrix on 22.08.2023.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let api = API.shared
        let interactor = MainInteractor()
        let presenter = MainPresenter()
        var view = MainView()
        presenter.view = view
        interactor.presenter = presenter
        interactor.api = api
        view.interactor = interactor
        window?.rootViewController = UIHostingController(rootView: view)
        window?.makeKeyAndVisible()
    }
}

