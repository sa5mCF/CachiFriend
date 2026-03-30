//
//  Record.swift
//  CachiFriend
//
//  Created by Samuel Chavez on 29/03/26.
//

import Foundation

enum RcordType: String, Identifiable {
    var id: String { rawValue }
    case income = "INCOME"
    case outcome = "OUTCOME"

    var label: String {
        switch self {
        case .income: return "Nuevo ingreso"
        case .outcome: return "Nuevo gasto"
        }
    }
}

struct RecordModel: Identifiable, Hashable {
    let id: String
    let title: String
    let date: Date
    let type: RcordType
    let amount: Double
}
