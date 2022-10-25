//
//  PlaceObjectsCoordinator.swift
//  RealityKitDisplay
//
//  Created by Yukun Dai on 24.10.22.
//

import Foundation
import UIKit
import ARKit
import RealityKit

class PlaceObjectsCoordinator{
    var arview:ARView?
    @objc func TapGestureReceiver(_ recognizer: UITapGestureRecognizer){
        guard let arview = arview else{
            return
        }
        //change color of the detected models
        let location = recognizer.location(in: arview)
        if let model = arview.entity(at: location) as? ModelEntity{
            model.model?.materials = [SimpleMaterial(color: .random(), isMetallic: false)]
        }
        
    }
}
