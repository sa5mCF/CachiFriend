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
    
    let databaseService: DataBasesServiceProtocol
    
    init(_ databaseService: DataBasesServiceProtocol) {
        self.databaseService = databaseService
    }

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
        self.loadingTotals = true
        Task {
            let totals = await self.databaseService.getTotals()
            self.totalIncome = totals.income
            self.totalOutcome = totals.outcome
            await MainActor.run {
                self.loadingTotals = false
            }
        }
    }

    func getRecords() {
        self.loading = true
        Task {
            self.records = await self.databaseService.fetchRecords(filter: self.activeFilter)
            await MainActor.run {
                self.loading = false
            }
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
