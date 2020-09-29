//
//  ViewModel.swift
//  SoftvisionTestApp
//
//  Created by Akshay Jain on 25/09/20.
//  Copyright © 2020 akshay. All rights reserved.
//

import Foundation
import HPGradientLoading

class ViewModel: NSObject {
    
    /// instance of NetworkServices
    private var apiService: NetworkServices!
   
    /// Model Data  from API Call
    private(set) var imageModel: ImageModel! {
        didSet {
            self.bindViewModelToController()
        }
    }
    
    ///Closure for ViewModel Binding
    var bindViewModelToController : (() -> Void) = {}
    
    /// Loader Status
    var isLoading: Bool = false {
        didSet {
            if isLoading {
                HPGradientLoading.shared.showLoading()
            } else {
                HPGradientLoading.shared.dismiss()
            }
           
        }
    }
    
    /// Overrding Initailization function
    override init() {
        super.init()
        HPGradientLoading.shared.configation.fromColor = .red
        HPGradientLoading.shared.configation.toColor = .orange
        self.apiService =  NetworkServices()
        callFuncToGetModelData()
    }
    
    ///Getting  details from API and responding to viewmodel handler
    func callFuncToGetModelData() {
        self.isLoading = true
        self.apiService.apiToData { (data) in
            self.imageModel = data
            DispatchQueue.main.async {
                self.isLoading = false
            }
        }
        
    }
    
}
