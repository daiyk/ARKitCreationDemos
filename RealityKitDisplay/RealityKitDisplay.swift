//
//  RealityKitDisplay.swift
//  RealityKitDisplay
//
//  Created by Yukun Dai on 08.10.22.
//

import Foundation
import SwiftUI

@main
struct RealityKitDisplay: App{
    @StateObject var dataModel = ARModels()
    var body: some Scene{
            WindowGroup {
                ContentView()
            }
        }
}
