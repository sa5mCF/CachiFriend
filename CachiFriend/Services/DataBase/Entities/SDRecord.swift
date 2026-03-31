//
//  SDRecord.swift
//  CachiFriend
//
//  Created by Samuel Chavez on 30/03/26.
//

import Foundation
import SwiftData

@Model
class SDRecord{
    var id: String
    var recordId: String
    var title: String
    var date: Date
    var type: String
    var amount: Double
    
    init(id: String, title: String, date: Date, type: String, amount: Double) {
        self.id = id
        self.recordId = id
        self.title = title
        self.date = date
        self.type = type
        self.amount = amount
    }
}

extension SDRecord: ToRecordProtocol {
    func toRecord() -> RecordModel {
        return RecordModel(id: id, title: title, date: date, type: RecordType(rawValue: type) ?? .income, amount: amount)
    }
    
}
