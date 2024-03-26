//
//  PresenterParameterInputScreen.swift
//  VirusSimulator
//
//  Created by Лилия Феодотова on 21.03.2024.
//

import Foundation

protocol ParameterInputScreenProtocol: AnyObject {}

protocol PresenterParameterInputScreenProtocol: AnyObject {
    init(router: RouterProtocol)
    func didTapButton()
    func didTapInfoButton()
    func setParameters(parameters: ParametersModel)
}

final class PresenterParameterInputScreen {
    weak var view: ParameterInputScreenProtocol?
    let router: RouterProtocol
    private var parameters = ParametersModel()
    
    required init(router: RouterProtocol) {
        self.router = router
    }
}

//MARK: - PresenterParameterInputScreenProtocol

extension PresenterParameterInputScreen: PresenterParameterInputScreenProtocol {
    func setParameters(parameters: ParametersModel) {
        self.parameters.groupSize = parameters.groupSize
        self.parameters.infectionFactor = parameters.infectionFactor
        self.parameters.period = parameters.period
    }
    
    func validateParameters(parameters: ParametersModel) -> Bool {
        if !parameters.groupSize.isEmpty && !parameters.infectionFactor.isEmpty && !parameters.period.isEmpty {
            if parameters.groupSize.isInt && parameters.infectionFactor.isInt && parameters.period.isInt {
                if let intFactor = Int(parameters.infectionFactor), intFactor < 1 || intFactor > 8 {
                    return false
                }
                return true
            }
        }
        return false
    }
    
    func didTapButton() {
        if validateParameters(parameters: parameters) {
            router.showSimulationScreen(parameters)
            return
        }
        router.showAlert("Некорректные данные")
    }
    
    func didTapInfoButton() {
        router.showInfoScreen()
    }
}
