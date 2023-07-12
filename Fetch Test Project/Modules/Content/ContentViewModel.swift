//
//  ContentViewModel.swift
//  Fetch Test Project
//
//  Created by Sean Erickson on 7/10/23.
//

import Foundation
import Combine

class ContentViewModel: ObservableObject {
    
    // MARK: - Published
    @Published var meals: [Meal] = []
    
    // MARK: - Publishers
    private lazy var mealPublisher: AnyPublisher<[Meal], Never> = {
        NetworkManager.main.getMeal()
            .catch { error in
                print("network error!")
                return Just([Meal]())
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }()
    
    // MARK: - Init
    init() {
        mealPublisher.assign(to: &$meals)
    }
    
}
