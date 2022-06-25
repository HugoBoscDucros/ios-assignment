//
//  VehiclesViewController.swift
//  iOS-assignment
//
//  Created by Hugo Bosc-Ducros on 21/06/2022.
//

import UIKit

extension VehiclesViewController {
    
    static var fromNib:VehiclesViewController {
        return VehiclesViewController(nibName: "VehiclesViewController", bundle: nil)
    }
}

class VehiclesViewController: UIViewController, DataSyncObserver, FileringObserver, UITableViewDataSource, UITableViewDelegate {
    

    @IBOutlet weak var tableView: DottTableView!
    @IBOutlet weak var filterButton: FilterButton!
    
    var vehicles = [Vehicle]()
    var dataFetchingErrors = [Error]()
    
    
    //MARK: - ViewConntroller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTableView()
        assignmentCore.set(vehicleObserver:self)
        assignmentCore.set(filteringObserver: self)
    }
    
    
    //MARK: - Settings
    
    private func setTableView() {
        self.tableView.register(VehicleTableViewCell.nib, forCellReuseIdentifier: "vehicle")
        self.tableView.register(NoVehicleTableViewCell.nib, forCellReuseIdentifier: "noVehicle")
        //DataSource could be in a specific class but this VC is quite low code so I assume to keep this responsability here to not multiply classes & files 
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.tableFooterView = UIView()
    }
    
    
    //MARK: - Actions
    
    @IBAction func filterButtonDidTapped(_ sender: Any) {
        self.present(FiltersViewController.fromNib, animated: true, completion: nil)
    }
    
    
    //MARK: - DataSyncObserver
    
    func didUpdate(_ vehicles: [Vehicle]) {
        self.vehicles = vehicles
        self.tableView.reloadData()
    }
    
    func didFailUpdateData(_ error: Error) {
        guard vehicles.count < 1 else {return}
        self.dataFetchingErrors.append(error)
        self.tableView.reloadData()
    }
    
    //MARK: - FilteringObserver
    
    func didUpdate(_ filters: Set<ColorTag>) {
        let numberOfFilter = ColorTag.allCases.count - filters.count
        self.filterButton.isFilterActive = (numberOfFilter > 0)
    }
    
    //MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return max(vehicles.count,1)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if vehicles.count > 0 {
            return getVehicleTableViewCell(at: indexPath)
        } else {
            return getNoVehicleTableViewCell(at: indexPath)
        }
    }
    
    //MARK: - getting tableView cells methods
    
    private func getVehicleTableViewCell(at indexPath:IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "vehicle", for: indexPath)
        if let cell = cell as? VehicleTableViewCell {
            cell.set(vehicles[indexPath.row])
        }
        return cell
    }
    
    private func getNoVehicleTableViewCell(at indexPath:IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noVehicle", for: indexPath)
        if let cell = cell as? NoVehicleTableViewCell {
            cell.set(dataFetchingErrors.last, attemptCount: dataFetchingErrors.count)
        }
        return cell
    }
    
    
    //MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard vehicles.count > 0 else {return}
        let destination = VehicleViewController.fromNib(vehicles[indexPath.row])
        self.present(destination, animated: true) {
            self.tableView.deselectRow(at: indexPath, animated: false)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if vehicles.count > 0 {
            return 44
        }
        return self.tableView.frame.height
    }

}
