//
//  Presenter.swift
//  CryptoViper
//
//  Created by kadir on 8.01.2023.
//

import Foundation

// Talks to -> Interactor, View , Router
// class, protocol

enum NetworkError : Error {
    case NetworkFailed
    case parsingFailed
}

protocol AnyPresenter {
    var router : AnyRouter? {get set}
    var interactor : AnyInteractor? {get set}
    var view : AnyView? {get set}
    
    func interactorDidDownloadCrypto(result: Result<[Crypto], Error>)
    
}

class  CryptoPresenter : AnyPresenter{
    func interactorDidDownloadCrypto(result: Result<[Crypto], Error>) {
        
        switch result {
        case .success(let cryptos):
            print("view update")
            view?.update(with: cryptos)
        case.failure(let error):
            print("view update error")
            view?.update(with:error.localizedDescription)

        }
    }
    
    var view: AnyView?
    
    var router: AnyRouter?
    
    var interactor: AnyInteractor? {
        didSet {
            interactor?.downloadCryptos()
        }
    }
    
    
}
