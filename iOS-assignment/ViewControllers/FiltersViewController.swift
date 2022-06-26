//
//  FiltersViewController.swift
//  iOS-assignment
//
//  Created by Hugo Bosc-Ducros on 21/06/2022.
//

import UIKit
import AssignmentCore

extension FiltersViewController {
    static var fromNib:FiltersViewController {
        return FiltersViewController(nibName: "FiltersViewController", bundle: nil)
    }
}

class FiltersViewController: UIViewController {
    
    @IBOutlet weak var switchRedGreen: UISwitch!
    @IBOutlet weak var switchBlueRed: UISwitch!
    @IBOutlet weak var switchPinkYellow: UISwitch!
    @IBOutlet weak var switchYellowBlue: UISwitch!
    
    
    //MARK: - ViewController life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sync(assignmentCore.vehicleService.filteringColorTags)
    }
    
    
    //MARK: - Actions
    
    @IBAction func closeButtonDidTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    

    @IBAction func applyButtonDidTapped(_ sender: Any) {
        var tags = Set<ColorTag>()
        for tag in ColorTag.allCases {
            let uiSwitch = self.getSwitch(for: tag)
            if uiSwitch?.isOn ?? true {
                tags.update(with: tag)
            }
        }
        assignmentCore.vehicleService.update(filteringColorTags: tags)
        self.dismiss(animated: true)
    }
    
    
    //MARK: - Utils
    
    //getting corresponding ColorTag from UISwitch
    private func getTag(for uiSwitch:UISwitch) -> ColorTag {
        if uiSwitch == switchRedGreen {
            return .redGreen
        } else if uiSwitch == switchBlueRed {
            return .blueRed
        } else if uiSwitch == switchPinkYellow {
            return .pinkYellow
        } else if uiSwitch == switchYellowBlue {
            return .yellowBlue
        }
        return .unknown
    }

    //getting corresponding UISwitch from ColorTag enum value
    private func getSwitch(for tag:ColorTag) -> UISwitch? {
        switch tag {
        case .redGreen: return switchRedGreen
        case .blueRed: return switchBlueRed
        case .pinkYellow: return switchPinkYellow
        case .yellowBlue: return switchYellowBlue
        case .unknown:return nil
        }
    }
    
    //use to set UISwitch states (isOn) from corresponding data value
    private func sync(_ filters: Set<ColorTag>) {
        for tag in ColorTag.allCases {
            let shouldBeOn = filters.contains(tag)
            self.getSwitch(for: tag)?.setOn(shouldBeOn, animated: false)
        }
    }

}
