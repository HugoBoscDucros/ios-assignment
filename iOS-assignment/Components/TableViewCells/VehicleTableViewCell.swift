//
//  TableViewCell.swift
//  iOS-assignment
//
//  Created by Hugo Bosc-Ducros on 21/06/2022.
//

import UIKit
import AssignmentCore

class VehicleTableViewCell: UITableViewCell {
    
    static var nib:UINib {
        return UINib(nibName: "VehicleTableViewCell", bundle: nil)
    }

    @IBOutlet weak var label: DottLabel!
    @IBOutlet weak var colorImageView: UIImageView!
    
    
    //MARK: - Settings data from Vehicle
    func set(_ vehicle:Vehicle) {
        self.label.text = vehicle.identificationCode
        self.colorImageView.image = vehicle.colorTag.image
    }
    
}
