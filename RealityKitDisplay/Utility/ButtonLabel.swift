//
//  StartButton.swift
//  CreateAndCombineViews
//
//  Created by Yukun Dai on 14.10.22.
//

import SwiftUI

struct ButtonLabel: View {
    var buttonLabel:Image
    var body: some View {
        VStack{
            ZStack{
                Circle()
                    .fill(Color.white)
                    .frame(height: 150)
                Circle()
                    .stroke(Color.black,lineWidth: 3)
                    .frame(width: 150)
                    .shadow(radius: 5)
                buttonLabel
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100)
            }
        }
    }
}

struct StartButton_Previews: PreviewProvider {
    static var previews: some View {
        ButtonLabel(buttonLabel: Image(systemName: "hand.tap"))
    }
}
