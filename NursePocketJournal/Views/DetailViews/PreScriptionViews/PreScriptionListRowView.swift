//
//  PreScriptionListRowView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2024-02-16.
//

import SwiftUI

struct PreScriptionListRowView: View {
    @Environment(\.modelContext) private var modelContext
    var preScription: PreScription
    
    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Text(preScription.startDate, format: .dateTime)
                    .foregroundStyle(.red)
                Text(preScription.endDate, format: .dateTime)
                    .foregroundStyle(.red)
            }
            Text(preScription.medicine.name)
                .font(.headline)
            Text(preScription.medicine.activeSubstance)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            Text(preScription.medicine.form.name)
            
            Text(preScription.frequency.rawValue)
            
            
            HStack(alignment: .center) {
                Text(preScription.medicine.strengthValue, format: .number)
                Text(preScription.medicine.strengthValueUnit.rawValue)
                
                Text("x")
                
                Text(preScription.amount, format: .number)
                Text(preScription.amountUnit.rawValue)
                
                Text("=")
                
                Text("\(preScription.medicine.strengthValue * preScription.amount, format: .number) \(preScription.medicine.strengthValueUnit.rawValue)")
            }
            .font(.caption)
            .bold()
        }
    }
}

#Preview {
    PreScriptionListRowView(preScription: PreScription.makeExample())
        .modelContainer(PersistenceDataController.previewModelContainer)
}
