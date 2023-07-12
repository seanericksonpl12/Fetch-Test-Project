//
//  Meal.swift
//  Fetch Test Project
//
//  Created by Sean Erickson on 7/10/23.
//

import Foundation
import SwiftyJSON

// MARK: - Meals
struct Meals: Codable {
    var meals: [Meal]
}

// MARK: - Meal
struct Meal: Codable, Hashable {
    let strMeal: String
    let strMealThumb: URL?
    let idMeal: String
}

// MARK: - MealDetails
struct MealDetails: Codable {
    var idMeal: String = ""
    var strMeal: String = ""
    var strDrinkAlternate: String?
    var strCategory: String = ""
    var strArea: String = ""
    var strInstructions: String = ""
    var strMealThumb: URL?
    var strTags: String = ""
    var strYoutube: URL?
    var strIngredients: [MealIngredient] = []
}

// MARK: - MealIngredient
struct MealIngredient: Codable, Identifiable {
    var id: UUID = UUID()
    var name: String
}
