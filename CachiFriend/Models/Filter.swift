//
//  Filter.swift
//  CachiFriend
//
//  Created by Samuel Chavez on 29/03/26.
//

enum FilterItemModel: Identifiable {
    var id: Self { self }
    case today
    case week
    case month
    case year

    var label: String {
        switch self {
        case .today: return "Hoy"
        case .week: return "Esta semana"
        case .month: return "Este mes"
        case .year: return "Último año"
        }
    }
}
