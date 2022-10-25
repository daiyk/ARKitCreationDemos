//
//  DataModel.swift
//  RealityKitDisplay
//
//  Created by Yukun Dai on 07.10.22.
//

import Foundation
import RealityKit

// datamodel that stores all required data we need
class ARModels: ObservableObject{
    @Published var placeItems: [ModelEntity]?
    @Published var demoType: ARViewType?
    var furnitureScene:Experience.NaturePlant?
    
    func setDemo(_ demotype: ARViewType){
        demoType = demotype
        buildModelEntity()
    }
    private func buildModelEntity(){
        //based on the demotype
        guard let demotype = demoType
        else{
            fatalError("Use uninitialized demo type for model building")
        }
        
        switch(demotype){
            case .placeObjects:
            if placeItems==nil{
                placeItems=[]
                placeItems!.append(ModelEntity(mesh: .generateSphere(radius: 0.1),materials: [SimpleMaterial(color: .yellow, isMetallic: false)]))
                placeItems!.append(ModelEntity(mesh:.generateBox(size: 0.1),materials: [SimpleMaterial(color: .blue, isMetallic: false)]))
                placeItems!.append(ModelEntity(mesh: .generatePlane(width: 0.6, depth: 0.6),materials: [SimpleMaterial(color: .white, isMetallic: true)]))
                //generate collision shape for raycast and hittest
                placeItems![0].generateCollisionShapes(recursive: true)
                placeItems![1].generateCollisionShapes(recursive: true)
                placeItems![2].generateCollisionShapes(recursive: true)
            }
            break
            case .furnitureStore:
            if furnitureScene == nil{
                furnitureScene = try! Experience.loadNaturePlant()
            }
            break
            case .measurment:
                return
            case .lightDemo:
                return
            default:
                return
        }
        
    }
    
    
}
