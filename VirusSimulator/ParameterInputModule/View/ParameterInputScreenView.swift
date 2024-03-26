//
//  ParameterInputScreenView.swift
//  VirusSimulator
//
//  Created by Лилия Феодотова on 21.03.2024.
//

import UIKit

struct ConstantsParameters {
    static let groupSizePlaceholder = "Например: 100"
    static let groupSizeHeader = "Количество людей"
    static let infectionFactorPlaceholder = "От 1 до 8"
    static let infectionFactorHeader = "Кол-во людей, зараженных при контакте"
    static let periodPlaceholder = "Например, 1"
    static let periodHeader = "Период в секундах"
    static let buttonStartTitle = "Запустить моделирование"
    static let buttonHeight: CGFloat = 50
    static let sizeBetween: CGFloat = 10
    static let sizeInfoButton: CGFloat = 30
    static let nameApp = "Симулятор распространения вируса"
    static let infoImageName = "info.circle"
    static let fontSize: CGFloat = 18
    static let numOfLine: Int = 0
}

protocol ParameterInputScreenViewProtocol: UIView {
    var groupSize: CustomTextField { get }
    var infectionFactor: CustomTextField { get }
    var period: CustomTextField { get }
    var startButton: UIButton { get }
    var infoButton: UIButton { get }
}

final class ParameterInputScreenView: UIView, ParameterInputScreenViewProtocol {
    
    let nameAppLabel: UILabel = {
        let label = UILabel()
        label.text = ConstantsParameters.nameApp.uppercased()
        label.textAlignment = .center
        label.numberOfLines = ConstantsParameters.numOfLine
        label.font = .systemFont(ofSize: ConstantsParameters.fontSize, weight: .semibold)
        return label
    }()
    
    let groupSize = CustomTextField(placeholder: ConstantsParameters.groupSizePlaceholder, header: ConstantsParameters.groupSizeHeader)
    let infectionFactor = CustomTextField(placeholder: ConstantsParameters.infectionFactorPlaceholder, header: ConstantsParameters.infectionFactorHeader)
    let period = CustomTextField(placeholder: ConstantsParameters.periodPlaceholder, header: ConstantsParameters.periodHeader)
    
    let startButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.borderWidth = 1
        button.backgroundColor = .lightGray
        button.titleLabel?.font = .systemFont(ofSize: ConstantsParameters.fontSize, weight: .semibold)
        button.tintColor = .black
        button.setTitle(ConstantsParameters.buttonStartTitle, for: .normal)
        return button
    }()
    
    let infoButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: ConstantsParameters.infoImageName)
        button.setImage(image, for: .normal)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - private extension

private extension ParameterInputScreenView {
    func setupView() {
        backgroundColor = .white
        
        addSubviews(nameAppLabel, groupSize, infectionFactor, period, startButton, infoButton)
        disableSubviewsTamic()
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            nameAppLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            nameAppLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            nameAppLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            
            groupSize.topAnchor.constraint(equalTo: nameAppLabel.bottomAnchor, constant: ConstantsParameters.sizeBetween * 3),
            groupSize.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            groupSize.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            
            infectionFactor.topAnchor.constraint(equalTo: groupSize.bottomAnchor, constant: ConstantsParameters.sizeBetween),
            infectionFactor.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            infectionFactor.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            
            period.topAnchor.constraint(equalTo: infectionFactor.bottomAnchor, constant: ConstantsParameters.sizeBetween),
            period.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            period.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            
            startButton.topAnchor.constraint(equalTo: period.bottomAnchor, constant: ConstantsParameters.sizeBetween * 2),
            startButton.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            startButton.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            startButton.heightAnchor.constraint(equalToConstant: ConstantsParameters.buttonHeight),
            
            infoButton.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor, constant: -(ConstantsParameters.sizeBetween * 2)),
            infoButton.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor, constant: -(ConstantsParameters.sizeBetween * 2)),
            infoButton.heightAnchor.constraint(equalToConstant: ConstantsParameters.sizeInfoButton),
            infoButton.widthAnchor.constraint(equalToConstant: ConstantsParameters.sizeInfoButton)
        ])
        
    }
}
