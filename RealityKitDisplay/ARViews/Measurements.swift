//
//  Measurements.swift
//  RealityKitDisplay
//
//  Created by Yukun Dai on 25.10.22.
//

import SwiftUI
import RealityKit
import ARKit

struct Measurements: View {
    @State var distance: Float = -1.0
    var body: some View {
        VStack{
            ARMeasureViewContainer(distance: $distance).edgesIgnoringSafeArea(.all)
            Spacer()
            HStack{
                Button{
                    print("GetClicked!")
                }
            label:{
                if distance>0{
                    Text(String(format:"%.3f m",distance))
                        .frame(width: 80)
                }
                else{
                    Text("All Good")
                        .frame(width:80)
                }
            }.buttonStyle(.borderedProminent)
                Button{
                    //reset the distance
                    distance = -1.0
                }
                label:{
                    Text("Reset")
                }.buttonStyle(.borderless)
            }.background(Color.primary
                .colorInvert()
                .opacity(0.75))
        }
    }
}
struct ARMeasureViewContainer:UIViewRepresentable{
    @Binding var distance:Float
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        arView.addGestureRecognizer(UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.TapGestureReceiver)))
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = .horizontal
        arView.session.run(config,options: [.removeExistingAnchors, .resetTracking])
        arView.addCoachingLayer()
        //add reference to the arview
        context.coordinator.arview = arView
    
        return arView
        
    }
    func makeCoordinator() -> MeasureCoodinator {
        return MeasureCoodinator(updateDistance: updateDistance)
    }
    func updateUIView(_ uiView: ARView, context: Context) {
        if distance<0{
            context.coordinator.ResetAnchors()
        }
    }
    func updateDistance(_ value: Float){
        distance = value
    }
}

struct Measurements_Previews: PreviewProvider {
    static var previews: some View {
        Measurements()
    }
}
