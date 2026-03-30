//
//  HomeViewModel.swift
//  CachiFriend
//
//  Created by Samuel Chavez on 29/03/26.
//

import Foundation
import Combine

enum HomeSheet: Identifiable {
    var id: Self { self }
    case newRecord
}

enum HomeNavigationRoute: Hashable {
    case recordDetail(_ record: RecordModel)
}

class HomeViewModel: ObservableObject {

    @Published var path = [HomeNavigationRoute]()
    @Published var sheet: HomeSheet?
    @Published var loading = false
    @Published var loadingTotals = false

    var activeFilter: FilterItemModel = .today
    var records: [RecordModel] = []
    var totalIncome: Double = 0
    var totalOutcome: Double = 0
    let filters: [FilterItemModel] = [.today, .week, .month, .year]
    // TODO: Replace By DB
    let mockRecords = MockRecordsHelper.mockRecords()

    var totalIncomeText: String {
        return "$\(self.totalIncome.toMoneyAmount())"
    }

    var totalOutcomeText: String {
        return "$\(self.totalOutcome.toMoneyAmount())"
    }

    func getInitialData() {
        self.getTotals()
        self.getRecords()
    }

    func getTotals() {
        // TODO: - to change to get data of DB
        self.loadingTotals = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.totalIncome = 10000000
            self.totalOutcome = 500000
            self.loadingTotals = false
        }
    }

    func getRecords() {
        // TODO: - to change to get data of DB
        self.loading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.records = MockRecordsHelper.applyFilter(to: self.mockRecords,
                                                            by: self.activeFilter)
            self.loading = false
        }
    }

    func filterSelected(_ filter: FilterItemModel) {
        self.activeFilter = filter
        self.getRecords()
    }

    func isFilterSelected(_ filter: FilterItemModel) -> Bool {
        self.activeFilter == filter
    }

    func reorganizeFilters() -> [FilterItemModel] {
        guard let index = filters.firstIndex(of: activeFilter),
              index != 0 else { return filters }
        var newFilters = filters
        let selectedFilter = newFilters.remove(at: index)
        newFilters.insert(selectedFilter, at: 0)
        return newFilters
    }

    func newRecord() {
        self.sheet = .newRecord
    }

    func goToDetail(_ record: RecordModel) {
        self.path.append(.recordDetail(record))
    }
}
