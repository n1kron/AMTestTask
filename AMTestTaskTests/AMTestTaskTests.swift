//
//  AMTestTaskTests.swift
//  AMTestTaskTests
//
//  Created by  Kostantin Zarubin on 05.07.2018.
//  Copyright © 2018  Kostantin Zarubin. All rights reserved.
//

import XCTest
@testable import AMTestTask

class AMTestTaskTests: XCTestCase {
    var session: URLSession!
    
    override func setUp() {
        super.setUp()
        session = URLSession(configuration: URLSessionConfiguration.default)
    }
    
    override func tearDown() {
        session = nil
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testValidCallGetsHTTPStatus() {
        let url = URL(string: "https://api.pexels.com/v1/curated?per_page=40&page=1")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("563492ad6f917000010000018032db63b2444f18bb33ac30312e2b84", forHTTPHeaderField: "Authorization")
        let promise = expectation(description: "Status code: 200")
        let dataTask = session.dataTask(with: request) { data, response, error in
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
        waitForExpectations(timeout: 5, handler: nil)
    }
    
}
