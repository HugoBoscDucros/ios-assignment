//
//  VehicleViewController.swift
//  iOS-assignment
//
//  Created by Hugo Bosc-Ducros on 21/06/2022.
//

import UIKit
import AssignmentCore

extension VehicleViewController {
    
    static func fromNib(_ vehicle:Vehicle) -> VehicleViewController {
        let vc = VehicleViewController(nibName: "VehicleViewController", bundle: nil)
        vc.set(vehicle)
        return vc
    }
}

class VehicleViewController: UIViewController {
    
    @IBOutlet weak var closeButton: CloseButton!
    @IBOutlet weak var titleLabel: TitleLabel!
    @IBOutlet weak var dottImageView: DottImageView!
    
    var identificationCode:String? = nil
    var qrURL:String? = nil
    var qrImage:UIImage? = nil {
        didSet {
            dottImageView.image = qrImage
            UpdateLoadingState()
        }
    }
    
    var activityIndicator = UIActivityIndicatorView()
    
    
    //MARK: - View controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setActivityIndicator()
        //you can uncomment these line to test "low connection" app comportment
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
        self.downloadQRCodeImage()
//        }
        self.setUI()
    }
    
    
    //MARK: - Settings
    
    private func set(_ vehicle:Vehicle) {
        self.identificationCode = vehicle.identificationCode
        self.qrURL = vehicle.qrURL
    }
    
    private func setActivityIndicator() {
        activityIndicator.center = dottImageView.center
        self.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    private func setUI() {
        self.titleLabel.text = self.identificationCode
    }
    
    
    //MARK: - Actions
    
    @IBAction func closeButtonDidTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    //MARK: - Utils
    
    private func downloadQRCodeImage() {
        guard let stringURL = qrURL,
              let url = URL(string: stringURL),
        let data = try? Data(contentsOf: url),
        let image = UIImage(data: data)
        else {
            return
        }
        DispatchQueue.main.async {
            self.qrImage = image
        }
    }
    
    var isLoading:Bool {
        return self.qrImage == nil
    }
    
    private func UpdateLoadingState() {
        if isLoading {
            self.activityIndicator.stopAnimating()
        } else {
            self.activityIndicator.startAnimating()
        }
        self.activityIndicator.isHidden = !isLoading
        self.dottImageView.isHidden = isLoading
    }

}
