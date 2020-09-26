//
//  ViewModel.swift
//  SoftvisionTestApp
//
//  Created by Akshay Jain on 25/09/20.
//  Copyright © 2020 akshay. All rights reserved.
//

import Foundation

class ViewModel: NSObject {
    
    private var apiService: NetworkServices!
    private(set) var imageModel: ImageModel! {
        didSet {
            self.bindViewModelToController()
        }
    }
    
    var bindViewModelToController : (() -> Void) = {}
    
    override init() {
        super.init()
        self.apiService =  NetworkServices()
        callFuncToGetModelData()
    }
    
    func callFuncToGetModelData() {
        self.apiService.apiToData { (data) in
            self.imageModel = data
        }
     
    }
    
}

