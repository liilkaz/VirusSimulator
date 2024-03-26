//
//  Factory.swift
//  VirusSimulator
//
//  Created by Лилия Феодотова on 21.03.2024.
//

import UIKit

protocol FactoryProtocol {
    func makeParameterInputScreen(router: RouterProtocol) -> UIViewController
    func makeSimulationScreen(_ parametres: ParametersModel, router: RouterProtocol) -> UIViewController
    func makeInfoScreen(router: RouterProtocol) -> UIViewController
    func makeAlert(_ info: String) -> UIAlertController
}

final class Factory: FactoryProtocol {
    
    func makeParameterInputScreen(router: RouterProtocol) -> UIViewController {
        let presenter = PresenterParameterInputScreen(router: router)
        let viewController = ParameterInputScreenViewController(presenter: presenter, viewScreen: ParameterInputScreenView())
        presenter.view = viewController
        return viewController
    }
    
    func makeSimulationScreen(_ parametres: ParametersModel, router: RouterProtocol) -> UIViewController {
        let presenter = PresenterSimulationScreen(router: router, parametres: parametres)
        let viewController = SimulationScreenViewController(presenter: presenter, viewScreen: SimulationScreenView())
        presenter.view = viewController
        return viewController
    }
    
    func makeInfoScreen(router: RouterProtocol) -> UIViewController {
        let presenter = PresenterInfoViewScreen(router: router)
        let viewController = InfoViewController(presenter: presenter, viewScreen: InfoView())
        presenter.view = viewController
        return viewController
    }
    
    func makeAlert(_ info: String) -> UIAlertController {
        let alert = UIAlertController(
            title: "Внимание!",
            message: info,
            preferredStyle: .alert
        )
        alert.addAction(.init(title: "ОК", style: .cancel))
        return alert
    }

}
