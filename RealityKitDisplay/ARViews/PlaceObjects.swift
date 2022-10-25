//
//  PlaceObjects.swift
//  RealityKitDisplay
//
//  Created by Yukun Dai on 24.10.22.
//

import SwiftUI
import RealityKit
import ARKit

struct PlaceObjects: View {
    var body: some View {
        VStack{
            ARPlaceViewContainer().edgesIgnoringSafeArea(.all)
            Text("Click objects to change colors")
        }
    }
}
struct ARPlaceViewContainer:UIViewRepresentable{
   
    
    @EnvironmentObject var arDataModel:ARModels
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        //attach model to the first detected plane
        let anchor = AnchorEntity(plane:.horizontal)
        arView.addGestureRecognizer(UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.TapGestureReceiver)))
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = .horizontal
        arView.session.run(config,options: [.removeExistingAnchors, .resetTracking])
        arView.addCoachingLayer()
        //add reference to the arview
        context.coordinator.arview = arView
        //add models to the scene
        //the models is cube, sphere and plane respectively
        arDataModel.setDemo(.placeObjects)
        //cube
        arDataModel.placeItems![0].position = simd_float3(0.2, 0.2, -0.2)
        arDataModel.placeItems![1].position = simd_float3(-0.2, 0.2, -0.2)
        arDataModel.placeItems![2].position = simd_float3(0, 0, 0)
        //add to aranchor
        anchor.addChild(arDataModel.placeItems![0])
        anchor.addChild(arDataModel.placeItems![1])
        anchor.addChild(arDataModel.placeItems![2])
        arView.scene.addAnchor(anchor)
    
        return arView
        
    }
    func makeCoordinator() -> PlaceObjectsCoordinator {
        return PlaceObjectsCoordinator()
    }
    func updateUIView(_ uiView: ARView, context: Context) {
    }
}
struct PlaceObjects_Previews: PreviewProvider {
    static var previews: some View {
        PlaceObjects()
    }
}
