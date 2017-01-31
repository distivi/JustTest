//
//  ManufacturerTableViewController.swift
//  JustTest
//
//  Created by Stanislav Dymedyuk on 1/30/17.
//  Copyright © 2017 JustStan. All rights reserved.
//

import UIKit

protocol ManufacturerTableModelInjected {}

struct ManufacturerTableModelInjector {
    static var dataModel: BaseTableViewModelProtocol = ManufacturerScreenModel()
}

extension ManufacturerTableModelInjected {
    var dataModel: BaseTableViewModelProtocol {
        get {
            return ManufacturerTableModelInjector.dataModel
        }
    }
}


class ManufacturerTableViewController: BaseTableViewController, ManufacturerTableModelInjected, ShowAlert {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = self.dataModel.navigationTitle
                
        self.tableView.register(UINib(nibName: "ManufacturerTableViewCell", bundle: nil), forCellReuseIdentifier: "manufacturerCell")
    }
    
    // MARK: - BaseTableViewControllerProtocol
    
    override var spinnerTintColor: UIColor {
        get {
            return UIColor(colorLiteralRed: 0.91, green: 0.5, blue: 0.21, alpha: 1.0)
        }
    }
    
    override func prepareDataForRefreshing() {
        self.dataModel.setPaginationToZero()
    }
    
    override func fetchData(_ completition: @escaping (Void) -> (Void)) {
        
        if dataModel.isCanLoadMore {
            dataModel.loadMoreData({ (success, optError) -> (Void) in
                    if let error = optError {
                        self.showErrorAlert(error.localizedDescription)
                    }                
                    completition()
            })
        } else {
            completition()
        }
    }
    
    override func elementsCount() -> Int {
        return dataModel.elementsCount
    }


    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ManufacturerTableViewCell = tableView.dequeueReusableCell(withIdentifier: "manufacturerCell", for: indexPath) as! ManufacturerTableViewCell
        
        let manufacturer = self.dataModel.elementFor(indexPath) as! Manufacturer
        cell.viewModel = ManufacturerTableViewCellModel(manufacturer: manufacturer)
        cell.backgroundColor = self.cellBackgroundFor(indexPath)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let manufacturer = self.dataModel.elementFor(indexPath) as! Manufacturer
        CarModelTableModelInjector.manufacturer = manufacturer
        
        self.performSegue(withIdentifier: "carModelsSegue", sender: nil)
    }    
}
