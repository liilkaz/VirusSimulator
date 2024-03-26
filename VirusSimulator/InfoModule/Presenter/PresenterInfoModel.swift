//
//  PresenterInfoModel.swift
//  VirusSimulator
//
//  Created by Лилия Феодотова on 26.03.2024.
//

import Foundation

protocol InfoViewScreenProtocol: AnyObject {}

protocol PresenterInfoViewScreenProtocol: AnyObject {
    init(router: RouterProtocol)
}

final class PresenterInfoViewScreen: PresenterInfoViewScreenProtocol {
    weak var view: InfoViewScreenProtocol?
    let router: RouterProtocol
    
    required init(router: RouterProtocol) {
        self.router = router
    }
}
