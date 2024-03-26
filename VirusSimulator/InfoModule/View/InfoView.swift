//
//  InfoView.swift
//  VirusSimulator
//
//  Created by Лилия Феодотова on 26.03.2024.
//

import UIKit

struct InfoConstants {
    static let title = "Инструкция"
    static let recomendInfoLabel = "Рекомендации к заполнению полей:"
    static let recomendInfo = """
    • количество людей в моделируемой группе — рекомендуемые значения от 6;
    • количество людей, которое может быть заражено одним человеком при контакте — рекомендуемые значения от 1 до 8;
    • период пересчёта количества заражённых людей — в секундах от 1.
"""
    static let infoBody = """

    После нажатия на кнопку "Запустить моделирование" открывается экран моделирования, который отображает всю моделируемую группу людей. В начальном состоянии в группе нет инфицированных людей — все объекты здоровые.
    Если пользователь нажимает на «здоровый» элемент, тот становится «больным». За время работы системы моделирования пользователь может нажимать на неограниченное количество «здоровых» элементов, тем самым «заражая» их.
"""
    
    static let backgroundViewSize: (CGFloat, CGFloat) = (180, -120)
    static let inset: CGFloat = 10
    static let height: CGFloat = 30
    static let fontSizeLabel: CGFloat = 24
    static let fontSizeText: CGFloat = 15
    static let numOfLines: Int = 0
}

protocol InfoViewProtocol: UIView {
    var backgroundView: UIView { get }
    var titleLabel: UILabel { get }
    var recomendInfoLabel: UILabel { get }
    var recomendInfo: UILabel { get }
    var infoBodyLabel: UILabel { get }
}

final class InfoView: UIView, InfoViewProtocol {

    let backgroundView: UIView = {
        let backgroundView = UIView()
        backgroundView.backgroundColor = .lightGray
        backgroundView.layer.cornerRadius = InfoConstants.inset
        return backgroundView
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: InfoConstants.fontSizeLabel)
        label.text = InfoConstants.title.uppercased()
        label.textAlignment = .center
        return label
    }()
    
    let recomendInfoLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: InfoConstants.fontSizeText, weight: .semibold)
        label.text = InfoConstants.recomendInfoLabel
        label.textAlignment = .center
        return label
    }()
    
    let recomendInfo: UILabel = {
        let label = UILabel()
        label.numberOfLines = InfoConstants.numOfLines
        label.font = .systemFont(ofSize: InfoConstants.fontSizeText, weight: .medium)
        label.text = InfoConstants.recomendInfo
        label.textAlignment = .natural
        return label
    }()
    
    let infoBodyLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = InfoConstants.numOfLines
        label.font = .systemFont(ofSize: InfoConstants.fontSizeText)
        label.text = InfoConstants.infoBody
        label.textAlignment = .natural
        return label
    }()

    override init (frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//MARK: - private extension

private extension InfoView {
    func setupView() {
        backgroundColor = .white
        addSubviews(backgroundView, titleLabel, recomendInfoLabel, recomendInfo, infoBodyLabel)
        disableSubviewsTamic()
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: topAnchor, constant: InfoConstants.backgroundViewSize.0),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: InfoConstants.backgroundViewSize.1),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: InfoConstants.height),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -InfoConstants.height),
            
            titleLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: InfoConstants.inset),
            titleLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: InfoConstants.inset),
            titleLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -InfoConstants.inset),
            titleLabel.heightAnchor.constraint(equalToConstant: InfoConstants.height),
            
            recomendInfoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: InfoConstants.inset),
            recomendInfoLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: InfoConstants.inset),
            recomendInfoLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -InfoConstants.inset),
            
            recomendInfo.topAnchor.constraint(equalTo: recomendInfoLabel.bottomAnchor, constant: InfoConstants.inset),
            recomendInfo.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: InfoConstants.inset),
            recomendInfo.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -InfoConstants.inset),
            
            infoBodyLabel.topAnchor.constraint(equalTo: recomendInfo.bottomAnchor, constant: InfoConstants.inset),
            infoBodyLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: InfoConstants.inset),
            infoBodyLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -InfoConstants.inset),
            infoBodyLabel.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -InfoConstants.inset)
        ])
    }
}
