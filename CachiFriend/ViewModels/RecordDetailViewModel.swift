//
//  RecordDetailViewModel.swift
//  CachiFriend
//
//  Created by Samuel Chavez on 29/03/26.
//

import Foundation
import Combine

enum RecordDetaiSheet: Identifiable {
    var id: String { String(describing: self) }
    case updateRecord(_ record: RecordModel)
}

class RecordDetailViewModel: ObservableObject {

    @Published var sheet: RecordDetaiSheet?
    @Published var loading = false
    @Published var showDeleteAlert = false

    let record: RecordModel
    
    let dataBaseService: DataBasesServiceProtocol

    init(_ dataBaseService: DataBasesServiceProtocol, record: RecordModel) {
        self.dataBaseService = dataBaseService
        self.record = record
    }

    func updateRecord() {
        self.sheet = .updateRecord(self.record)
    }

    func deleteRecord(completion: @escaping () -> Void) {
        self.loading = true

        Task {
            let deleted = await self.dataBaseService.deleteRecord(self.record)
            if deleted {
                self.loading = false
                completion()
            } else {
                print("error deleting record")
            }
            
        }
    }

    func showDeleteRecordAlert() {
        self.showDeleteAlert = true
    }
}
