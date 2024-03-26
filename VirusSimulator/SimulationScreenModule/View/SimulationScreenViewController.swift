//
//  SimulationScreenViewController.swift
//  VirusSimulator
//
//  Created by Лилия Феодотова on 21.03.2024.
//

import UIKit

enum StateMan: Int, CaseIterable {
    case empty
    case healthy
    case ill
}

final class SimulationScreenViewController: UIViewController, SimulationScreenProtocol {
    
    private let presenter: PresenterSimulationScreenProtocol
    private let viewScreen: SimulationScreenViewProtocol
    
    private let standartItemSize: CGFloat = 60
    private let smallItemSize: CGFloat = 30
    private let queue = DispatchQueue(label: "com.virusSimulator")
    
    private var timer: Timer?
    private var period: Double = 0
    private var scale: CGFloat = 1.0
    
    private var initHealthyCounter: Int {
        let numberOfRows = matrix.count - 2
        let numberOfColumns = (matrix.first?.count ?? 0) - 2

        let totalCount = numberOfRows * numberOfColumns
        return totalCount
    }
    
    var matrix: [[StateMan]] = [[]]
    
    init(presenter: PresenterSimulationScreenProtocol, viewScreen: SimulationScreenViewProtocol) {
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
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewScreen.collectionView.reloadData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
        timer = nil
    }
}

//MARK: - private extension

private extension SimulationScreenViewController {
    
    func setup() {
        viewScreen.collectionView.delegate = self
        viewScreen.collectionView.dataSource = self
        
        
        matrix = presenter.getMatrix()
        period = presenter.getPeriod()
        setupPinchGesture()
        setNavigationBar(title: "")
        view.backgroundColor = .white
        
        viewScreen.statisticPanel.healthyLabelCounter.text = String(initHealthyCounter)
        viewScreen.statisticPanel.illLabelCounter.text = "0"
    }
    
    func activateSimulator() {
        if timer == nil {
            
            timer = Timer.scheduledTimer(timeInterval: period, target: self, selector: #selector(startTimer), userInfo: nil, repeats: true)
        }
    }
    
    @objc func startTimer() {
        queue.async() {
            self.presenter.virusDistribution(self.matrix)
            self.updateStatistic()
        }
    }
    func updateStatistic() {
        if presenter.healthyCounter() <= 0 {
            timer?.invalidate()
            timer = nil
        }
        let healthyCounter = String(self.presenter.healthyCounter())
        let illCounter = String(self.presenter.illCounter())
        
        DispatchQueue.main.async {
            self.viewScreen.statisticPanel.healthyLabelCounter.text = healthyCounter
            
            self.viewScreen.statisticPanel.illLabelCounter.text = illCounter
            self.viewScreen.collectionView.reloadData()
        }
    }
    
    func setupPinchGesture() {
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinchGesture(_:)))
        pinchGesture.delegate = self
        viewScreen.collectionView.isUserInteractionEnabled = true
        viewScreen.collectionView.addGestureRecognizer(pinchGesture)
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension SimulationScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        matrix.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        matrix.first?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SimulationScreenCollectionViewCell.reuseIdentifier, for: indexPath) as? SimulationScreenCollectionViewCell else {
            return UICollectionViewCell()
        }
        let item = matrix[indexPath.row][indexPath.section]
        cell.stateChange(item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.matrix[indexPath.row][indexPath.section] != .empty {
            self.matrix[indexPath.row][indexPath.section] = .ill
            collectionView.reloadItems(at: [indexPath])
        }
        activateSimulator()
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension SimulationScreenViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if self.matrix[indexPath.row][indexPath.section] == .empty {
            return CGSize(width: 0, height: 0)
        } else {
            if initHealthyCounter > 500 {
                return CGSize(width: smallItemSize, height: smallItemSize)
            }
            return CGSize(width: standartItemSize, height: standartItemSize)
        }
    }
}

//MARK: - UIGestureRecognizerDelegate

extension SimulationScreenViewController: UIGestureRecognizerDelegate {
    @objc func handlePinchGesture(_ gestureRecognizer: UIPinchGestureRecognizer) {
        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            scale *= gestureRecognizer.scale
            gestureRecognizer.scale = 1.0

            viewScreen.collectionView.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
