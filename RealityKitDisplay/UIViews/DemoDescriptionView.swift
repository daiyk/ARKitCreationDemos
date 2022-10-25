//
//  DemoDescriptionView.swift
//  CreateAndCombineViews
//
//  Created by Yukun Dai on 14.10.22.
//

import SwiftUI

struct DemoDescriptionView: View {
    var title: String
    var description: String
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Text(title)
                    .font(.title)
                    .bold()
                    .foregroundColor(.blue)
                Spacer()
            }
            Divider()
            Text(description)
                .font(.body)
            
        }
    }
}

struct DemoDescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        DemoDescriptionView(title: "Sample APP", description: "SampleText")
    }
}
