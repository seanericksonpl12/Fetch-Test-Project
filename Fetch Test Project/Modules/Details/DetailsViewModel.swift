//
//  DetailsViewModel.swift
//  Fetch Test Project
//
//  Created by Sean Erickson on 7/11/23.
//

import Foundation
import Combine

class DetailsViewModel: ObservableObject {
    
    // MARK: - Published
    @Published var mealDetails: MealDetails = MealDetails()
    @Published var displayError: Bool = false
    
    // MARK: - Properties
    var id: String
    
    // MARK: - Publishers
    private lazy var detailsPublisher: AnyPublisher<MealDetails, Never> = {
        NetworkManager.main.getMealDetails(id: id)
            .receive(on: DispatchQueue.main)
            .catch { error in
                self.displayError = true
                return Just(MealDetails())
            }
            .eraseToAnyPublisher()
    }()
    
    // MARK: - Init
    init(id: String) {
        self.id = id
        detailsPublisher.assign(to: &$mealDetails)
    }
}
