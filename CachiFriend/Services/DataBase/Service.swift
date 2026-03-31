//
//  Service.swift
//  CachiFriend
//
//  Created by Samuel Chavez on 30/03/26.
//

import Foundation
import SwiftData

class SDDataBaseService: DataBasesServiceProtocol {
    
    private let container: ModelContainer
    private let context: ModelContext
    
    init() {
        self.container = try! ModelContainer(
            for: SDRecord.self,
            configurations: ModelConfiguration(isStoredInMemoryOnly: false)
        )
        self.context = ModelContext(container)
        
    }
    
    func fetchRecords(filter: FilterItemModel) async -> [RecordModel] {
        let calendar = Calendar.current
        let now = Date()
        
        let predicate: Predicate<SDRecord>
        
        switch filter {
        case .today:
            let startDay = calendar.startOfDay(for: now)
            let endDay = calendar.date(byAdding: .day, value: 1, to: startDay)!
            
            predicate = #Predicate<SDRecord> { register in
                register.date >= startDay && register.date < endDay
            }
            
        case .week:
            let startWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: now))!
            let endWeek = calendar.date(byAdding: .day, value: 7, to: startWeek)!
            
            predicate = #Predicate<SDRecord> { register in
                register.date >= startWeek && register.date < endWeek
            }
            
        case .month:
            let startMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: now))!
            let endMonth = calendar.date(byAdding: .month, value: 1, to: startMonth)!
            
            predicate = #Predicate<SDRecord> { register in
                register.date >= startMonth && register.date < endMonth
            }
            
        case .year:
            let yearAgo = calendar.date(byAdding: .year, value: -1, to: now)!
            
            predicate = #Predicate<SDRecord> { register in
                register.date >= yearAgo && register.date < now
            }
        }
        
        let descriptor = FetchDescriptor<SDRecord>(predicate: predicate)
        
        do {
            let sdRecords = try context.fetch(descriptor)
            
            return sdRecords.map {
                $0.toRecord()
            }
        } catch {
            return []
        }
        
        
    }
    
    func saveRecord(_ record: RecordModel) async -> Bool {
        let record = SDRecord(
            id: record.id,
            title: record.title,
            date: record.date,
            type: record.type.rawValue,
            amount: record.amount,
            
        )
        
        do {
            context.insert(record)
            try context.save()
            return true
        } catch {
            return false
        }
    }
    
    func updateRecord(_ record: RecordModel) async -> Bool {
        let id = record.id
        let predicate = #Predicate<SDRecord> { $0.recordId == id}
        let descriptor = FetchDescriptor<SDRecord>(predicate: predicate)
        
        do {
            guard let getRecord = try context.fetch(descriptor).first else {
                return false
            }
            getRecord.title = record.title
            getRecord.amount = record.amount
            
            try context.save()
            
            return true
        } catch {
            return false
        }
    }
    
    func deleteRecord(_ record: RecordModel) async -> Bool {
        let id = record.id
        let predicate = #Predicate<SDRecord> { $0.recordId == id}
        let descriptor = FetchDescriptor<SDRecord>(predicate: predicate)
        
        do {
            guard let getRecord = try context.fetch(descriptor).first else {
                return false
            }
            
            context.delete(getRecord)
            try context.save()
            return true
        } catch {
            return false
        }
    }
    
    func getTotals() async -> (income: Double, outcome: Double) {
        do {
            let incomePredicate = #Predicate<SDRecord> { $0.type == "INCOME"}
            let outcomePredicate = #Predicate<SDRecord> { $0.type == "OUTCOME"}
            
            let incomeDescriptor = FetchDescriptor<SDRecord>(predicate: incomePredicate)
            let outcomeDescriptor = FetchDescriptor<SDRecord>(predicate: outcomePredicate)
            
            let incomeRecords = try context.fetch(incomeDescriptor)
            let outcomeRecords = try context.fetch(outcomeDescriptor)
            
            let income = incomeRecords.reduce(0.0) { $0 + $1.amount }
            let outcome = outcomeRecords.reduce(0.0) { $0 + $1.amount }
            
            return (income: income, outcome: outcome)
            
            
        } catch {
            return (income: 0.00, outcome: 0.00)
        }
    }
    
    
}
