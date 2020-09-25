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

    var sut: URLSession!
    var viewModel: ViewModel?
    
    override func setUpWithError() throws {
        super.setUp()
        sut = URLSession(configuration: .default)
        viewModel = ViewModel()
    }

    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }

    func testValidCall() {
        let promise = expectation(description: "fetchedSuccess")
        viewModel =  ViewModel()
        viewModel?.bindViewModelToController = {
            guard let imageData = viewModel?.imageModel.rows else {
                XCTFail("Failed")
                return
           }
            promise.fulfill()
        }
        wait(for: [promise], timeout: 10)
        
      
//      let url =
//        URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")
//
//      let promise = expectation(description: "Status code: 200")
//
//      let dataTask = sut.dataTask(with: url!) { _, response, error in
//
//        if let error = error {
//          XCTFail("Error: \(error.localizedDescription)")
//          return
//        } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
//          if statusCode == 200 {
//
//            promise.fulfill()
//          } else {
//            XCTFail("Status code: \(statusCode)")
//          }
//        }
//      }
//      dataTask.resume()
//
//      wait(for: [promise], timeout: 10)
   }

}
