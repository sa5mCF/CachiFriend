//
//  HomeViewTests.swift
//  UITests
//
//  Created by Samuel Chavez on 14/05/26.
//

import XCTest

@testable import CachiFriend

final class HomeViewTests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("-UITests")
        app.launch()
    }
    
    override func tearDownWithError() throws {
        app = nil
    }
    
    func testHomeView_ElementsExists() {
        let appTitle = app.staticTexts["AppTitle"]

        XCTAssertTrue(appTitle.exists)
        XCTAssertEqual(appTitle.label, "Cachi Friend")
        
        let addRecordButton = app.buttons["AddRecordButton"]
        XCTAssertTrue(addRecordButton.exists)

    }
}
