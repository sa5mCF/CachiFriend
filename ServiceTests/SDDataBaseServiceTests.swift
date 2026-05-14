//
//  SDDataBaseServiceTests.swift
//  ServiceTests
//
//  Created by Samuel Chavez on 14/05/26.
//

import XCTest

@testable import CachiFriend

final class SDDataBaseServiceTests: XCTestCase {
    
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
        super.tearDown()
    }
    
    private func clearDataBase() async {
        let allRecords = await self.databaseService.fetchRecords(filter: .today)
        
        for record in allRecords {
            _ = await self.databaseService.deleteRecord(record)
        }
        
    }
    
    func testSaveNewRecord_ShouldPersistRecord() async {
        let expectation = XCTestExpectation(description: "Save record")
        
        let record = RecordModel(id: UUID().uuidString, title: "test record", date: Date(), type: .income, amount: 100.0)
        

        let success = await self.databaseService.saveRecord(record)
        XCTAssertTrue(success)
        
        let fetchRecord = await self.databaseService.fetchRecords(filter: .today)
        XCTAssertEqual(fetchRecord.count, 1)
        
        expectation.fulfill()
    }

    
    func testFetchRecord_ShouldReturnStporedRecord() async {
        let expectation = XCTestExpectation(description: "Fetch record")
        
        let record = RecordModel(id: UUID().uuidString, title: "test record", date: Date(), type: .income, amount: 100.0)
        
        _ = await self.databaseService.saveRecord(record)
        
        let fetchRecord = await self.databaseService.fetchRecords(filter: .today)
        XCTAssertGreaterThan(fetchRecord.count, 0, "Should return stored record")
        
        expectation.fulfill()
    }
    
}


