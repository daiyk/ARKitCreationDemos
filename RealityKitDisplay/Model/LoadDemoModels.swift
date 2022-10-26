//
//  LoadDemoModels.swift
//  CreateAndCombineViews
//
//  Created by Yukun Dai on 15.10.22.
//

import Foundation
import UIKit

enum ARViewType: String,Codable,CaseIterable{
    case placeObjects="Place Objects"
    case furnitureStore="Furniture Store"
    case measurment="Measure Distance"
    case lightDemo="Light Usage Demo"
    case placeholder = "place holder"
}
class LoadDemoModels: ObservableObject{
    @Published var demoInfos:[DemoInfo] = loadModelData("DemoInfos.json")
    func getIcon(_ appInfo: DemoInfo)->String{
        if appInfo.buttonLabel==nil{
            switch appInfo.type{
            case .placeObjects:
                return "hand.tap.fill"
            case .furnitureStore:
                return "cup.and.saucer.fill"
            case .measurment:
                return "ruler.fill"
            case .lightDemo:
                return "headlight.low.beam.fill"
            default:
                return "NotImplemented"
            }
        }
        else{
            return appInfo.buttonLabel!
        }
    }
    func getBackground(_ id:Int)->UIImage{
        let bgimg = demoInfos.first(where: {$0.id==id})?.backGroundImg ?? "photo.fill"
        if let img = UIImage(systemName: bgimg){
            return img
        }
        else if let img = UIImage(named: bgimg){
            return img
        }
        else{
            return UIImage(systemName: "photo.fill")!
        }
            
    }
    
}
func loadModelData<T:Codable>(_ filename: String)->T
{
    var data: Data
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else{
        fatalError("Decode and read data from \(filename) failed!")
    }
    do {
        data = try Data(contentsOf: file)
    }
    catch{
        fatalError("Decode \(filename) failed")
    }
    
    let decoder = JSONDecoder()
    do{
        return try decoder.decode(T.self, from: data)
    }
    catch{
        fatalError("Json decoder failed for file \(filename), with \(error)")
    }
}
