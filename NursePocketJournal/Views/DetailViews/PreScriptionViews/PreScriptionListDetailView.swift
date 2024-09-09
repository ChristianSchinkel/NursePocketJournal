//
//  PreScriptionListDetailView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2024-02-16.
//

import SwiftUI

struct PreScriptionListDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @Bindable var preScription: PreScription
    // MARK: - local State properties
    fileprivate let headline: String = "Prescription"
    // MARK: - Medicine
    @State private var preScriptionDate: Date = Date.now
    @State private var name: String = ""
    @State private var activeSubstance: String = ""
    @State private var form: Care.Medicine.Form = .tablet
    @State private var strengthValue: Double = 0.0
    
    @State private var numberFormatter: NumberFormatter = {
        var nf = NumberFormatter()
        nf.numberStyle = .decimal
        return nf
    }()
    
    @State private var strengthUnit: Care.Medicine.Unit = .milliGram
    @State private var actCode: String = ""
    // MARK: - Prescription
    /// The amount of medicine to administrate.
    @State private var amount: Double = 0.0
    /// The amount's unit to administrate; piece, volume, etc.
    @State private var amountUnit: Care.Medicine.AmountUnit = .pieces
    /// The Mode of administration - how to administrate the medicine.
    @State private var mode: Care.Medicine.ModeOfAdministration = .oral
    
    /// The frequency.
    @State private var frequency: Care.Medicine.Frequency = .atRegularIntervals
    /// If the this PreScription can be given as Needed.
    @State private var asNeeded: Bool = false
    /// The max amount to administrate per day.
    @State private var asNeededMaxDoseAmount: Double = 0.0
    /// The max amount's unit to administrate per day.
    @State private var asNeededMaxDoseAmountUnit: Care.Medicine.AmountUnit = .pieces
    /// The max strength to administrate.
    @State private var asNeededMaxDoseStrengthValue: Double = 0.0
    /// The max strength's unit to administrate
    @State private var asNeededMaxDoseStrengthValueUnit: Care.Medicine.Unit = .milliGram
    
    //    var asNeededMaxDosePerDayDate: Date
    
    /// An optional instruction to the patient och administrator.
    @State private var instruction: String = ""
    
    
    /// The start of treatment.
    @State private var startDate: Date = Date.now
    /// The reason why medicine is prescribed.
    @State private var reasonOfPrescribing: String = ""
    
    /// If the medicine should not be replaced by a generic medicine.
    @State private var shouldNotBeReplaced: Bool = false
    /// The reason why the medicine should not be replaced by a generic medicine.
    @State private var shouldNotBeReplacedReason: String = ""
    
    /// The end of treatment.
    @State private var endDate: Date = Date.now
    /// The reason why treatment ends.
    @State private var endDateReason: String = ""
    
    
    
    var body: some View {
        NavigationStack {
            Form {
//                Section("Example") {
//                    VStack(alignment: .leading) {
//                        HStack {
//                            Text(preScription.medicine.name)
//                            Text(preScription.medicine.strengthValue, format: .number)
//                            Text(preScription.medicine.strengthValueUnit.rawValue)
//                        }
//                        .font(.title3)
//                        .fontWeight(.bold)
//                        
//                        HStack {
//                            Text(preScription.medicine.form.rawValue)
//                            Text(preScription.mode.rawValue)
//                        }
//                        
//                        HStack {
//                            Text("x")
//                            
//                            Text(preScription.amount, format: .number)
//                            Text(preScription.amountUnit.rawValue)
//                            
//                            Text("=")
//                            
//                            Text(preScription.medicine.strengthValue * preScription.amount, format: .number)
//                            Text(preScription.medicine.strengthValueUnit.rawValue)
//                        }
//                    }
//                }
                
                Section("Medicine") { // MARK: Medicine
                    if frequency != .asNeeded {
                        DatePicker(selection: $preScriptionDate, label: { Text("Due date")})
                    }
                    TextField("Name", text: $name)
                        .keyboardType(.default)
                    HStack(alignment: .center) {
                        TextField("Active substance", text: $activeSubstance)
                            .keyboardType(.default)
                        Spacer()
                        Picker("Form", selection: $form) {
                            ForEach(Care.Medicine.Form.allCases) { form in
                                Text(form.name).tag(form)
                            }
                        }
                        .labelsHidden()
                    }
                    
                    HStack(alignment: .center) {
                        Text("Strength:")
                        TextField("Strength", value: $strengthValue, formatter: numberFormatter)
                            .keyboardType(.decimalPad)
                        
                        Picker("Unit", selection: $strengthUnit) {
                            ForEach(Care.Medicine.Unit.allCases) { unit in
                                Text(unit.rawValue).tag(unit.rawValue)
                            }
                        }
                        .labelsHidden()
                    }
                    
                    
                }
                .onAppear(perform: {
                    setUpDefaultDataForView()
                })
                
                Section ("Prescription") { // MARK: Prescription
                    HStack(alignment: .center) {
                        Text("Amount:")
                        TextField("Amount", value: $amount, formatter: numberFormatter)
                            .keyboardType(.decimalPad)
                        Picker("Amount", selection: $amountUnit) {
                            ForEach(Care.Medicine.AmountUnit.allCases) { unit in
                                Text(unit.rawValue).tag(unit.rawValue)
                            }
                        }
                        .labelsHidden()
                    }
                    
                    Picker("Mode", selection: $mode) {
                        ForEach(Care.Medicine.ModeOfAdministration.allCases) { mode in
                            Text(mode.rawValue).tag(mode.rawValue)
                        }
                    }
                    Picker(selection: $frequency, label: Text("Frequeny")) {
                        ForEach(Care.Medicine.Frequency.allCases) { frequency in
                            Text(frequency.rawValue) .tag(frequency.rawValue)
                        }
                    }
                    if frequency == .asNeeded {
                        Toggle("As needed", isOn: $asNeeded) // MARK: As needed-toggle
                        
                        HStack(alignment: .center) {
                            Text("Amount:")
                            TextField("Amount", value: $asNeededMaxDoseAmount, formatter: numberFormatter)
                                .keyboardType(.decimalPad)
                            
                            Picker("Amount", selection: $asNeededMaxDoseAmountUnit) {
                                ForEach(Care.Medicine.AmountUnit.allCases) { unit in
                                    Text(unit.rawValue).tag(unit.rawValue)
                                }
                            }
                            .labelsHidden()
                        }
                        HStack(alignment: .center) {
                            Text("Strength:")
                            TextField("As needed max dose strength", value: $asNeededMaxDoseStrengthValue, formatter: numberFormatter)
                            
                            Picker("Unit", selection: $strengthUnit) {
                                ForEach(Care.Medicine.Unit.allCases) { unit in
                                    Text(unit.rawValue).tag(unit.rawValue)
                                }
                            }
                            .labelsHidden()
                        }
                    }
                }
                
                Section("Instruction") {
                    Toggle("Should not be replaced", isOn: $shouldNotBeReplaced)
                    if shouldNotBeReplaced == true {
                        TextField("Reason, why should not be replaced", text: $shouldNotBeReplacedReason)
                    }
                    TextEditor(text: $instruction)
                        .frame(height: 50)
                    
                    DatePicker("Start", selection: $startDate)
                    TextField("Reason for prescription", text: $reasonOfPrescribing)
                    
                    DatePicker("End", selection: $endDate)
                    TextField("Reason for ending", text: $endDateReason)
                }
                
                Section("Information") {
                    TextField("ACT-Code", text: $actCode)
                    Text("https://www.fass.se/LIF/atcregister?atcCode=\(actCode.uppercased())")
                }
                // TODO: UI to change the current PreScription
            }
            // MARK: - Toolbar
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        dismiss() // "@Environment(\.dismiss) private var dismiss" should be declared on top of struct.
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    Text(headline) // ' fileprivate let headline: String = "Text" ' should be declared on top of struct.
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save", role: .cancel) {
                        // TODO: 'action' = cal a function.
                        dismiss()
                    }
                }
            }
        }
    }
    // MARK: - Functions for this View:
    fileprivate func setUpDefaultDataForView() {
        preScriptionDate = preScription.preScriptionDate
        name = preScription.medicine.name
        activeSubstance = preScription.medicine.activeSubstance
        form = preScription.medicine.form
        strengthValue = preScription.medicine.strengthValue
        strengthUnit = preScription.medicine.strengthValueUnit
        actCode = preScription.medicine.actCode
        amount = preScription.amount
        amountUnit = preScription.amountUnit
        mode = preScription.mode
        frequency = preScription.frequency
        asNeeded = preScription.asNeeded
        
        if asNeeded == true {
            asNeededMaxDoseAmount = preScription.asNeededMaxDoseAmount ?? 0
            
            asNeededMaxDoseAmountUnit = preScription.asNeededMaxDoseAmountUnit ?? Care.Medicine.AmountUnit.pieces
            
            asNeededMaxDoseStrengthValue = preScription.asNeededMaxDoseStrengthValue ?? 0
            
            asNeededMaxDoseStrengthValueUnit = preScription.asNeededMaxDoseStrengthValueUnit ?? Care.Medicine.Unit.milliGram
        }
        
        instruction = preScription.instruction ?? ""
        
        
        
        startDate = preScription.startDate
        
        reasonOfPrescribing = preScription.reasonOfPrescribing ?? ""
        
        
        shouldNotBeReplaced = preScription.shouldNotBeReplaced
        
        shouldNotBeReplacedReason = preScription.shouldNotBeReplacedReason ?? ""
        
        
        endDate = preScription.endDate
        
        endDateReason = preScription.endDateReason ?? ""
    }
}

#Preview {
    PreScriptionListDetailView(preScription: PreScription.makeExample())
        .modelContainer(PersistenceDataController.previewModelContainer)
}
