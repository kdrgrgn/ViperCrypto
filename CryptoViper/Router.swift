//
//  Router.swift
//  CryptoViper
//
//  Created by kadir on 8.01.2023.
//

import Foundation
import UIKit

// class, protocol
// EntryPoint

typealias EntryPoint = AnyView & UIViewController

protocol AnyRouter {

    var entry : EntryPoint? {get}
    static func startExecution() -> AnyRouter
}

class CryptoRouter : AnyRouter {
    var entry: EntryPoint?
    
    static func startExecution() -> AnyRouter {
        let router = CryptoRouter()
        var view : AnyView = CryptoViewController()
        var presenter : AnyPresenter = CryptoPresenter()
        var interactor : AnyInteractor = CryptoInteractor()
        
        view.presenter = presenter
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        interactor.presenter = presenter
        router.entry = view as? EntryPoint
        return router
    }
    
    
}

