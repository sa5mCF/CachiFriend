//
//  MockDataBaseService.swift
//  CachiFriend
//
//  Created by Samuel Chavez on 30/03/26.
//

class MockDataBaseService: DataBasesServiceProtocol {
    
    let mockRecords = MockRecordsHelper.mockRecords()
    
    func fetchRecords(filter: FilterItemModel) async -> [RecordModel] {
        return MockRecordsHelper.applyFilter(to: mockRecords, by: filter)
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
