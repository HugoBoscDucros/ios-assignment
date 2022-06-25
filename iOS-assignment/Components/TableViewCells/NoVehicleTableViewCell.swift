//
//  NoVehicleTableViewCell.swift
//  iOS-assignment
//
//  Created by Hugo Bosc-Ducros on 25/06/2022.
//

import UIKit

class NoVehicleTableViewCell: UITableViewCell {
    
    static var nib:UINib {
        return UINib(nibName: "NoVehicleTableViewCell", bundle: nil)
    }
    
    @IBOutlet weak var label: DottLabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var subLabel: DottLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.label.text = "Loading data... 🛴"
        activityIndicator.startAnimating()
        self.subLabel.text = ""
    }
    
    func set(_ error:Error?, attemptCount:Int? = nil) {
        guard let error = error else {return}
        var text = "Something went wrong fetching data:\n\n\(error.localizedDescription)\n\nlet's try again"
        if let attemptCount = attemptCount, attemptCount > 0 {
            text += ", attempts n°\(attemptCount)"
        }
        text += "..."
        self.subLabel.text = text
        //changing sublabel text seems to stop activityIndicator animation probably due to fact that it need main thread to be executed.
        activityIndicator.startAnimating()
    }
    
}
