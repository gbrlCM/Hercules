//
//  IntensityType.swift
//  Hercules
//
//  Created by Gabriel Ferreira de Carvalho on 17/07/21.
//

import Foundation

enum IntensityType: Int, CaseIterable {
    
    case rm1
    case areaOfRm
    case weight
    case bodyWeight
    case seconds
    
    var name: String {
        
        let name: String
        
        switch self {
        case .areaOfRm: name = "Area of RM"
        case .bodyWeight: name = "Body weight"
        case .rm1: name = "1RM"
        case .seconds: name = "Seconds"
        case .weight: name = "Weight(lbs)"
        }
        return name
    }
}
