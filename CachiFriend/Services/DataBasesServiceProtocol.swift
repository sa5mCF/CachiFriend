//
//  DataBasesServiceProtocol.swift
//  CachiFriend
//
//  Created by Samuel Chavez on 30/03/26.
//

import Foundation

protocol DataBasesServiceProtocol {
    func fetchRecords(filter: FilterItemModel) async -> [RecordModel]
    func saveRecord(_ record: RecordModel) async -> Bool
    func updateRecord(_ record: RecordModel) async -> Bool
    func deleteRecord(_ record: RecordModel) async -> Bool
    func getTotals() async -> (income: Double, outcome: Double)
}
