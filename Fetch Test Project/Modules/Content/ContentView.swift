//
//  ContentView.swift
//  Fetch Test Project
//
//  Created by Sean Erickson on 7/10/23.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Dependencies
    @StateObject var viewModel: ContentViewModel = ContentViewModel()
    
    // MARK: - Body
    var body: some View {
        
        VStack {
            HStack {
                Text("content.title".localized)
                    .fontWeight(.heavy)
                    .font(.largeTitle)
                    .padding()
                Spacer()
            }
            NavigationStack {
                if !viewModel.displayError {
                    mealList
                } else {
                    Text("content.error.message".localized)
                        .font(.title)
                        .padding()
                    Spacer()
                }
            }
            .searchable(text: $viewModel.searchText)
        }
    }
    
    // MARK: - Meal List
    var mealList: some View {
        List(viewModel.searchMeals, id: \.self) { meal in
            HStack {
                KingfisherView(url: meal.strMealThumb)
                    .padding(.trailing)
                NavigationLink {
                    DetailsView(viewModel: DetailsViewModel(id: meal.idMeal))
                        .navigationTitle(meal.strMeal)
                        .navigationBarTitleDisplayMode(.inline)
                } label: {
                    Text(meal.strMeal)
                }
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
