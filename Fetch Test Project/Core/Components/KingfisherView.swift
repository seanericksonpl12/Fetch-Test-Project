//
//  KingfisherView.swift
//  Fetch Test Project
//
//  Created by Sean Erickson on 7/11/23.
//

import SwiftUI
import Kingfisher

struct KingfisherView: View {
    
    // MARK: - Properties
    var url: URL?
    var frame: CGSize = CGSize(width: 40, height: 40)
    var cornerRad: CGFloat = 10
    
    // MARK: - Body
    var body: some View {
        KFImage(url)
            .setProcessors([DownsamplingImageProcessor(size: frame), RoundCornerImageProcessor(cornerRadius: cornerRad)])
            .cacheOriginalImage(true)
            .placeholder {
                Image(systemName: "rays")
                    .resizable()
                    .frame(width: 40, height: 40)
            }
    }
}

struct KingfisherView_Previews: PreviewProvider {
    static var previews: some View {
        KingfisherView()
    }
}
