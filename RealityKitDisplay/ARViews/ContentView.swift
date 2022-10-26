//
//  ContentView.swift
//  RealityKitDisplay
//
//  Created by Yukun Dai on 03.09.22.
//

import SwiftUI
import RealityKit
import ARKit

struct ContentView : View {
    //data objects
    @StateObject var demoInfos:LoadDemoModels = LoadDemoModels()
    @StateObject var arData: ARModels = ARModels()
    var body: some View {
        ARMainMenuView()
            .environmentObject(demoInfos)
            .environmentObject(arData)
    
    }
}


#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
