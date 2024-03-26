//
//  CustomTextField.swift
//  VirusSimulator
//
//  Created by Лилия Феодотова on 21.03.2024.
//

import UIKit

fileprivate struct Constants {
    static let fontSize: CGFloat = 18
    static let borderWidth: CGFloat = 1
    static let origin: CGFloat = 0
    static let TextFieldCgRectWidth: CGFloat = 10
    static let topTextFieldAnchor: CGFloat = 8
    static let heightTextFieldAnchor: CGFloat = 50
}

final class CustomTextField: UIView {
    
    let textField: UITextField
    private let headerText: String
    
    private lazy var header: UILabel = {
        let label = UILabel()
        label.text = headerText
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: Constants.fontSize, weight: .medium)
        return label
    }()
    
    init(placeholder: String,
         header: String) {
        self.textField = UITextField(placeholder: placeholder, borderWidth: Constants.borderWidth)
        self.headerText = header
        super.init(frame: .zero)
        
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - private extension

private extension CustomTextField {
    
    func setupView(){
        textField.leftView = UIView(frame: CGRect(x: Constants.origin,
                                                  y: Constants.origin,
                                                  width: Constants.TextFieldCgRectWidth,
                                                  height: frame.height))
        textField.leftViewMode = .always
        textField.keyboardType = .numbersAndPunctuation
        textField.returnKeyType = .done
        
        addSubviews(header, textField)
        disableSubviewsTamic()
    }
    
    func setConstraints(){
        
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: topAnchor),
            header.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            textField.topAnchor.constraint(equalTo: header.bottomAnchor, constant: Constants.topTextFieldAnchor),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor),
            textField.heightAnchor.constraint(equalToConstant: Constants.heightTextFieldAnchor)
        ])
    }
}

