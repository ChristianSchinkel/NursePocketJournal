//
//  InvoluntaryPsychiatricCommitmentAddSheetView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2024-01-13.
//

import SwiftUI

struct InvoluntaryPsychiatricCommitmentAddSheetView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @Bindable var patient: Patient
    
    @State private var date = Date.now
    @State private var isFixedOnAllPoints: Bool = false
    @State private var isFixedLeftArm: Bool = false
    @State private var isFixedLeftLeg: Bool = false
    @State private var isFixedRightArm: Bool = false
    @State private var isFixedRightLeg: Bool = false
    @State private var isFixedWaist: Bool = false
    
    fileprivate let headline: String = "Add Commitment"
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Toggle(isOn: $isFixedOnAllPoints) {
                        Label {
                            Text("Fixed on 5 points")
                        } icon: {
                            lockIsClosed(isFixedOnAllPoints)
                        }
                    }
                    .onChange(of: isFixedOnAllPoints) { oldValue, newValue in
                        isFixedOnAllPoints == false ? lockAllRestraints() : UnLockAllRestraints() // action. . .
                    }
                    
                    DatePicker(selection: $date, label: { Text("Date") })
                    
                }
                
                Section {
                    HStack {
                        Button {
                            isFixedRightArm.toggle()
                            checkForClosedLocks(isFixedLeftArm, isFixedLeftLeg, isFixedWaist, isFixedRightLeg, isFixedRightArm)
                        } label: {
                            lockIsClosed(isFixedRightArm)
                        }
                        .buttonStyle(.borderedProminent)
                        
                        Spacer()
                        
                        Button {
                            isFixedLeftArm.toggle()
                            checkForClosedLocks(isFixedLeftArm, isFixedLeftLeg, isFixedWaist, isFixedRightLeg, isFixedRightArm)
                        } label: {
                            lockIsClosed(isFixedLeftArm)
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    
                    ZStack {
                        Image(systemName: "figure.arms.open")
                            .resizable()
                            .frame(idealWidth: 400, maxWidth: 400, minHeight: 400, idealHeight: 400, maxHeight: 400, alignment: .center)
                        
                        Button {
                            isFixedWaist.toggle()
                            checkForClosedLocks(isFixedLeftArm, isFixedLeftLeg, isFixedWaist, isFixedRightLeg, isFixedRightArm)
                        } label: {
                            lockIsClosed(isFixedWaist)
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    
                    HStack {
                        Button {
                            isFixedRightLeg.toggle()
                            checkForClosedLocks(isFixedLeftArm, isFixedLeftLeg, isFixedWaist, isFixedRightLeg, isFixedRightArm)
                        } label: {
                            lockIsClosed(isFixedRightLeg)
                        }
                        .buttonStyle(.borderedProminent)
                        
                        Spacer()
                        
                        Button {
                            isFixedLeftLeg.toggle()
                            checkForClosedLocks(isFixedLeftArm, isFixedLeftLeg, isFixedWaist, isFixedRightLeg, isFixedRightArm)
                        } label: {
                            lockIsClosed(isFixedLeftLeg)
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
            }
            .onAppear { // FIXME: Crashes the canvas (1)
                // MARK: Check for patients status data.
                if !patient.involuntaryPsychiatricCommitments.isEmpty {
                    isFixedLeftArm = patient.involuntaryPsychiatricCommitments.last?.isFixedLeftArm ?? false
                    isFixedLeftLeg = patient.involuntaryPsychiatricCommitments.last?.isFixedLeftLeg ?? false
                    isFixedWaist = patient.involuntaryPsychiatricCommitments.last?.isFixedWaist ?? false
                    isFixedRightArm = patient.involuntaryPsychiatricCommitments.last?.isFixedRightArm ?? false
                    isFixedRightLeg = patient.involuntaryPsychiatricCommitments.last?.isFixedRightLeg ?? false
                }
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
                        addRestraint() // TODO: 'action' = cal a function.
                        dismiss()
                    }
                }
            }
        }
    }
    // MARK: - Functions for this View:
    private func lockIsClosed(_ status: Bool) -> Image {
        if status == true {
            return Image(systemName: "lock")
        } else {
            return Image(systemName: "lock.open")
        }
    }
    private func checkForClosedLocks(_ leftArm: Bool, _ leftLeg: Bool, _ waist: Bool, _ rightLeg: Bool, _ rightArm: Bool) {
        // If all are closed -> close mainLocker
        if leftArm && leftLeg && waist && rightLeg && rightArm {
            isFixedOnAllPoints = true
        } else if leftArm == false && leftLeg == false && waist == false && rightLeg == false && rightArm == false {
            isFixedOnAllPoints = false // else no is closed -> open mainLocker
        }
    }
    private func lockAllRestraints() {
        guard isFixedOnAllPoints == false else {
            return print("All points of restrains are locked: \(isFixedOnAllPoints).")
        }
        isFixedLeftArm = false
        isFixedLeftLeg = false
        isFixedWaist = false
        isFixedRightLeg = false
        isFixedRightArm = false
    }
    
    private func UnLockAllRestraints() {
        guard isFixedOnAllPoints == true else {
            return print("All points of restrains are unlocked: \(isFixedOnAllPoints).")
        }
        isFixedLeftArm = true
        isFixedLeftLeg = true
        isFixedWaist = true
        isFixedRightLeg = true
        isFixedRightArm = true
    }
    private func addRestraint() {
        patient.involuntaryPsychiatricCommitments.append(InvoluntaryPsychiatricCommitment(type: .physicalRestraint, date: date, isFixedLeftArm: isFixedLeftArm, isFixedLeftLeg: isFixedLeftLeg, isFixedRightArm: isFixedRightArm, isFixedRightLeg: isFixedRightLeg, isFixedWaist: isFixedWaist))
    }
}


//#Preview { // FIXME: Crashes the canvas (2)
//    InvoluntaryPsychiatricCommitmentAddSheetView(patient: Patient.makeExample())
//        .modelContainer(PersistenceDataController.previewModelContainer)
//}
