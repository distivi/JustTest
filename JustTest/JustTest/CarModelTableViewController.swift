//
//  CarModelTableViewController.swift
//  JustTest
//
//  Created by Stanislav Dymedyuk on 1/30/17.
//  Copyright © 2017 JustStan. All rights reserved.
//

import UIKit

protocol CarModelTableModelInjected {}

struct CarModelTableModelInjector {
    static var manufacturer: Manufacturer? {
        didSet {
            self.dataModel = ModelTypesScreenModel(manufacturer: self.manufacturer!)
        }
    }
    static var dataModel: ModelTypesScreenModel?
}

extension CarModelTableModelInjected {
    var dataModel: BaseTableViewModelProtocol? {
        get {
            return CarModelTableModelInjector.dataModel
        }
    }
}

class CarModelTableViewController: BaseTableViewController, CarModelTableModelInjected, ShowAlert {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = self.dataModel?.navigationTitle
                
        self.tableView.register(UINib(nibName: "CarModelTableViewCell", bundle: nil), forCellReuseIdentifier: "carModelCell")
    }
    
    // MARK: - BaseTableViewControllerProtocol
    
    override var spinnerTintColor: UIColor {
        get {
            return UIColor(colorLiteralRed: 0.19, green: 0.31, blue: 0.58, alpha: 1.0)            
        }
    }
    
    override func prepareDataForRefreshing() {
        self.dataModel?.setPaginationToZero()
    }
    
    override func fetchData(_ completition: @escaping (Void) -> (Void)) {
        if let dataModel = self.dataModel {
            if dataModel.isCanLoadMore {
                dataModel.loadMoreData({ (success, optError) -> (Void) in
                    DispatchQueue.main.async {
                        if let error = optError {
                            self.showErrorAlert(error.localizedDescription)
                        }
                        completition()
                    }
                })
            } else {
                completition()
            }
        }
    }
    
    override func elementsCount() -> Int {
        if let dataModel = self.dataModel {
            return dataModel.elementsCount
        }
        return 0
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CarModelTableViewCell = tableView.dequeueReusableCell(withIdentifier: "carModelCell", for: indexPath) as! CarModelTableViewCell
        
        let modelType = self.dataModel?.elementFor(indexPath) as! String
        cell.viewModel = CarModelViewModel(modelType: modelType)
        cell.backgroundColor = self.cellBackgroundFor(indexPath)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let title = NSLocalizedString("You Won!", comment: "You Won!")
        let message = self.dataModel?.alertMessageFor(indexPath)
        self.showAlert(title, message: message)
    }

}
