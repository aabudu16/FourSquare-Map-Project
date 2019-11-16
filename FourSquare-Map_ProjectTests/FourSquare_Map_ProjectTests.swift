//
//  FourSquare_Map_ProjectTests.swift
//  FourSquare-Map_ProjectTests
//
//  Created by Mr Wonderful on 11/4/19.
//  Copyright © 2019 Mr Wonderful. All rights reserved.
//

import XCTest
@testable import FourSquare_Map_Project

class FourSquare_Map_ProjectTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    private func getMap() -> Data? {
                    let bundle = Bundle(for: type(of: self))
                    guard let pathToData = bundle.path(forResource: "testFourSquareAPI", ofType: ".json")  else {
                        XCTFail("couldn't find Json")
                        return nil
                    }
                    let url = URL(fileURLWithPath: pathToData)
                    do {
                        let data = try Data(contentsOf: url)
                        return data
                    } catch let error {
                        fatalError("couldn't find data \(error)")
                    }
                }

        func testMap() {
             
                    let data = getMap() ?? Data()
           let mapData = Foursquare.getTestData(from: data) ?? []
                 print(mapData)
                   XCTAssertTrue(mapData.count > 0, "No map data was loaded")
            }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
