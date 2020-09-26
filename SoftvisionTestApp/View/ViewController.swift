//
//  ViewController.swift
//  SoftvisionTestApp
//
//  Created by Akshay Jain on 23/09/20.
//  Copyright © 2020 akshay. All rights reserved.
//

import UIKit

enum CONSTANT: String {
    case BASEURL = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
    case cellID = "myCell"
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let infoTableView = UITableView()
    var viewModel: ViewModel?
    
    var imageModelData = [Rows]()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(ViewController.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.red
        
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(infoTableView)
        infoTableView.estimatedRowHeight = 150
        infoTableView.rowHeight = UITableView.automaticDimension
        
        infoTableView.translatesAutoresizingMaskIntoConstraints = false
        infoTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        infoTableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        infoTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        infoTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        infoTableView.dataSource = self
        infoTableView.delegate = self
        infoTableView.register(TableViewCell.self, forCellReuseIdentifier: CONSTANT.cellID.rawValue)
        self.infoTableView.addSubview(self.refreshControl)
       callToViewModelForUIUpdate()
    }
    func callToViewModelForUIUpdate() {
        
        self.viewModel =  ViewModel()
        self.viewModel?.bindViewModelToController = {
            self.updateDataSource()
        }
    }
    func updateDataSource() {
        
         guard let imageData = self.viewModel?.imageModel.rows else {
                            return
            
        }
        self.imageModelData = imageData
        DispatchQueue.main.async {
        self.navigationItem.title = self.viewModel?.imageModel.title
        self.infoTableView.reloadData()
        }
       }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        callToViewModelForUIUpdate()
        refreshControl.endRefreshing()
    }
    
}
extension ViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageModelData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable force_cast
        let cell = tableView.dequeueReusableCell(withIdentifier: CONSTANT.cellID.rawValue, for: indexPath) as! TableViewCell
        // swiftlint:enable force_cast
        cell.setupImage(with: self.imageModelData[indexPath.row])
        return cell
    }
    
}