//
//  HomeViewModelTest.swift
//  ServiceTests
//
//  Created by Samuel Chavez on 08/05/26.
//

import XCTest

@testable import CachiFriend

final class HomeViewModelTest: XCTestCase {

    
    var viewModel: HomeViewModel!
    var mockDataService: MockDataBaseService!
    var stubDatabaseService: StubDataBaseService!
    
    override func setUp(){
        super.setUp()
        mockDataService = MockDataBaseService()
        stubDatabaseService = StubDataBaseService()
    }
    
    override func tearDown(){
        viewModel = nil
        mockDataService = nil
        stubDatabaseService = nil
        super.tearDown()
    }
    
    @MainActor
    func testGetTotals_UpdateTotalIncomeAndOutcome() async {
        viewModel = HomeViewModel(mockDataService)
        
        let expectation = XCTestExpectation(description: "get totals from database")
        
        Task {
            viewModel.getTotals()
            expectation.fulfill()
            
        }
        
        await fulfillment(of: [expectation], timeout: 1.0)
        
        XCTAssertEqual(viewModel.totalIncome, 0.0)
        XCTAssertEqual(viewModel.totalOutcome, 0.0)
        
    }
    
}
