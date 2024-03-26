//
//  ViewController.swift
//  VirusSimulator
//
//  Created by Лилия Феодотова on 21.03.2024.
//

import UIKit

final class ParameterInputScreenViewController: UIViewController, ParameterInputScreenProtocol {
    
    private let presenter: PresenterParameterInputScreenProtocol
    private let viewScreen: ParameterInputScreenViewProtocol
    
    init(presenter: PresenterParameterInputScreenProtocol, viewScreen: ParameterInputScreenViewProtocol) {
        self.presenter = presenter
        self.viewScreen = viewScreen
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
       view = viewScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewScreen.groupSize.textField.delegate = self
        viewScreen.infectionFactor.textField.delegate = self
        viewScreen.period.textField.delegate = self
        
        viewScreen.startButton.isEnabled = false
        viewScreen.startButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        viewScreen.infoButton.addTarget(self, action: #selector(infoButtonTapped), for: .touchUpInside)
    }
}

//MARK: - private extension

private extension ParameterInputScreenViewController {
    @objc func buttonTapped() {
        let parameters = ParametersModel(groupSize: viewScreen.groupSize.textField.text ?? "",
                                            infectionFactor: viewScreen.infectionFactor.textField.text ?? "",
                                            period: viewScreen.period.textField.text ?? "")
        presenter.setParameters(parameters: parameters)
        presenter.didTapButton()
    }
    
    @objc func infoButtonTapped() {
        presenter.didTapInfoButton()
    }
}

//MARK: - UITextFieldDelegate

extension ParameterInputScreenViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            guard let text = textField.text else { return false }
            let newString = NSString(string: text).replacingCharacters(in: range, with: string)
            
            guard CharacterSet(charactersIn: "0123456789").isSuperset(of: CharacterSet(charactersIn: newString)) else { return false }
            return true
        }
        
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let sizeTextFieldtext = viewScreen.groupSize.textField.text,
              let infectionFactorTextFieldtext = viewScreen.infectionFactor.textField.text,
              let timeTextFieldtext = viewScreen.period.textField.text else { return }
        if !sizeTextFieldtext.isEmpty && !infectionFactorTextFieldtext.isEmpty && !timeTextFieldtext.isEmpty {
            viewScreen.startButton.isEnabled = true
            return
        }
        viewScreen.startButton.isEnabled = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == viewScreen.groupSize.textField {
            viewScreen.infectionFactor.textField.becomeFirstResponder()
        } else if textField == viewScreen.infectionFactor.textField {
            viewScreen.period.textField.becomeFirstResponder()
        } else if textField == viewScreen.period.textField {
            viewScreen.startButton.isEnabled = true
        }
        return true
    }
}
