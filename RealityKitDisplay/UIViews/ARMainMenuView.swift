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
                                SquareImage(image: Image(uiImage: data.getBackground(val.id)))
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
                        Text("This app is an AR apps gallery where you can test three AR demos: \nplace objects \npotting stores \nmeasure distance").multilineTextAlignment(.leading)
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

