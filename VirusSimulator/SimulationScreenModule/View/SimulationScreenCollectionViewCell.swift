//
//  SimulationScreenCollectionViewCell.swift
//  VirusSimulator
//
//  Created by Лилия Феодотова on 23.03.2024.
//

import UIKit

struct ConstantsCell {
    static let imageName = "man"
}

protocol SimulationScreenCollectionViewCellProtocol {
    var imageView: UIImageView { get }
}

final class SimulationScreenCollectionViewCell: UICollectionViewCell, SimulationScreenCollectionViewCellProtocol {
    
    static var reuseIdentifier: String { "\(Self.self)" }
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: ConstantsCell.imageName)?.withTintColor(.green)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        imageView.image = nil
    }
    
    func stateChange(_ state: StateMan) {
        switch state {
        case .empty:
            imageView.image = nil
        case .healthy:
            imageView.image = UIImage(named: ConstantsCell.imageName)?.withTintColor(.green)
        case .ill:
            imageView.image = UIImage(named: ConstantsCell.imageName)?.withTintColor(.red)
        }
    }
}

//MARK: - private extension

private extension SimulationScreenCollectionViewCell {
    func setupView() {
        contentView.addSubview(imageView)
        contentView.disableSubviewsTamic()
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}
