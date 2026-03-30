//
//  RecordCell.swift
//  CachiFriend
//
//  Created by Samuel Chavez on 29/03/26.
//

import SwiftUI

struct RecordCellView: View {

    let viewModel: RecordCellViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(alignment: .center, spacing: 8) {
                ZStack {
                    Circle().fill(self.iconBackground)
                    IconImage(self.icon, color: Color.white)
                }
                .frame(width: 32, height: 32)
                VStack(alignment: .leading, spacing: 4) {
                    Text(self.viewModel.title)
                        .foregroundStyle(Color.dark)
                    Text(self.viewModel.date)
                        .foregroundStyle(Color.tertiary)
                }
                Spacer()
                Text(self.viewModel.amount)
                    .foregroundStyle(Color.dark)
            }.padding(.horizontal)
            Divider()
        }
    }

    var icon: CustomIcon {
        self.viewModel.type == .income ? .arrowUp : .arrowDown
    }

    var iconBackground: Color {
        self.viewModel.type == .income ? .primary : .secondary
    }
}

#Preview {
    let income = RecordModel(id: "1", title: "Primera quincena de enero", date: Date(), type: .income, amount: 10.8778)
    let outcome = RecordModel(id: "2", title: "Gasto no 1", date: Date(), type: .outcome, amount: 100)
    let outcome1 = RecordModel(id: "3", title: "Gasto no 2", date: Date(), type: .outcome, amount: 10000)
    let outcome2 = RecordModel(id: "4", title: "Gasto no 3", date: Date(), type: .outcome, amount: 100500)
    let outcome3 = RecordModel(id: "5", title: "Gasto no 4", date: Date(), type: .outcome, amount: 1000000)
    let outcome4 = RecordModel(id: "6", title: "Gasto no 4", date: Date(), type: .outcome, amount: 1000000000)
    Group {
        RecordCellView(viewModel: RecordCellViewModel(record: income))
        RecordCellView(viewModel: RecordCellViewModel(record: outcome))
        RecordCellView(viewModel: RecordCellViewModel(record: outcome1))
        RecordCellView(viewModel: RecordCellViewModel(record: outcome2))
        RecordCellView(viewModel: RecordCellViewModel(record: outcome3))
        RecordCellView(viewModel: RecordCellViewModel(record: outcome4))
    }.padding()
}
