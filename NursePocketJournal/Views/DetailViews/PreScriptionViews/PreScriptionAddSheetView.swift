//
//  PreScriptionAddSheetView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2024-02-16.
//

import SwiftUI

struct PreScriptionAddSheetView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @Bindable var patient: Patient
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
    @State private var frequency: Care.Medicine.Frequency = .onSpecificDaysOfTheWeek
    /// Interval: dayly, other day, 3 days, 4 days, 99 days
    @State private var chosenInterval: Care.Medicine.ChosenInterval = .day // TODO: not implemented in UI.
    /// WeekDay
    @State private var chosenDays: [Care.Medicine.ChosenDay] = []
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
    @State private var endDate: Date = Date.TwoWeeksLater(from: Date.now)
    /// The reason why treatment ends.
    @State private var endDateReason: String = ""
    // MARK: - Local view's property.
    fileprivate let headline: String = "Add Prescription"
    
    var body: some View {
        NavigationStack {
            Form {
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
                    if frequency == .onSpecificDaysOfTheWeek { // FIXME:
                        // bubble selection
                        WeekDaySelectionView(chosenDays: $chosenDays)
                    }
                }
                
                Section("Instruction") {
                    Toggle("Should not be replaced", isOn: $shouldNotBeReplaced)
                    if shouldNotBeReplaced == true {
                        TextField("Reason, why should not be replaced", text: $shouldNotBeReplacedReason)
                    }
                    TextEditor(text: $instruction)
                        .frame(height: 50)
                    // TODO: should not be shown if frequency == .none
                    DatePicker("Start", selection: $startDate)
                    TextField("Reason for prescription", text: $reasonOfPrescribing)
                    
                    DatePicker("End", selection: $endDate)
                    TextField("Reason for ending", text: $endDateReason)
                }
                
                Section("Information") {
                    TextField("ACT-Code", text: $actCode)
                    Text("https://www.fass.se/LIF/atcregister?atcCode=\(actCode.uppercased())")
                }
            }
            .navigationTitle(headline)
            .navigationBarTitleDisplayMode(.inline)
            // MARK: - Toolbar
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        dismiss() // "@Environment(\.dismiss) private var dismiss" should be declared on top of struct.
                    }
                }
                
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save", role: .cancel) {
                        addPreScription()
                        dismiss()
                    }
                }
            }
        }
    }
    // MARK: - Functions for this View:
    /// Gets all the dates between two dates with a selected day of week.
    /// - Parameters:
    ///   - dayOfWeek: Selected days of  week
    ///   - start: start Date()
    ///   - end: end Date()
    /// - Returns: [Date]
    private func getWeekdaysBetweenDates(_ dayOfWeek: Int, from start: Date, to end: Date) -> [Date] {
        var weekDays: [Date] = []
        let calendar = Calendar.current
        var currentDate = start

        // Adjust the start date if it's not already a Tuesday
        while calendar.component(.weekday, from: currentDate) != dayOfWeek { // 3 represents Tuesday -> dayOfWeek.
            guard let nextDay = calendar.date(byAdding: .day, value: 1, to: currentDate) else { break }
            currentDate = nextDay
        }

        // Iterate through the dates between start and end date
        while currentDate <= end {
            if calendar.component(.weekday, from: currentDate) == dayOfWeek {
                weekDays.append(currentDate)
            }
            guard let nextWeek = calendar.date(byAdding: .weekOfYear, value: 1, to: currentDate) else { break }
            currentDate = nextWeek
        }

        return weekDays
    }

    /// Adds prescription to a patient
    private func addPreScription() {
        withAnimation {
            // Create newMedicine
            let newMedicine = Medicine(id: UUID(), name: name, activeSubstance: activeSubstance, form: form, strengthValue: strengthValue, strengthValueUnit: strengthUnit)
            // Create tempDate
            var tempDate = preScriptionDate
            var tempCounter = 0 // TODO: Remove later, used to track in debugging.
            // Create newPreScription TODO: Switch to set data when creating newPreScription.
            switch frequency {
            case .atRegularIntervals:
                switch chosenInterval {
                case .day:
                    let newPreScription = PreScription(preScriptionDate: preScriptionDate, medicine: newMedicine, amount: amount, amountUnit: amountUnit, mode: mode, frequency: frequency, asNeeded: asNeeded, startDate: startDate, shouldNotBeReplaced: shouldNotBeReplaced, endDate: endDate) // MARK: Works like "return" -> Code after Switch won't be executed! - But you can chain in case of a case
                    // Add PreScription to patient.preScriptions<Array>
                    patient.preScriptions.append(newPreScription)
                    // Create one medication per 24-hours for this PreScription.
                    while tempDate <= newPreScription.endDate {
                        print("\(tempCounter)") // TODO: Remove later, used to track in debugging.
                        print("tempDate: \(tempDate)_ _ _ \(newPreScription.endDate)") // TODO: Remove later, used to track in debugging.
                        // Create newMedication
                        let newMedication = Medication(date: tempDate, medicine: newMedicine, amount: amount, amountUnit: amountUnit, mode: mode, frequency: frequency, isConfirmed: false, isPlanned: true, isPrescripted: true)
                        // Add newMedication to PreScription.medications<Array>
                        patient.preScriptions.first?.medications.append(newMedication)
                        // Update tempDate
                        tempDate = Date.nextDay(from: tempDate)
                        tempCounter += 1 // TODO: Remove later, used to track in debugging.
                    }
                case .otherDay:
                    let newPreScription = PreScription(preScriptionDate: preScriptionDate, medicine: newMedicine, amount: amount, amountUnit: amountUnit, mode: mode, frequency: frequency, asNeeded: asNeeded, startDate: startDate, shouldNotBeReplaced: shouldNotBeReplaced, endDate: endDate) // MARK: Works like "return" -> Code after Switch won't be executed! - But you can chain in case of a case
                    // Add PreScription to patient.preScriptions<Array>
                    patient.preScriptions.append(newPreScription)
                    // Create one medication per 48-hours for this PreScription.
                    while tempDate <= newPreScription.endDate {
                        print("\(tempCounter)") // TODO: Remove later, used to track in debugging.
                        print("tempDate: \(tempDate)_ _ _ \(newPreScription.endDate)") // TODO: Remove later, used to track in debugging.
                        // Create newMedication
                        let newMedication = Medication(date: tempDate, medicine: newMedicine, amount: amount, amountUnit: amountUnit, mode: mode, frequency: frequency, isConfirmed: false, isPlanned: true, isPrescripted: true)
                        // Add newMedication to PreScription.medications<Array>
                        patient.preScriptions.first?.medications.append(newMedication)
                        // Update tempDate
                        for _ in 0...1 {
                            tempDate = Date.nextDay(from: tempDate)
                            tempCounter += 1 // TODO: Remove later, used to track in debugging.
                        }
                    }
                case .threeDays:
                    let newPreScription = PreScription(preScriptionDate: preScriptionDate, medicine: newMedicine, amount: amount, amountUnit: amountUnit, mode: mode, frequency: frequency, asNeeded: asNeeded, startDate: startDate, shouldNotBeReplaced: shouldNotBeReplaced, endDate: endDate) // MARK: Works like "return" -> Code after Switch won't be executed! - But you can chain in case of a case
                    // Add PreScription to patient.preScriptions<Array>
                    patient.preScriptions.append(newPreScription)
                    // Create one medication per 72-hours for this PreScription.
                    while tempDate <= newPreScription.endDate {
                        print("\(tempCounter)") // TODO: Remove later, used to track in debugging.
                        print("tempDate: \(tempDate)_ _ _ \(newPreScription.endDate)") // TODO: Remove later, used to track in debugging.
                        // Create newMedication
                        let newMedication = Medication(date: tempDate, medicine: newMedicine, amount: amount, amountUnit: amountUnit, mode: mode, frequency: frequency, isConfirmed: false, isPlanned: true, isPrescripted: true)
                        // Add newMedication to PreScription.medications<Array>
                        patient.preScriptions.first?.medications.append(newMedication)
                        // Update tempDate
                        for _ in 0...2 {
                            tempDate = Date.nextDay(from: tempDate)
                            tempCounter += 1 // TODO: Remove later, used to track in debugging.
                        }
                    }
                case .fourDays:
                    let newPreScription = PreScription(preScriptionDate: preScriptionDate, medicine: newMedicine, amount: amount, amountUnit: amountUnit, mode: mode, frequency: frequency, asNeeded: asNeeded, startDate: startDate, shouldNotBeReplaced: shouldNotBeReplaced, endDate: endDate) // MARK: Works like "return" -> Code after Switch won't be executed! - But you can chain in case of a case
                    // Add PreScription to patient.preScriptions<Array>
                    patient.preScriptions.append(newPreScription)
                    // Create one medication per 96-hours for this PreScription.
                    while tempDate <= newPreScription.endDate {
                        print("\(tempCounter)") // TODO: Remove later, used to track in debugging.
                        print("tempDate: \(tempDate)_ _ _ \(newPreScription.endDate)") // TODO: Remove later, used to track in debugging.
                        // Create newMedication
                        let newMedication = Medication(date: tempDate, medicine: newMedicine, amount: amount, amountUnit: amountUnit, mode: mode, frequency: frequency, isConfirmed: false, isPlanned: true, isPrescripted: true)
                        // Add newMedication to PreScription.medications<Array>
                        patient.preScriptions.first?.medications.append(newMedication)
                        // Update tempDate
                        for _ in 0...3 {
                            tempDate = Date.nextDay(from: tempDate)
                            tempCounter += 1 // TODO: Remove later, used to track in debugging.
                        }
                    }
                case .ninetyNineDays:
                    let newPreScription = PreScription(preScriptionDate: preScriptionDate, medicine: newMedicine, amount: amount, amountUnit: amountUnit, mode: mode, frequency: frequency, asNeeded: asNeeded, startDate: startDate, shouldNotBeReplaced: shouldNotBeReplaced, endDate: endDate) // MARK: Works like "return" -> Code after Switch won't be executed! - But you can chain in case of a case
                    // Add PreScription to patient.preScriptions<Array>
                    patient.preScriptions.append(newPreScription)
                    // Create one medication per 99-dayss for this PreScription.
                    while tempDate <= newPreScription.endDate {
                        print("\(tempCounter)") // TODO: Remove later, used to track in debugging.
                        print("tempDate: \(tempDate)_ _ _ \(newPreScription.endDate)") // TODO: Remove later, used to track in debugging.
                        // Create newMedication
                        let newMedication = Medication(date: tempDate, medicine: newMedicine, amount: amount, amountUnit: amountUnit, mode: mode, frequency: frequency, isConfirmed: false, isPlanned: true, isPrescripted: true)
                        // Add newMedication to PreScription.medications<Array>
                        patient.preScriptions.first?.medications.append(newMedication)
                        // Update tempDate
                        for _ in 0...98 {
                            tempDate = Date.nextDay(from: tempDate)
                            tempCounter += 1 // TODO: Remove later, used to track in debugging.
                        }
                    }
                }
                
            case .onSpecificDaysOfTheWeek:
                let newPreScription = PreScription(preScriptionDate: preScriptionDate, medicine: newMedicine, amount: amount, amountUnit: amountUnit, mode: mode, frequency: frequency, asNeeded: asNeeded, startDate: startDate, shouldNotBeReplaced: shouldNotBeReplaced, endDate: endDate)
                // Add PreScription to patient.preScriptions<Array>
                patient.preScriptions.append(newPreScription)
                /* SKRIV SEUDOCODE HERE */
                var days = [Date]()
                // MONDAYs
                // if checkmarked
                days.append(contentsOf: getWeekdaysBetweenDates(2, from: startDate, to: endDate))// in in period -> [Date]
                // TUESDAYs
                // if checkmarked
                days.append(contentsOf: getWeekdaysBetweenDates(3, from: startDate, to: endDate))// in in period -> [Date]
                // WEDNESDAYs
                // if checkmarked
                days.append(contentsOf: getWeekdaysBetweenDates(4, from: startDate, to: endDate))// in in period -> [Date]
                // THURSDAYs
                // if checkmarked
                days.append(contentsOf: getWeekdaysBetweenDates(5, from: startDate, to: endDate))// in in period -> [Date]
                // FRIDAYs
                // if checkmarked
                days.append(contentsOf: getWeekdaysBetweenDates(6, from: startDate, to: endDate))// in in period -> [Date]
                // SATURSDAYs
                // if checkmarked
                days.append(contentsOf: getWeekdaysBetweenDates(7, from: startDate, to: endDate))// in in period -> [Date]
                // SUNDAYs
                // if checkmarked
                days.append(contentsOf: getWeekdaysBetweenDates(1, from: startDate, to: endDate))// in in period -> [Date]
                
                /* Array<weekDay>
                    Check for dates in this period.
                    Add information to prescription
                 */
                
                // Create as many as needed medications
            case .asNeeded:
                /* SKRIV SEUDOCODE HERE */
                let newPreScription = PreScription(preScriptionDate: preScriptionDate, medicine: newMedicine, amount: amount, amountUnit: amountUnit, mode: mode, frequency: frequency, asNeeded: true, asNeededMaxDoseAmount: asNeededMaxDoseAmount, asNeededMaxDoseAmountUnit: asNeededMaxDoseAmountUnit, asNeededMaxDoseStrengthValue: asNeededMaxDoseStrengthValue, asNeededMaxDoseStrengthValueUnit: asNeededMaxDoseStrengthValueUnit, instruction: instruction, startDate: startDate, reasonOfPrescribing: reasonOfPrescribing, shouldNotBeReplaced: shouldNotBeReplaced, shouldNotBeReplacedReason: shouldNotBeReplacedReason, endDate: startDate.endOfDay, endDateReason: endDateReason)
                // Add PreScription to patient.preScriptions<Array>
                patient.preScriptions.append(newPreScription)
            case .none:
                /* SKRIV SEUDOCODE HERE */
                
                let newPreScription = PreScription(preScriptionDate: preScriptionDate, medicine: newMedicine, amount: amount, amountUnit: amountUnit, mode: mode, frequency: frequency, asNeeded: false, asNeededMaxDoseAmount: amount, asNeededMaxDoseAmountUnit: amountUnit, asNeededMaxDoseStrengthValue: strengthValue, asNeededMaxDoseStrengthValueUnit: strengthUnit, instruction: instruction, startDate: preScriptionDate, reasonOfPrescribing: reasonOfPrescribing, shouldNotBeReplaced: shouldNotBeReplaced, shouldNotBeReplacedReason: shouldNotBeReplacedReason, endDate: startDate.endOfDay, endDateReason: endDateReason)
                // Add PreScription to patient.preScriptions<Array>
                patient.preScriptions.append(newPreScription)
            }
            
            
            
            
            
            /* Remove hereafter, when ready*/
            let newPreScription = PreScription(preScriptionDate: preScriptionDate, medicine: newMedicine, amount: amount, amountUnit: amountUnit, mode: mode, frequency: frequency, asNeeded: asNeeded, startDate: startDate, shouldNotBeReplaced: shouldNotBeReplaced, endDate: endDate) // TODO: Remove this after implementing in cases.
            
            // Add PreScription to patient.preScriptions<Array>
            patient.preScriptions.append(newPreScription) // TODO: Remove this after implementing in cases.
            /* Switches the algorithim to create medications by newPreScriptions.frequency */
            switch newPreScription.frequency {
            case .atRegularIntervals: // FIXME: Works only with 24 intervall. Add more intervalls.
                // Create Medications as many as needed for this PreScription.
                while tempDate <= newPreScription.endDate {
                    print("\(tempCounter)") // TODO: Remove later, used to track in debugging.
                    print("tempDate: \(tempDate)_ _ _ \(newPreScription.endDate)") // TODO: Remove later, used to track in debugging.
                    // Create newMedication
                    let newMedication = Medication(date: tempDate, medicine: newMedicine, amount: amount, amountUnit: amountUnit, mode: mode, frequency: frequency, isConfirmed: false, isPlanned: true, isPrescripted: true)
                    // Add newMedication to PreScription.medications<Array>
                    patient.preScriptions.first?.medications.append(newMedication)
                    // Update tempDate
                    tempDate = Date.nextDay(from: tempDate)
                    tempCounter += 1 // TODO: Remove later, used to track in debugging.
                }
            case .onSpecificDaysOfTheWeek: // FIXME: Add option to choose days of a week.
                // TODO: Create Days of the week<Array>
                // TODO: Create dates of those days and add them to the prescriptons.array
                if newPreScription.asNeededMaxDoseAmount == 0 { // FIXME: PLACEHOLDER logic
                }
            case .asNeeded: // FIXME: Add options to set maxdose in prescriptions -> will be checked by administration.
                // TODO: Create Medications as many as needed for this PreScription.
                if newPreScription.asNeededMaxDoseAmount != 0 || newPreScription.asNeededMaxDoseStrengthValue != 0 {
                    // TODO: one for each day, if administrated check if there is option too att once more
                    // Create Medications as many as needed for this PreScription.
                    while tempDate <= newPreScription.endDate {
                        print("\(tempCounter)") // TODO: Remove later, used to track in debugging.
                        print("tempDate: \(tempDate)_ _ _ \(newPreScription.endDate)") // TODO: Remove later, used to track in debugging.
                        // Create newMedication
                        let newMedication = Medication(date: tempDate, medicine: newMedicine, amount: amount, amountUnit: amountUnit, mode: mode, frequency: frequency, isConfirmed: false, isPlanned: true, isPrescripted: true)
                        // Add newMedication to PreScription.medications<Array>
                        patient.preScriptions.first?.medications.append(newMedication)
                        // Update tempDate
                        tempDate = Date.nextDay(from: tempDate)
                        tempCounter += 1 // TODO: Remove later, used to track in debugging.
                    }
                }
            case .none: // MARK: Only once.
                let newMedication = Medication(date: tempDate, medicine: newMedicine, amount: amount, amountUnit: amountUnit, mode: mode, frequency: frequency, isConfirmed: false, isPlanned: false, isPrescripted: true)
                // Add newMedication to PreScription.medications<Array>
                patient.preScriptions.first?.medications.append(newMedication)
            }
        }
    }
}

#Preview {
    PreScriptionAddSheetView(patient: Patient.makeExample())
        .modelContainer(PersistenceDataController.previewModelContainer)
}
