//
//  InfoViewController.swift
//  VirusSimulator
//
//  Created by Лилия Феодотова on 26.03.2024.
//

import UIKit

final class InfoViewController: UIViewController, InfoViewScreenProtocol {
    
    private let presenter: PresenterInfoViewScreenProtocol
    private let viewScreen: InfoViewProtocol
    
    init(presenter: PresenterInfoViewScreenProtocol, viewScreen: InfoViewProtocol) {
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
        setNavigationBar(title: "")
    }
}
