////
////  MedicineRowView.swift
////  CareNote
////
////  Created by Christian Schinkel on 2024-01-11.
////
//
//import SwiftUI
//
//struct MedicineListRowView: View {
//    @Environment(\.modelContext) private var modelContext
//    var medicine: Medicine
//    
//    var body: some View {
//        VStack(alignment: .leading) {
//            Text(medicine.administrationDate, format: .dateTime)
//                .foregroundStyle(.red)
//            Text(medicine.name)
//                .font(.headline)
//            Text(medicine.activeSubstance)
//                .font(.subheadline)
//                .foregroundStyle(.secondary)
//            HStack(alignment: .center) {
//                Text(medicine.form.name)
//                Text(medicine.strengthValue, format: .number)
//                Text(medicine.strengthValueUnit.rawValue)
//                Text("x")
//                Text(medicine.amount, format: .number)
//                Text("=")
//                Text("\(medicine.strengthValue * medicine.amount, format: .number) \(medicine.strengthValueUnit.rawValue)")
//            }
//            .font(.caption)
//            .bold()
//        }
//    }
//}
//
//#Preview {
//    MedicineListRowView(medicine: Medicine.makeExample())
//        .modelContainer(PersistenceDataController.previewModelContainer)
//}
