//
//  ModelListView.swift
//  RealityKitDisplay
//
//  Created by Yukun Dai on 03.09.22.
//

import Foundation
import RealityKit
class ModelListView: ObservableObject{
    @Published var selectedModel: String = ""
}

class MapSaveView: ObservableObject{
    //create a function pointer which is required to return void
    @Published var OnSave: ()->Void = {}
}

