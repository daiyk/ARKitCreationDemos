//
//  ARMainMenuView.swift
//
//  Created by Yukun Dai on 17.10.22.
//

import SwiftUI

struct ARMainMenuView: View {
    @EnvironmentObject var data: LoadDemoModels
    @State var isPresentAlert: Bool = true
    var body: some View {
        NavigationView{
                List{
                    ForEach(data.demoInfos){ val in
                        NavigationLink{
                            ARDetailsView(viewModel: ARDetailsView.ARDetailsViewModel(model: data, id: val.id))
                        }
                        label:{
                            VStack{
                                HStack{
                                    Text(val.type.rawValue)
                                        .font(.title3)
                                        .fontWeight(.bold)
                                    Spacer()
                                }
                                Image(uiImage: data.getBackground(data.demoInfos[0].id))
                                    .renderingMode(.original)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 200)
                                Spacer()
                            }
                        }
                    }
                }
                .alert("Welcome!", isPresented: $isPresentAlert){
                        Button("Let's Start"){
                            isPresentAlert = false
                        }
                    }
                    message:
                    {
                        Text("This app is an AR apps gallery where you can test three AR demos: \nplace objects \nfurniture stores \nmeasure distance")
                    }
                .navigationTitle("Apps Gallery")
        }
        .navigationViewStyle(.automatic)
    }
}

struct ARMainMenuView_Previews: PreviewProvider {
    @StateObject static var models = LoadDemoModels()
    static var previews: some View {
        ARMainMenuView().environmentObject(models)
    }
}
