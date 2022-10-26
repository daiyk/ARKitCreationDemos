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
            .renderingMode(.original)
            .aspectRatio(contentMode: .fit)
                
    }
}

struct SquareImage_Previews: PreviewProvider {
    static var previews: some View {
        SquareImage(image:Image("Cube"))
    }
}
