////
////  MedicineListDetailView.swift
////  CareNote
////
////  Created by Christian Schinkel on 2024-01-11.
////
//
//import SwiftUI
//
//struct MedicineListDetailView: View {
//    @Environment(\.modelContext) private var modelContext
//    @Environment(\.dismiss) private var dismiss
//    
//    @Bindable var medicine: Medicine
//    fileprivate let headline: String = "Medicine"
//    
//    // MARK: - local State properties
//    @State private var name: String = "" // Name of the medicine.*
//    @State private var form: Care.Medicine.Form = .tablet// Form of the medicine.*
//    
//    @State private var activeSubstance: String = "" // Name of the medicine's aktive substance.*
//    //    @Binding var medicineDoseAmount: Double // Amount of t ex tablets.*
//    
//    @State private var strength: Double = 0 // strength value.*
//    @State private var strengthUnit: Care.Medicine.Unit = .milliGram // value's unit.*
//    
//    @State private var amount: Double = 0
//    @State private var amountUnit: String = ""
//    
//    //    @State private var modeOfAdministration: Care.Medicine.ModeOfAdministration = .oral // How the medicine gives to the patient.
//    
//    var body: some View {
//        NavigationStack {
//            VStack {
//                Form {
//                    Section("Name, Form, & Dosage") {
//                        HStack {
//                            TextField("Name", text: $medicine.name)
//                            //                            Picker(selection: $modeOfAdministration, label: Text("Administration-mode")) {
//                            //                                ForEach(Care.Medicine.ModeOfAdministration.allCases) { mode in
//                            //                                    Text(mode.rawValue)
//                            //                                }
//                            //                            }
//                            //                            .labelsHidden()
//                        }
//                        
//                        HStack {
//                            TextField("Active substance", text: $medicine.activeSubstance)
//                            Picker(selection: $medicine.form, label: Text("Form")) {
//                                ForEach(Care.Medicine.Form.allCases) { form in
//                                    Text(form.name)
//                                }
//                            }
//                            .labelsHidden()
//                        }
//                        
//                        HStack {
//                            TextField("Strength", value: $medicine.strengthValue, format: .number)
//                                .keyboardType(.decimalPad)
//                            Picker(selection: $medicine.strengthValueUnit, label: Text("Unit")) {
//                                ForEach(Care.Medicine.Unit.allCases) { unit in
//                                    Text(unit.rawValue)
//                                }
//                            }
//                            .labelsHidden()
//                            
//                            
//                            Image(systemName: "multiply")
//                            
//                            TextField("Amount", value: $medicine.amount, format: .number)
//                                .keyboardType(.decimalPad)
//                            
//                            Image(systemName: "equal")
//                            
//                            Text("\(medicine.strengthValue * medicine.amount, format: .number) \(medicine.strengthValueUnit.rawValue)")
//                        }
//                    }
//                }
//            }
//            .navigationTitle(headline)
//            .navigationBarTitleDisplayMode(.inline)
//            // MARK: - Toolbar
//            .toolbar {
////                ToolbarItem(placement: .principal) {
////                    Text(headline) // ' fileprivate let headline: String = "Text" ' should be declared on top of struct.
////                }
//                
//                ToolbarItem(placement: .topBarTrailing) {
//                    Button("Save", role: .cancel) {
//                        // TODO: 'action' = cal a function.
//                        dismiss()
//                    }
//                }
//            }
//        }
//    }
//    // MARK: - Functions for this View:
//}
//
//#Preview {
//    MedicineListDetailView(medicine: Medicine.makeExample())
//        .modelContainer(PersistenceDataController.previewModelContainer)
//}
