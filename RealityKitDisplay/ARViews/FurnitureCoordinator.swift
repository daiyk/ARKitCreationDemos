//
//  Coordinator.swift
//  RealityKitDisplay
//
//  Created by Yukun Dai on 03.09.22.
//

import Foundation
import RealityKit
import ARKit
class FurnitureCoordinator
{
    let selectedPlant:ModelListView
    var arView:ARView?
    var arModels:(ARModels)?
    var modelLoaded:((String)->Void)?
    init(_ _selectedPlant: ModelListView){
        selectedPlant=_selectedPlant
    }
    @objc func TapPlantHandler(_ gestureRecognizer: UITapGestureRecognizer){
        guard let arView = arView else {
            return
        }
        let locations = arView.raycast(from: gestureRecognizer.location(in: arView), allowing: .estimatedPlane, alignment: .any)
        if let location=locations.first{
            let arAnchor = ARAnchor(transform: location.worldTransform)
            let anchor = AnchorEntity(anchor: arAnchor)
            
            guard let loadModel = arModels?.furnitureScene?.findEntity(named: selectedPlant.selectedModel)?.clone(recursive: true)
            else{
                return
            }
            loadModel.setPosition(SIMD3(0.0,0.0,0.0), relativeTo: nil)
            // add modelEntity
            anchor.addChild(loadModel)
            //call and record loaded model
            if let modelLoaded = modelLoaded
            {
                modelLoaded(selectedPlant.selectedModel)
            }
            arView.session.add(anchor: arAnchor)
            // add anchor to the scene
            arView.scene.addAnchor(anchor)
        }
        
    }
    func loadWorldMap()
    {
        guard let arView = arView else {
            return
        }
        let userDefault = UserDefaults.standard
        
        if let data = userDefault.data(forKey: "worldMap") {
            guard let worldMapData = try? NSKeyedUnarchiver.unarchivedObject(ofClass: ARWorldMap.self, from: data) else {return}
            let configuration = ARWorldTrackingConfiguration()
            configuration.initialWorldMap = worldMapData
            configuration.planeDetection = .horizontal
            
            //the retrieved worldmap doesn't have any anchorentity, so loop through the world map, add entity back to the world map
            for anchor in worldMapData.anchors{
                let thisAnchor = AnchorEntity(anchor: anchor)
                let box = ModelEntity(mesh: .generateBox(size: 0.1), materials: [SimpleMaterial(color: .green, isMetallic: true)])
                thisAnchor.addChild(box)
                arView.scene.addAnchor(thisAnchor)
            }
            arView.session.run(configuration)
        }
    }
    
    
    func SaveWorldMap()
    {
        guard let arView = arView else {
            return
        }
        arView.session.getCurrentWorldMap{worldMap,error in
            if let error = error {
                print(error)
                return
            }
            
            if let worldMap = worldMap {
                guard let data = try? NSKeyedArchiver.archivedData(withRootObject: worldMap, requiringSecureCoding: true) else {
                    return
                }
                let userDefault = UserDefaults.standard
                userDefault.set(data, forKey: "worldMap")
 
            }
            
        }
    }
}
