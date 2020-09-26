//
//  SoftvisionTestAppTests.swift
//  SoftvisionTestAppTests
//
//  Created by Akshay Jain on 23/09/20.
//  Copyright © 2020 akshay. All rights reserved.
//

import XCTest

@testable import SoftvisionTestApp

class SoftvisionTestAppTests: XCTestCase {

   
    var viewModel: ViewModel?
    
    override func setUpWithError() throws {
        super.setUp()
        viewModel = ViewModel()
    }

    override func tearDownWithError() throws {
        
        super.tearDown()
    }

    func testValidCall() {
        let promise = expectation(description: "fetchedSuccess")
        viewModel =  ViewModel()
        viewModel?.bindViewModelToController = {
            guard (self.viewModel?.imageModel.rows) != nil else {
                XCTFail("Failed")
                return
           }
            promise.fulfill()
        }
        wait(for: [promise], timeout: 10)

   }

}
