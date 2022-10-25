//
//  DemoInfo.swift
//  RealityKitDisplay
//
//  Created by Yukun Dai on 09.10.22.
//

import Foundation
import SwiftUI
struct DemoInfo: Codable,Hashable,Identifiable{
    var id: Int
    var type: ARViewType
    var title: String
    var description: String
    var backGroundImg: String?
    var buttonLabel: String?
}
