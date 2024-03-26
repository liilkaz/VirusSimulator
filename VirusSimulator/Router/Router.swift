//
//  Router.swift
//  VirusSimulator
//
//  Created by Лилия Феодотова on 21.03.2024.
//

import UIKit

protocol RouterMain {
    var navigationController: UINavigationController { get }
    var factory: FactoryProtocol { get }
}

protocol RouterProtocol: RouterMain {
    func initialViewController()
    func showSimulationScreen(_ parametres: ParametersModel)
    func showInfoScreen()
    func showAlert(_ info: String)
}

class Router: RouterProtocol {
    let navigationController: UINavigationController
    let factory: FactoryProtocol
    
    init(navigationController: UINavigationController, factory: FactoryProtocol) {
        self.navigationController = navigationController
        self.factory = factory
    }
    
    func initialViewController() {
        let initialViewController = factory.makeParameterInputScreen(router: self)
        navigationController.viewControllers = [initialViewController]
    }
    
    func showSimulationScreen(_ parametres: ParametersModel) {
        let simulationScreenViewController = factory.makeSimulationScreen(parametres, router: self)
        navigationController.pushViewController(simulationScreenViewController, animated: true)
    }
    
    func showInfoScreen() {
        let infoScreenViewController = factory.makeInfoScreen(router: self)
        navigationController.pushViewController(infoScreenViewController, animated: true)
    }
    
    func showAlert(_ info: String) {
        let alert = factory.makeAlert(info)
        navigationController.present(alert, animated: true)
    }
    
}
