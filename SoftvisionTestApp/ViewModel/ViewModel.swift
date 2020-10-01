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
        let resource = Resource(url: URL(string: ApplicationURL.BaseUrl)!)
        self.apiService.fetchData(resource) { (result) in
            DispatchQueue.main.async {
                self.isLoading = false
            }
            switch result {
            case .success(let data):
                do {
                    guard let utf8Data = String(decoding: data, as: UTF8.self).data(using: .utf8) else {
                        return
                    }
                    let items = try JSONDecoder().decode(ImageModel.self, from: utf8Data)
                    self.imageModel = items
                } catch {
                    print("unable to decode")
                     
                }
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
    }
    
}
