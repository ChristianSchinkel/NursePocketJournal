//
//  PatientMedicalPhysicalRestraintView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2023-12-22.
//

import SwiftUI

struct PatientMedicalPhysicalRestraintView: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var patient: Patient
    
    @State private var date = Date.now
    @State private var isFixedOnAllPoints: Bool = false
    @State private var isFixedLeftArm: Bool = false
    @State private var isFixedLeftLeg: Bool = false
    @State private var isFixedRightArm: Bool = false
    @State private var isFixedRightLeg: Bool = false
    @State private var isFixedWaist: Bool = false
    
    var body: some View {
        NavigationStack {
            Form {
                // MARK: Topic: fixed and date
                Section {
                    Toggle(isOn: $isFixedOnAllPoints) {
                        Label {
                            Text("Fixed on 5 points")
                        } icon: {
                            lockIsClosed(isFixedOnAllPoints)
                        }
                    }
                    .onChange(of: isFixedOnAllPoints) { oldValue, newValue in
                        isFixedOnAllPoints == false ? lockAllRestraints() : UnLockAllRestraints()
                    }
                    
                    DatePicker(selection: $date, label: { Text("Date") })
                    
                }
                // MARK: Patient pic
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
            //            .onAppear {
            //                // MARK: check for patients status data.
            //                if !patient.medicalPhysicalRestraintArray.isEmpty {
            //                    isFixedLeftArm = patient.medicalPhysicalRestraintArray.last?.isFixedLeftArm ?? false
            //                    isFixedLeftLeg = patient.medicalPhysicalRestraintArray.last?.isFixedLeftLeg ?? false
            //                    isFixedWaist = patient.medicalPhysicalRestraintArray.last?.isFixedWaist ?? false
            //                    isFixedRightArm = patient.medicalPhysicalRestraintArray.last?.isFixedRightArm ?? false
            //                    isFixedRightLeg = patient.medicalPhysicalRestraintArray.last?.isFixedRightLeg ?? false
            //                }
            //        }
            .navigationTitle("Physical Restraint")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        //                        addRestraint()
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
    // MARK:  Adds data to the patient
    //    private func addRestraint() {
    //        patient.addToMedicalPhysicalRestraint(MedicalPhysicalRestraint(date: date, isFixedLeftArm: isFixedLeftArm, isFixedLeftLeg: isFixedLeftLeg, isFixedRightArm: isFixedRightArm, isFixedRightLeg: isFixedRightLeg, isFixedWaist: isFixedWaist, context: viewContext))
    //        PersistenceController.shared.save()
    //    }
}

#Preview {
    ModelPreview { patient in
        PatientMedicalPhysicalRestraintView(patient: patient)
    }
}
