//
//  PresenterSimulationScreen.swift
//  VirusSimulator
//
//  Created by Лилия Феодотова on 21.03.2024.
//

import Foundation
import UIKit

protocol SimulationScreenProtocol: AnyObject {
    var matrix: [[StateMan]] { get set }
}

protocol PresenterSimulationScreenProtocol: AnyObject {
    init(router: RouterProtocol, parametres: ParametersModel)
    func getGroupSize() -> Int
    func getInfectionFactor() -> Int
    func getPeriod() -> Double
    func getMatrix() -> [[StateMan]]
    func virusDistribution(_ matrix: [[StateMan]])
    func healthyCounter() -> Int
    func illCounter() -> Int
}

final class PresenterSimulationScreen: PresenterSimulationScreenProtocol {
    
    weak var view: SimulationScreenProtocol?
    let router: RouterProtocol
    let parametres: ParametersModel
    
    required init(router: RouterProtocol, parametres: ParametersModel) {
        self.router = router
        self.parametres = parametres
    }
}

//MARK: - Methods

extension PresenterSimulationScreen {
    
    func healthyCounter() -> Int {
        var count = 0
        if let view {
            for row in view.matrix {
                for item in row {
                    if item == .healthy {
                        count += 1
                    }
                }
            }
        }
        return count
    }

    func illCounter() -> Int {
        var count = 0
        if let view {
            for row in view.matrix {
                for item in row {
                    if item == .ill {
                        count += 1
                    }
                }
            }
        }
        return count
    }
    
    func getGroupSize() -> Int {
        Int(parametres.groupSize) ?? 1
    }
    
    func getInfectionFactor() -> Int {
        Int(parametres.infectionFactor) ?? 1
    }
    
    func getPeriod() -> Double {
        Double(parametres.period) ?? 1
    }
    
    /// генерация матрицы с барьером
    func getMatrix() -> [[StateMan]] {
        
        let groupSize = getGroupSize()
        let numberOfColumns = sqrt(Double(groupSize))
        let numberOfRows = groupSize % Int(numberOfColumns) > 0 ? groupSize / Int(numberOfColumns) + 1 : groupSize / Int(numberOfColumns)

        var matrix = [[StateMan]]()

        for i in 0..<numberOfRows + 2 {
            var row = [StateMan]()
            for j in 0..<Int(numberOfColumns) + 2 {
                if i == 0 || i == (numberOfRows + 2) - 1 || j == 0 || j == (Int(numberOfColumns) + 2) - 1 {
                    row.append(.empty)
                } else {
                    row.append(.healthy)
                }
            }
            matrix.append(row)
        }
        return matrix
    }
    
    /// заражение клеток через поиск ближайших "соседей"
    func virusDistribution(_ matrix: [[StateMan]]) {
        let infectionFactor = getInfectionFactor()
    
        let di = [-1, -1, -1, 0, 0, 1, 1, 1]
        let dj = [-1, 0, 1, -1, 1, -1, 0, 1]
        
        let numRows = matrix.count
        let numColumns = matrix[0].count

        for i in 0..<numRows {
            for j in 0..<numColumns {
                if matrix[i][j] == .ill {
                    var neighbors = [(Int, Int)]()
                    for k in 0..<di.count {
                        let ni = i + di[k]
                        let nj = j + dj[k]
                        if ni >= 0 && ni < matrix.count && nj >= 0 && nj < matrix[0].count && matrix[ni][nj] == .healthy {
                            neighbors.append((ni, nj))
                        }
                    }
                    
                    let randomNeighbors = Array(neighbors.shuffled().prefix(infectionFactor))
                    for neighbor in randomNeighbors {
                        let ni = neighbor.0
                        let nj = neighbor.1
                        view?.matrix[ni][nj] = .ill
                    }
                }
            }
        }
    }
}
