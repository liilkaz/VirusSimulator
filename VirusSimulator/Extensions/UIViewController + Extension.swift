//
//  UIViewController + Extension.swift
//  VirusSimulator
//
//  Created by Лилия Феодотова on 26.03.2024.
//

import UIKit

extension UIViewController {
    func setNavigationBar(title: String) {
        navigationItem.title = title
        navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
