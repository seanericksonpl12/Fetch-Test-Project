//
//  NetworkManager.swift
//  Fetch Test Project
//
//  Created by Sean Erickson on 7/10/23.
//

import Foundation
import Combine
import SwiftyJSON

public class NetworkManager {
    
    // MARK: - Main
    public static let main: NetworkManager = NetworkManager()
    
    // MARK: - Endpoints
    private let dessertEndpoint: String = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
    private let detailsEndpoint: String = "https://themealdb.com/api/json/v1/1/lookup.php?i="
    
    // MARK: - Public Functions
    func getMeal() -> AnyPublisher<[Meal], Error> {
        guard let url = URL(string: dessertEndpoint) else { return Fail(error: NetworkError.invalidURL("Bad URL")).eraseToAnyPublisher() }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Meals.self, decoder: JSONDecoder())
            .map { $0.meals.sorted { $0.strMeal.lowercased() < $1.strMeal.lowercased() } }
            .eraseToAnyPublisher()
    }
    
    func getMealDetails(id: String) -> AnyPublisher<MealDetails, Error> {
        guard let url = URL(string: detailsEndpoint + id) else { return Fail(error: NetworkError.invalidURL("Bad URL")).eraseToAnyPublisher() }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { data, response in
                do {
                    let json = try JSON(data: data)
                    return self.sortJSON(json: json)
                } catch { return MealDetails() }
            }
            .catch { _ in return Fail(error: NetworkError.noResponse("Bad response"))}
            .eraseToAnyPublisher()
    }
    
    // MARK: - Private Helpers
    private func sortJSON(json: JSON) -> MealDetails {
        let arr = json["meals"][0]
            .filter { $0.1 != JSON.null && $0.1 != "" && $0.1 != " " }
            .sorted { $0.0 < $1.0 }
            .map { ($0.0, $0.1.stringValue.trimmingCharacters(in: .whitespaces)) }
        
        var details = MealDetails()
        var measurements: [String] = []
        var ingredients: [String] = []
        
        // Separate ingredients and measurements
        arr.forEach { item in
            if item.0.contains("Ingredient") {
                ingredients.append(item.1)
            }
            if item.0.contains("Measure") {
                measurements.append(item.1)
            }
        }
        
        // Combine measurement & ingrd to single string
        for (index, _) in measurements.enumerated() {
            guard let measure = measurements[safe: index] else { continue }
            guard let ingrd = ingredients[safe: index] else { continue }
            let toAppd = MealIngredient(name: (measure + " " + ingrd).trimmingCharacters(in: .whitespaces))
            if toAppd.name != "" {
                details.strIngredients.append(toAppd)
            }
        }
        
        // Fill MealDetails
        let values = json["meals"][0]
        details.idMeal = values["idMeal"].stringValue
        details.strArea = values["strArea"].stringValue
        details.strTags = values["strTags"].stringValue
        details.strCategory = values["strCategory"].stringValue
        details.strDrinkAlternate = values["strDrinkAlternate"].stringValue
        details.strInstructions = values["strInstructions"].stringValue
        details.strMeal = values["strMeal"].stringValue
        details.strMealThumb = values["strMealThumb"].url
        details.strYoutube = values["strYoutube"].url
        
        return details
    }
}
