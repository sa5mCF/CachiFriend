//
//  HomeViewModelIntegrationTest.swift
//  ServiceTests
//
//  Created by Samuel Chavez on 13/05/26.
//

import XCTest

@testable import CachiFriend

final class HomeViewModelIntegrationTest: XCTestCase {

    var viewModel: HomeViewModel!
    var databaseService: SDDataBaseService!
    
    
    override func setUp() {
        super.setUp()
        
        let expectation = XCTestExpectation(description: "Init Data Base service")
        
        Task { @MainActor in
            self.databaseService = SDDataBaseService()
            await self.clearDataBase()
            self.viewModel = HomeViewModel(self.databaseService)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2.0)
    }
    
    override func tearDown() {
        self.viewModel = nil
        self.databaseService = nil
        super.tearDown()
    }
    
    private func clearDataBase() async {
        let allRecords = await self.databaseService.fetchRecords(filter: .today)
        
        for record in allRecords {
            _ = await self.databaseService.deleteRecord(record)
        }
        
    }
    
    @MainActor
    func testGetRecords_UpdatesRecordsArray() async {
        let expectation = XCTestExpectation(description: "Fetch Records")
        
        Task {
            viewModel.getRecords()
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 2.0)
        XCTAssertNotNil(viewModel.records, "Records should not be nil")
        
    }
    
    @MainActor
    func testGetTotals_UpdatesTotalIncomeOutcome() async {
        let expectation = XCTestExpectation(description: "Fetch Totals")
        
        Task {
            viewModel.getTotals()
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 2.0)
        
        XCTAssertNotNil(viewModel.totalIncome, "Total Income should not be nil")
        XCTAssertNotNil(viewModel.totalOutcome, "Total Outcome should not be nil")
        
    }
    

}
