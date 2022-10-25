//
//  FurnitureStore.swift
//  RealityKitDisplay
//
//  Created by Yukun Dai on 21.10.22.
//

import SwiftUI
import RealityKit
import ARKit

struct FurnitureStore: View {
    let plants = ["tree","white potting","bush","cactus","big bush","brown potting"]
    @StateObject var saveWorldMap: MapSaveView = MapSaveView()
    @StateObject var selectedObject: ModelListView = ModelListView()
    @State var placedModels:Set = Set<String>()
    var body: some View {
        VStack{
            ARFurnitureViewContainer(selectedPlant: selectedObject,saveWorldMap: saveWorldMap, loadedObjects: $placedModels).edgesIgnoringSafeArea(.all)
            ScrollView(.horizontal)
            {
                HStack{
                    ForEach(plants,id:\.self){name in
                        Image(name)
                            .resizable()
                            .frame(width: 75, height: 75)
                            .border(.red, width: selectedObject.selectedModel==name && !placedModels.contains(name) ? 2.0:0.01)
                            .saturation(placedModels.contains(name) ? 0.0 : 1.0)
                            .onTapGesture {
                                //we know that this is attached to the "name" object
                                selectedObject.selectedModel=name
                            }
                    }
                }
            }
            HStack{
                Button("Save World")
                {
                    saveWorldMap.OnSave()
                }.buttonStyle(.borderedProminent)
            }
            if(placedModels.count==0){
                Text("Please choose a model to place")
            }
            else{
                Text("Model already placed: \(placedModels.count)")
            }
        }
    }
}

struct ARFurnitureViewContainer: UIViewRepresentable {
    let selectedPlant: ModelListView
    let saveWorldMap: MapSaveView
    @Binding var loadedObjects:Set<String>
    @EnvironmentObject var arDataModel:ARModels
    func makeUIView(context: Context) -> ARView {
        
        let arView = ARView(frame: .zero)
        
        arView.addGestureRecognizer(UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.TapPlantHandler)))
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = .horizontal
        arView.session.run(config,options: [.removeExistingAnchors, .resetTracking])
        arView.addCoachingLayer()
        //set the armodel types
        arDataModel.setDemo(.furnitureStore)
        //init coordinator
        context.coordinator.arModels = arDataModel
        context.coordinator.arView = arView
        context.coordinator.modelLoaded = addToContainers
        saveWorldMap.OnSave={
            context.coordinator.SaveWorldMap()
        }
        context.coordinator.loadWorldMap()
        return arView
        
    }
    func makeCoordinator() -> FurnitureCoordinator {
        return FurnitureCoordinator(selectedPlant)
    }
    func updateUIView(_ uiView: ARView, context: Context) {}
    
    func addToContainers(_ element: String){
        loadedObjects.insert(element)
    }
    
}

struct FurnitureStore_Previews: PreviewProvider {
    static var previews: some View {
        FurnitureStore()
    }
}
