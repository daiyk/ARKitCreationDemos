//
//  MeasureCoordinator.swift
//  RealityKitDisplay
//
//  Created by Yukun Dai on 25.10.22.
//

import Foundation
import UIKit
import RealityKit
import ARKit
class MeasureCoodinator{
    var arview: ARView?
    var startAnchor: AnchorEntity?
    var endAnchor: AnchorEntity?
    var updateDistance: (Float)->Void
    init(arview: ARView? = nil, startAnchor: AnchorEntity? = nil, endAnchor: AnchorEntity? = nil, updateDistance: @escaping (Float) -> Void) {
        self.arview = arview
        self.startAnchor = startAnchor
        self.endAnchor = endAnchor
        self.updateDistance = updateDistance
    }
    func ResetAnchors()->Void{
        if let startAnchor = startAnchor{
            arview?.scene.removeAnchor(startAnchor)
        }
        startAnchor = nil
        if let endAnchor = endAnchor{
            arview?.scene.removeAnchor(endAnchor)
        }
        endAnchor = nil
    }
    @objc func TapGestureReceiver(_ recognizer: UITapGestureRecognizer){
        guard let arview = arview else{
            return
        }
        //change color of the detected models
        let location = recognizer.location(in: arview)
        
        let results = arview.raycast(from: location, allowing: .estimatedPlane, alignment: .horizontal)
        if let result = results.first{
            if startAnchor==nil{
                startAnchor = AnchorEntity(raycastResult: result)
                //add virtual label
                let box = ModelEntity(mesh: .generateBox(size: 0.005),materials: [SimpleMaterial(color: .green, isMetallic: false)])
                
                guard let startAnchor = startAnchor else{
                    return
                }
                startAnchor.addChild(box)
                arview.scene.addAnchor(startAnchor)
            }
            else if endAnchor==nil{
                endAnchor = AnchorEntity(raycastResult: result)
                let box = ModelEntity(mesh: .generateBox(size: 0.005),materials: [SimpleMaterial(color: .red, isMetallic: false)])
                
                guard let endAnchor = endAnchor else{
                    return
                }
                endAnchor.addChild(box)
                arview.scene.addAnchor(endAnchor)
                
                //update distance
                let distance = simd_distance(startAnchor!.position(relativeTo: nil), endAnchor.position(relativeTo: nil))
                updateDistance(distance)
            }
        }
    }
}
