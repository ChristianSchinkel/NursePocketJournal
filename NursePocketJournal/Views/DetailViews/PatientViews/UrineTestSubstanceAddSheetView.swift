//
//  UrineTestSubstanceAddSheetView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2024-01-14.
//

import SwiftUI

struct UrineTestSubstanceAddSheetView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @Bindable var patient: Patient
    @State private var date: Date = Date.now
    
    @State private var isUrineTestForDrugsAndSubstancesDone: Bool = false
    
    @State private var isPositiveAmphetamine: Bool = false
    @State private var isPositiveCocaine: Bool = false
    
    @State private var isPositiveBenzodiazepine: Bool = false
    @State private var isPositiveClonazepam: Bool = false
    
    @State private var isPositiveCannabis: Bool = false
    @State private var isPositiveSpice: Bool = false
    
    @State private var isPositiveOpiates: Bool = false
    @State private var isPositiveBuprenorphine: Bool = false
    @State private var isPositiveMethadone: Bool = false
    
    @State private var isPositiveTramadol: Bool = false
    @State private var isPositiveOxycodone: Bool = false
    @State private var isPositiveFentanyl: Bool = false
    
    fileprivate let headline: String = "Add U-tox"
    
    var body: some View {
        NavigationStack {
            Form {
                DatePicker("Date", selection: $date)
                
                UrineTestForDrugsAndSubstancesView(isUrineTestForDrugsAndSubstancesDone: $isUrineTestForDrugsAndSubstancesDone, isPositiveAmphetamine: $isPositiveAmphetamine, isPositiveCocaine: $isPositiveCocaine, isPositiveBenzodiazepine: $isPositiveBenzodiazepine, isPositiveClonazepam: $isPositiveClonazepam, isPositiveCannabis: $isPositiveCannabis, isPositiveSpice: $isPositiveSpice, isPositiveOpiates: $isPositiveOpiates, isPositiveBuprenorphine: $isPositiveBuprenorphine, isPositiveMethadone: $isPositiveMethadone, isPositiveTramadol: $isPositiveTramadol, isPositiveOxycodone: $isPositiveOxycodone, isPositiveFentanyl: $isPositiveFentanyl)
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
                        addTestResult(tested: isUrineTestForDrugsAndSubstancesDone, amp: isPositiveAmphetamine, coc: isPositiveCocaine, bzo: isPositiveBenzodiazepine, acl: isPositiveClonazepam, thc: isPositiveCannabis, spi: isPositiveSpice, mop: isPositiveOpiates, bup: isPositiveBuprenorphine, mtd: isPositiveMethadone, tml: isPositiveTramadol, oxy: isPositiveOxycodone, fty: isPositiveFentanyl)// TODO: 'action' = cal a function.
                        dismiss()
                    }
                }
            }
        }
    }
    // MARK: - Functions for this View:
    private func addTestResult(tested doneTestOnTwelveSubstances: Bool, amp amphetamine: Bool, coc cocaine: Bool, bzo benzodiazepine: Bool, acl clonazepam: Bool, thc cannabis: Bool, spi spice: Bool, mop opiates: Bool, bup buprenorphine: Bool, mtd methadone: Bool, tml tramadol: Bool, oxy oxycodone: Bool, fty fentanyl: Bool) {
        let uPrefix = "U-" // TODO: add result to patientenen array.
        
        if doneTestOnTwelveSubstances == true {
            
            if amphetamine == true {
                patient.urineTestSubstances.append(UrineTestSubstance(id: UUID(), name: "\(uPrefix)AMP", date: date, value: amphetamine))
            }
            if cocaine == true {
                patient.urineTestSubstances.append(UrineTestSubstance(id: UUID(), name: "\(uPrefix)COC", date: date, value: cocaine))
            }
            if  benzodiazepine == true {
                patient.urineTestSubstances.append(UrineTestSubstance(id: UUID(), name: "\(uPrefix)BZO", date: date, value: benzodiazepine))
            }
            if clonazepam == true {
                patient.urineTestSubstances.append(UrineTestSubstance(id: UUID(), name: "\(uPrefix)ACL", date: date, value: clonazepam))
            }
            if cannabis == true {
                patient.urineTestSubstances.append(UrineTestSubstance(id: UUID(), name: "\(uPrefix)THC", date: date, value: cannabis))
            }
            if  spice == true {
                patient.urineTestSubstances.append(UrineTestSubstance(id: UUID(), name: "\(uPrefix)Spice", date: date, value: spice))
            }
            if opiates == true {
                patient.urineTestSubstances.append(UrineTestSubstance(id: UUID(), name: "\(uPrefix)MOP", date: date, value: opiates))
            }
            if  buprenorphine == true {
                patient.urineTestSubstances.append(UrineTestSubstance(id: UUID(), name: "\(uPrefix)BUP", date: date, value: buprenorphine))
            }
            if  methadone == true {
                patient.urineTestSubstances.append(UrineTestSubstance(id: UUID(), name: "\(uPrefix)MTD", date: date, value: methadone))
            }
            if tramadol == true {
                patient.urineTestSubstances.append(UrineTestSubstance(id: UUID(), name: "\(uPrefix)TML", date: date, value: tramadol))
            }
            if oxycodone == true {
                patient.urineTestSubstances.append(UrineTestSubstance(id: UUID(), name: "\(uPrefix)OXY", date: date, value: oxycodone))
            }
            if fentanyl == true {
                patient.urineTestSubstances.append(UrineTestSubstance(id: UUID(), name: "\(uPrefix)FYL", date: date, value: fentanyl))
            }
            
        } else {
            if amphetamine == false {
                patient.urineTestSubstances.append(UrineTestSubstance(id: UUID(), name: "\(uPrefix)AMP", date: date, value: amphetamine))
            }
            if cocaine == true {
                patient.urineTestSubstances.append(UrineTestSubstance(id: UUID(), name: "\(uPrefix)COC", date: date, value: cocaine))
            }
            if  benzodiazepine == false {
                patient.urineTestSubstances.append(UrineTestSubstance(id: UUID(), name: "\(uPrefix)BZO", date: date, value: benzodiazepine))
            }
            if clonazepam == false {
                patient.urineTestSubstances.append(UrineTestSubstance(id: UUID(), name: "\(uPrefix)ACL", date: date, value: clonazepam))
            }
            if cannabis == false {
                patient.urineTestSubstances.append(UrineTestSubstance(id: UUID(), name: "\(uPrefix)THC", date: date, value: cannabis))
            }
            if  spice == false {
                patient.urineTestSubstances.append(UrineTestSubstance(id: UUID(), name: "\(uPrefix)Spice", date: date, value: spice))
            }
            if opiates == false {
                patient.urineTestSubstances.append(UrineTestSubstance(id: UUID(), name: "\(uPrefix)MOP", date: date, value: opiates))
            }
            if  buprenorphine == false {
                patient.urineTestSubstances.append(UrineTestSubstance(id: UUID(), name: "\(uPrefix)BUP", date: date, value: buprenorphine))
            }
            if  methadone == false {
                patient.urineTestSubstances.append(UrineTestSubstance(id: UUID(), name: "\(uPrefix)MTD", date: date, value: methadone))
            }
            if tramadol == false {
                patient.urineTestSubstances.append(UrineTestSubstance(id: UUID(), name: "\(uPrefix)TML", date: date, value: tramadol))
            }
            if oxycodone == false {
                patient.urineTestSubstances.append(UrineTestSubstance(id: UUID(), name: "\(uPrefix)OXY", date: date, value: oxycodone))
            }
            if fentanyl == false {
                patient.urineTestSubstances.append(UrineTestSubstance(id: UUID(), name: "\(uPrefix)FYL", date: date, value: fentanyl))
            }
        }
        
    }
}

#Preview {
    UrineTestSubstanceAddSheetView(patient: Patient.makeExample())
}
