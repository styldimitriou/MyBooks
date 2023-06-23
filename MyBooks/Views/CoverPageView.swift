//
//  CoverPageView.swift
//  MyBooks
//
//  Created by Stylianos Dimitriou on 20/6/23.
//

import SwiftUI

struct CoverPageView: View {
    private let imageURL: URL?
    private let size: ImageSize
    
    enum ImageSize {
        case cover, thumbnail
        
        func imageDimensions() -> (width: CGFloat, height: CGFloat) {
            switch self {
            case .cover:
                return (100, 150)
            case .thumbnail:
                return (40, 80)
            }
        }
    }
    
    init(imageURL: URL?, size: ImageSize) {
        self.imageURL = imageURL
        self.size = size
    }
    
    var body: some View {
        AsyncImage(url: imageURL) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: size.imageDimensions().width,
                           height: size.imageDimensions().height)
            } else if phase.error != nil {
                Image(systemName: "book")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: size.imageDimensions().width,
                           height: size.imageDimensions().height)
            } else {
                ProgressView()
            }
        }
    }
}
