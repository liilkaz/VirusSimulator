//
//  StatisticPanelView.swift
//  VirusSimulator
//
//  Created by Лилия Феодотова on 26.03.2024.
//

import UIKit

struct ConstantsStatisticPanel {
    static let inset: CGFloat = 20
    static let height: CGFloat = 35
    static let imageName = "person.crop.circle"
}

protocol StatisticPanelViewProtocol: UIView, AnyObject {
    var healthyLabelCounter: UILabel { get }
    var illLabelCounter: UILabel { get }
}

final class StatisticPanelView: UIView, StatisticPanelViewProtocol {
    
    let healthyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: ConstantsStatisticPanel.imageName)
        imageView.tintColor = .green
        return imageView
    }()
    
    let illImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: ConstantsStatisticPanel.imageName)
        imageView.tintColor = .red
        return imageView
    }()

    let healthyLabelCounter = UILabel()
    
    let illLabelCounter = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - private extension

private extension StatisticPanelView {
    func setupView() {
        addSubviews(healthyImageView, healthyLabelCounter, illLabelCounter, illImageView)
        disableSubviewsTamic()
    }
    
    func setConstraint() {
        NSLayoutConstraint.activate([

            healthyImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            healthyImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: ConstantsStatisticPanel.inset),
            healthyImageView.heightAnchor.constraint(equalToConstant: ConstantsStatisticPanel.height),
            
            healthyLabelCounter.leadingAnchor.constraint(equalTo: healthyImageView.trailingAnchor, constant: ConstantsStatisticPanel.inset),
            healthyLabelCounter.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            illLabelCounter.centerYAnchor.constraint(equalTo: centerYAnchor),
            illLabelCounter.trailingAnchor.constraint(equalTo: illImageView.leadingAnchor, constant: -ConstantsStatisticPanel.inset),

            illImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            illImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -ConstantsStatisticPanel.inset),
            illImageView.heightAnchor.constraint(equalToConstant: ConstantsStatisticPanel.height)
        ])
    }
}

