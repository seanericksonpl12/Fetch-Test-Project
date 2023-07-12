//
//  ContentViewModel.swift
//  Fetch Test Project
//
//  Created by Sean Erickson on 7/10/23.
//

import Foundation
import Combine

class ContentViewModel: ObservableObject {
    
    // MARK: - Published Properties
    @Published var meals: [Meal] = []
    @Published var searchText: String = ""
    @Published var displayError: Bool = false
    
    // MARK: - Computed Properties
    var searchMeals: [Meal] {
        if searchText.isEmpty {
            return meals
        } else {
            return meals.filter { $0.strMeal.contains(searchText) }
        }
    }
    
    // MARK: - Publishers
    private lazy var mealPublisher: AnyPublisher<[Meal], Never> = {
        NetworkManager.main.getMeal()
            .receive(on: DispatchQueue.main)
            .catch { error in
                self.displayError = true
                return Just([Meal]())
            }
            .eraseToAnyPublisher()
    }()
    
    // MARK: - Init
    init() {
        mealPublisher.assign(to: &$meals)
    }
    
}
