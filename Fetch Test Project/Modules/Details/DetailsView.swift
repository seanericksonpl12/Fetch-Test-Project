//
//  DetailsView.swift
//  Fetch Test Project
//
//  Created by Sean Erickson on 7/11/23.
//

import SwiftUI

struct DetailsView: View {
    
    // MARK: - ViewModel
    @StateObject var viewModel: DetailsViewModel
    
    // MARK: - Body
    var body: some View {
        
        if !viewModel.displayError {
            ScrollView {
                KingfisherView(url: viewModel.mealDetails.strMealThumb, frame: CGSize(width: 200, height: 100))
                    .padding()
                HStack {
                    Spacer()
                    Text("details.category".localized + " " + viewModel.mealDetails.strCategory)
                    Spacer()
                    Text("details.type".localized + " " + viewModel.mealDetails.strArea)
                    Spacer()
                }
                Divider()
                Text("details.ingredients".localized)
                    .padding(.bottom)
                ForEach(viewModel.mealDetails.strIngredients, id: \.id) { ingrd in
                    Text(ingrd.name)
                        .font(.subheadline)
                }
                
                Divider()
                    .padding(.bottom)
                Text("details.instructions".localized)
                Text(viewModel.mealDetails.strInstructions)
                    .font(.subheadline)
                    .padding()
                if let youtube = viewModel.mealDetails.strYoutube {
                    Link(destination: youtube) {
                        Text("details.youtube".localized)
                    }
                    .padding()
                }
            }
        } else {
            Text("content.error.message".localized)
                .font(.title)
                .padding()
            Spacer()
        }
    }
    
    
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(viewModel: DetailsViewModel(id: "55932"))
    }
}
