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
    @Published var id: String
    
    // MARK: - Publishers
    private lazy var detailsPublisher: AnyPublisher<MealDetails, Never> = {
            NetworkManager.main.getMealDetails(id: id)
            .catch { error in
                print("Network Error")
                return Just(MealDetails())
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }()
    
    // MARK: - Init
    init(id: String) {
        self.id = id
        detailsPublisher.assign(to: &$mealDetails)
    }
}

extension DetailsViewModel {
    
}
