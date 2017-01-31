//
//  BaseTableViewController.swift
//  JustTest
//
//  Created by Stanislav Dymedyuk on 1/30/17.
//  Copyright © 2017 JustStan. All rights reserved.
//

import UIKit

protocol BaseTableViewControllerProtocol {
    var spinnerTintColor: UIColor {get}
    func prepareDataForRefreshing()
    func fetchData(_ completition: @escaping (Void) -> (Void))
    func elementsCount() -> Int
}

class BaseTableViewController: UITableViewController, BaseTableViewControllerProtocol {
    
    weak var spinner: UIActivityIndicatorView?
    let customLightGray = UIColor(white: 0.95, alpha: 1.0)
    var isLoading: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupFootterLoader()
        self.setupPullToRefresh()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.loadNewData()
    }
    
    // MARK: - Setup
    
    func setupPullToRefresh() {
        
        
        // Pull To Refresh Code
        if (self.refreshControl == nil){
            let refreshControl = UIRefreshControl()
            
            refreshControl.attributedTitle = NSAttributedString(string: NSLocalizedString("Refreshing...", comment: "Refreshing..."))
            refreshControl.tintColor = self.spinnerTintColor
            refreshControl.addTarget(self, action: #selector(reloadData(_:)), for: .valueChanged)
            
            self.refreshControl = refreshControl
            
            self.tableView.addSubview(refreshControl)
        }        
    }
    
    func setupFootterLoader() {
        let footerLoaderView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 40.0))
        footerLoaderView.backgroundColor = self.customLightGray
        
        let activityView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.white )
        activityView.translatesAutoresizingMaskIntoConstraints = false
        activityView.hidesWhenStopped = true
        activityView.color = self.spinnerTintColor
        
        footerLoaderView.addSubview(activityView)
        
        let alignVertical = NSLayoutConstraint(item: activityView,
                                               attribute: .centerX,
                                               relatedBy: .equal,
                                               toItem: footerLoaderView,
                                               attribute: .centerX,
                                               multiplier: 1.0,
                                               constant: 0.0)
        let alignHorizontal = NSLayoutConstraint(item: activityView,
                                               attribute: .centerY,
                                               relatedBy: .equal,
                                               toItem: footerLoaderView,
                                               attribute: .centerY,
                                               multiplier: 1.0,
                                               constant: 0.0)

        
        footerLoaderView.addConstraints([alignVertical, alignHorizontal])
        
        self.tableView.tableFooterView = footerLoaderView
        self.spinner = activityView
    }
    
    // MARK: - Style
    
    func cellBackgroundFor(_ indexPath: IndexPath) -> UIColor {
        if indexPath.row % 2 == 0 {
            return self.customLightGray
        }
        return UIColor.white
    }
    
    // MARK: - Load data
    
    @objc private func reloadData(_ sender: UIRefreshControl) {
        
        self.prepareDataForRefreshing()
        self.loadNewData()
    }
    
    private func loadNewData() {
        if self.isLoading == true {
            return
        }
        
        self.isLoading = true
        
        if self.refreshControl?.isRefreshing == false {
            self.tableView.tableFooterView?.isHidden = false
            self.spinner?.startAnimating()
        }
        
        
        self.fetchData { _ in
            DispatchQueue.main.async {() -> Void in
                self.spinner?.stopAnimating()
                self.tableView.tableFooterView?.isHidden = true
                self.isLoading = false
                self.refreshControl?.endRefreshing()
                
                
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - BaseTableViewControllerProtocol
    
    var spinnerTintColor: UIColor {
        get {
            return UIColor.white
        }
    }
    
    func prepareDataForRefreshing() {
        assert(false, "Implement logic in delivary class")
    }
    
    func fetchData(_ completition: @escaping (Void) -> (Void)) {
        assert(false, "Implement logic in delivary class")
    }
    
    func elementsCount() -> Int {
        return 0
    }    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.elementsCount()
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        let deltaOffset = maximumOffset - currentOffset
        
        if deltaOffset <= 0 && self.elementsCount() > 0 {
            self.loadNewData()
        }
    }
}
