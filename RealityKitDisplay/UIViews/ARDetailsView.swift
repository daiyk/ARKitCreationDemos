//
//  ARDetailsView.swift
//
//  Created by Yukun Dai on 12.10.22.
//

import SwiftUI

struct ARDetailsView: View {
    class ARDetailsViewModel: ObservableObject{
        //data model object
        var dataModel: LoadDemoModels
        //id of this arview
        var id:Int
        var demoModel:DemoInfo{
            dataModel.demoInfos.first(where: {$0.id == id}) ?? DemoInfo(id: -1, type: .placeholder, title: "place holder", description: "sample text")
        }
        
        //image for button label
        var buttonLabel: Image{
            if let uiimage = UIImage(named: dataModel.getIcon(demoModel)){
                return Image(uiImage: uiimage)
            }
            else if let uiimage = UIImage(systemName: dataModel.getIcon(demoModel))
            {
                return Image(uiImage: uiimage)
            }
            else{
                return Image(systemName: "photo.fill")
            }
        }
        var backgroundImage: Image{
            if let backgroundImg = demoModel.backGroundImg{
                if let uiimage = UIImage(named: backgroundImg){
                    return Image(uiImage: uiimage)
                }
                return Image(systemName: "photo.artframe")
            }
            else{
                return Image(systemName: "photo.artframe")
            }
        }
        init(model:LoadDemoModels, id:Int){
            self.id = id
            self.dataModel = model
        }
    }
    @ObservedObject var viewModel: ARDetailsViewModel
    var body: some View {
        ScrollView{
            VStack{
                SquareImage(image: viewModel.backgroundImage).edgesIgnoringSafeArea(.all)
                VStack{
                    ButtonLabel(buttonLabel: viewModel.buttonLabel)
                    NavigationLink{
                        switch(viewModel.demoModel.type){
                        case .pottingStore:
                            PottingStore()
                        case .placeObjects:
                            PlaceObjects()
                        case .measurment:
                            Measurements()
                        default:
                            Text("This app is Not Implemented")
                        }
                    }
                    label:{
                        Text("Start").font(.system(size: 25))
                    }.buttonStyle(.bordered)
                        .buttonBorderShape(.roundedRectangle)
                        .frame(width: 100, height: 50)
                }.padding(.bottom, -70.0).offset(x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: /*@START_MENU_TOKEN@*/-60.0/*@END_MENU_TOKEN@*/)
                    
                DemoDescriptionView(title: viewModel.demoModel.title, description: viewModel.demoModel.description).padding()
            }
            Spacer()
        }
        
    }
}

struct ARDetailsView_Previews: PreviewProvider {
    @State static var exampleDataModel = buildExampleCase()
    static var previews: some View {
        ARDetailsView(viewModel: ARDetailsView.ARDetailsViewModel(model: LoadDemoModels(),id: 2))
    }
    static func buildExampleCase()->DemoInfo{
        DemoInfo(id: 0, type: .placeObjects, title: "SampleTitle", description: "SampleTextOnHere",buttonLabel: "hand.tap")
    }
}
