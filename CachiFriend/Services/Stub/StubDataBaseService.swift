//
//  Untitled.swift
//  CachiFriend
//
//  Created by Samuel Chavez on 08/05/26.
//

import Foundation

class StubDataBaseService: DataBasesServiceProtocol {
    func fetchRecords(filter: FilterItemModel) async -> [RecordModel] {
        return []
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
        return (0, 0)
    }
    
    
}
