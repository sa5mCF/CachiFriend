//
//  RecordCellViewModel.swift
//  CachiFriend
//
//  Created by Samuel Chavez on 29/03/26.
//

struct RecordCellViewModel {

    private let record: RecordModel

    init(record: RecordModel) {
        self.record = record
    }

    var title: String {
        record.title
    }

    var date: String {
        record.date.showText()
    }

    var amount: String {
        "$\(record.amount.toMoneyAmount())"
    }

    var type: RcordType {
        record.type
    }
}
