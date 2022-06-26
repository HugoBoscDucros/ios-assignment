//
//  ColorTag+Extension.swift
//  iOS-assignment
//
//  Created by Hugo Bosc-Ducros on 25/06/2022.
//

import Foundation
import UIKit
import AssignmentCore

extension ColorTag {
    var image:UIImage? {
        switch self {
        case .redGreen: return UIImage(named: "icon/redGreenScooter")
        case .blueRed: return UIImage(named: "icon/blueRedScooter")
        case .pinkYellow: return UIImage(named: "icon/pinkYellowScooter")
        case .yellowBlue: return UIImage(named: "icon/yellowBlueScooter")
        case .unknown: return nil
        }
    }
}
