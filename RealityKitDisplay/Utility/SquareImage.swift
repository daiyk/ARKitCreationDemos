//
//  SquareImage.swift
//  CreateAndCombineViews
//
//  Created by Yukun Dai on 12.10.22.
//

import SwiftUI

struct SquareImage: View {
    var image: Image
    var body: some View {
        image.resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 300)
            .padding()
                
    }
}

struct SquareImage_Previews: PreviewProvider {
    static var previews: some View {
        SquareImage(image:Image("Cube"))
    }
}
