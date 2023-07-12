//
//  ContentView.swift
//  Fetch Test Project
//
//  Created by Sean Erickson on 7/10/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel: ContentViewModel = ContentViewModel()
    
    var body: some View {
        
        VStack {
            NavigationStack {
                HStack {
                    Text("content.title".localized)
                        .fontWeight(.heavy)
                        .font(.largeTitle)
                        .padding()
                    Spacer()
                }
                List(viewModel.meals, id: \.self) { meal in
                    HStack {
                        KingfisherView(url: meal.strMealThumb)
                            .padding(.trailing)
                        NavigationLink {
                            DetailsView(viewModel: DetailsViewModel(id: meal.idMeal))
                                .navigationTitle(meal.strMeal)
                        } label: {
                            Text(meal.strMeal)
                        }
                        Spacer()
                    }
                }
            }
            
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
