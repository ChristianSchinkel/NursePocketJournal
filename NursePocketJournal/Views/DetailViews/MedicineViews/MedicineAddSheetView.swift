////
////  MedicineAddSheetView.swift
////  CareNote
////
////  Created by Christian Schinkel on 2024-01-11.
////
//
//import SwiftUI
//
//struct MedicineAddSheetView: View {
//    @Environment(\.modelContext) private var modelContext
//    @Environment(\.dismiss) private var dismiss
//    
//    @Bindable var patient: Patient
//    
//    @State private var date: Date = Date.now
//    @State private var name: String = ""
//    @State private var activeSubstance: String = ""
//    @State private var form: Care.Medicine.Form = .tablet
//    @State private var strengthValue: Double = 0.0
//    
//    @State private var numberFormatter: NumberFormatter = {
//        var nf = NumberFormatter()
//        nf.numberStyle = .decimal
//        return nf
//    }()
//    
//    @State private var strengthUnit: Care.Medicine.Unit = .milliGram
//    @State private var amount: Double = 0.0
//    @State private var actCode: String = ""
//    
//    fileprivate let headline: String = "Add Medicine"
//    
//    var body: some View {
//        NavigationStack {
//            Form {
//                DatePicker(selection: $date, label: { Text("Date")})
//                TextField("Name", text: $name)
//                    .keyboardType(.default)
//                HStack(alignment: .center) {
//                    TextField("Active substance", text: $activeSubstance)
//                        .keyboardType(.default)
//                    Spacer()
//                    Picker("Form", selection: $form) {
//                        ForEach(Care.Medicine.Form.allCases) { form in
//                            Text(form.name).tag(form)
//                        }
//                    }
//                    .labelsHidden()
//                }
//                
//                HStack(alignment: .center) {
//                    Text("Strength:")
//                    TextField("Strength", value: $strengthValue, formatter: numberFormatter)
//                        .keyboardType(.decimalPad)
//                    
//                    Picker("Unit", selection: $strengthUnit) {
//                        ForEach(Care.Medicine.Unit.allCases) { unit in
//                            Text(unit.rawValue).tag(unit.rawValue)
//                        }
//                    }
//                    .labelsHidden()
//                }
//                
//                HStack(alignment: .center) {
//                    Text("Amount:")
//                    TextField("Amount", value: $amount, formatter: numberFormatter)
//                        .keyboardType(.decimalPad)
//                    Text("st/ml/IU")
//                }
//            }
//            .navigationTitle(headline)
//            .navigationBarTitleDisplayMode(.inline)
//            // MARK: - Toolbar
//            .toolbar {
//                ToolbarItem(placement: .cancellationAction) {
//                    Button("Cancel", role: .cancel) {
//                        dismiss() // "@Environment(\.dismiss) private var dismiss" should be declared on top of struct.
//                    }
//                }
//                
////                ToolbarItem(placement: .principal) {
////                    Text(headline) // ' fileprivate let headline: String = "Text" ' should be declared on top of struct.
////                }
//                
//                ToolbarItem(placement: .topBarTrailing) {
//                    Button("Save", role: .cancel) {
//                        addMedicine()
//                        dismiss()
//                    }
//                }
//            }
//        }
//    }
//    // MARK: - Functions for this View:
//    private func addMedicine() {
//        withAnimation {
//            let newMedicine = Medicine(name: name, activeSubstance: activeSubstance, form: form, strengthValue: strengthValue, strengthValueUnit: strengthUnit, amount: amount, actCode: actCode)
//            patient.medicines.append(newMedicine)
//            patient.journals.append(Journal(date: date, isConfirmed: false, isDocumentedOfficially: false, isLocked: false, text: "Patienten erhåller \(newMedicine)."))
//        }
//    }
//}
//
//#Preview {
//    MedicineAddSheetView(patient: Patient.makeExample())
//        .modelContainer(PersistenceDataController.previewModelContainer)
//}
