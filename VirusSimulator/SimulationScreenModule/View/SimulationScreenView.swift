//
//  SimulationScreenView.swift
//  VirusSimulator
//
//  Created by Лилия Феодотова on 23.03.2024.
//

import UIKit

protocol SimulationScreenViewProtocol: UIView {
    var collectionView: UICollectionView { get }
    var statisticPanel: StatisticPanelViewProtocol { get }
}

final class SimulationScreenView: UIView, SimulationScreenViewProtocol {
   
    static let inset: CGFloat = 1
    private let panelHeight: CGFloat = 50
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: CGRect(x: 0,
                                                    y: 0,
                                                    width: 0,
                                                    height: 0))
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width * 2,
                                        height: UIScreen.main.bounds.height * 2)
        scrollView.backgroundColor = .white
        scrollView.panGestureRecognizer.isEnabled = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        let collectionView = UICollectionView(frame: CGRect(x: 0,
                                                            y: 0,
                                                            width: UIScreen.main.bounds.width * 2,
                                                            height: UIScreen.main.bounds.height * 2),
                                              collectionViewLayout: layout)
        collectionView.register(SimulationScreenCollectionViewCell.self, forCellWithReuseIdentifier: SimulationScreenCollectionViewCell.reuseIdentifier)
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
    let statisticPanel: StatisticPanelViewProtocol = StatisticPanelView()
    
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

private extension SimulationScreenView {
    func setupView() {
        addSubviews(statisticPanel, scrollView)
        scrollView.addSubview(collectionView)
        disableSubviewsTamic()
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            statisticPanel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            statisticPanel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            statisticPanel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            statisticPanel.heightAnchor.constraint(equalToConstant: panelHeight),
            
            scrollView.topAnchor.constraint(equalTo: statisticPanel.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            collectionView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
}
