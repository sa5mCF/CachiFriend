//
//  MockDataBaseService.swift
//  CachiFriend
//
//  Created by Samuel Chavez on 30/03/26.
//
import Foundation

class MockDataBaseService: DataBasesServiceProtocol {
    
    let mockRecords = MockRecordsHelper.mockRecords()
    
    func fetchRecords(filter: FilterItemModel) async -> [RecordModel] {
        //return MockRecordsHelper.applyFilter(to: mockRecords, by: filter)
        
        return [
            RecordModel(id: "1", title: "Test", date: Date(), type: .income, amount: 100.0,),
            RecordModel(id: "2", title: "Test 2", date: Date(), type: .outcome, amount: 100.0,)
        ]
    }
    
    func saveRecord(_ record: RecordModel) async -> Bool {
        return false
    }
    
    func updateRecord(_ record: RecordModel) async -> Bool {
        return false
    }
    
    func deleteRecord(_ record: RecordModel) async -> Bool {
        return false
    }
    
    func getTotals() async -> (income: Double, outcome: Double) {
        return (0.0, 0.0)
    }
    
}
