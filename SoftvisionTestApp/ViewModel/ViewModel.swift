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
    
    private var apiService: NetworkServices!
   
    private(set) var imageModel: ImageModel! {
        didSet {
            self.bindViewModelToController()
        }
    }
    
    var bindViewModelToController : (() -> Void) = {}
    
    var isLoading: Bool = false {
        didSet {
            if isLoading {
                HPGradientLoading.shared.showLoading()
            } else {
                HPGradientLoading.shared.dismiss()
            }
           
        }
    }
    override init() {
        super.init()
        HPGradientLoading.shared.configation.fromColor = .red
        HPGradientLoading.shared.configation.toColor = .orange
        self.apiService =  NetworkServices()
        callFuncToGetModelData()
    }
    
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
