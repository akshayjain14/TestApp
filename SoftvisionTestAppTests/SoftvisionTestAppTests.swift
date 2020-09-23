//
//  SoftvisionTestAppTests.swift
//  SoftvisionTestAppTests
//
//  Created by Akshay Jain on 23/09/20.
//  Copyright © 2020 akshay. All rights reserved.
//

import XCTest

class SoftvisionTestAppTests: XCTestCase {

    var sut: URLSession!
    override func setUpWithError() throws {
        super.setUp()
        sut = URLSession(configuration: .default)
    }

    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()
    }

    func testValidCall() {
      
      let url =
        URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")
     
      let promise = expectation(description: "Status code: 200")
    
      let dataTask = sut.dataTask(with: url!) { data, response, error in
    
        if let error = error {
          XCTFail("Error: \(error.localizedDescription)")
          return
        } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
          if statusCode == 200 {
            
            promise.fulfill()
          } else {
            XCTFail("Status code: \(statusCode)")
          }
        }
      }
      dataTask.resume()
      
      wait(for: [promise], timeout: 10)
    }

}
