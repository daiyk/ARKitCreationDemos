//
//  Extension.swift
//  RealityKitDisplay
//
//  Created by Yukun Dai on 04.09.22.
//

import Foundation
import RealityKit
import ARKit
extension ARView{
    func addCoachingLayer()
    {
        let coachingLayer = ARCoachingOverlayView()
        coachingLayer.autoresizingMask=[.flexibleWidth,.flexibleHeight]
        coachingLayer.goal = .horizontalPlane
        coachingLayer.session=self.session
        self.addSubview(coachingLayer)
    }
    
}
extension UIColor{
    static func random()->UIColor{
        return UIColor(displayP3Red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1), alpha: 1.0)
    }
}
