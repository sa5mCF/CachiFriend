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

    init(record: RecordModel) {
        self.record = record
    }

    func updateRecord() {
        self.sheet = .updateRecord(self.record)
    }

    func deleteRecord(completion: @escaping () -> Void) {
        self.loading = true
        // TODO: Eliminar el registro de la base de datos
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.loading = false
            completion()
        }
    }

    func showDeleteRecordAlert() {
        self.showDeleteAlert = true
    }
}
