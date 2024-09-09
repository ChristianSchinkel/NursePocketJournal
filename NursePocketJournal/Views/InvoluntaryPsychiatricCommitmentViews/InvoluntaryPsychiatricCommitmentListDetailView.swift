//
//  InvoluntaryPsychiatricCommitmentListDetailView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2024-01-13.
//

import SwiftUI

struct InvoluntaryPsychiatricCommitmentListDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @Bindable var commitment: InvoluntaryPsychiatricCommitment
    
    @State private var date = Date.now
    @State private var isFixedOnAllPoints: Bool = false
    @State private var isFixedLeftArm: Bool = false
    @State private var isFixedLeftLeg: Bool = false
    @State private var isFixedRightArm: Bool = false
    @State private var isFixedRightLeg: Bool = false
    @State private var isFixedWaist: Bool = false
    
    fileprivate let headline: String = "Commitment"
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Toggle(isOn: $isFixedOnAllPoints) {
                        Label {
                            Text("Fixed on 5 points")
                        } icon: {
                            lockIsClosed(commitment.isFixed)
                        }
                    }
                    .onChange(of: commitment.isFixed) { oldValue, newValue in
                        isFixedOnAllPoints == false ? lockAllRestraints() : UnLockAllRestraints() // action. . .
                    }
                    .onAppear(perform: changeToggle)
                    
                    DatePicker(selection: $commitment.date, label: { Text("Date") })
                    
                }
                
                Section {
                    HStack {
                        Button {
                            commitment.isFixedRightArm.toggle()
                            checkForClosedLocks(commitment.isFixedLeftArm, commitment.isFixedLeftLeg, commitment.isFixedWaist, commitment.isFixedRightLeg, commitment.isFixedRightArm)
                        } label: {
                            lockIsClosed(commitment.isFixedRightArm)
                        }
                        .buttonStyle(.borderedProminent)
                        
                        Spacer()
                        
                        Button {
                            commitment.isFixedLeftArm.toggle()
                            checkForClosedLocks(commitment.isFixedLeftArm, commitment.isFixedLeftLeg, commitment.isFixedWaist, commitment.isFixedRightLeg, commitment.isFixedRightArm)
                        } label: {
                            lockIsClosed(commitment.isFixedLeftArm)
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    
                    ZStack {
                        Image(systemName: "figure.arms.open")
                            .resizable()
                            .frame(idealWidth: 400, maxWidth: 400, minHeight: 400, idealHeight: 400, maxHeight: 400, alignment: .center)
                        
                        Button {
                            commitment.isFixedWaist.toggle()
                            checkForClosedLocks(commitment.isFixedLeftArm, commitment.isFixedLeftLeg, commitment.isFixedWaist, commitment.isFixedRightLeg, commitment.isFixedRightArm)
                        } label: {
                            lockIsClosed(commitment.isFixedWaist)
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    
                    HStack {
                        Button {
                            commitment.isFixedRightLeg.toggle()
                            checkForClosedLocks(commitment.isFixedLeftArm, commitment.isFixedLeftLeg, commitment.isFixedWaist, commitment.isFixedRightLeg, commitment.isFixedRightArm)
                        } label: {
                            lockIsClosed(commitment.isFixedRightLeg)
                        }
                        .buttonStyle(.borderedProminent)
                        
                        Spacer()
                        
                        Button {
                            commitment.isFixedLeftLeg.toggle()
                            checkForClosedLocks(commitment.isFixedLeftArm, commitment.isFixedLeftLeg, commitment.isFixedWaist, commitment.isFixedRightLeg, commitment.isFixedRightArm)
                        } label: {
                            lockIsClosed(commitment.isFixedLeftLeg)
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
            }
            .navigationTitle(headline)
            .navigationBarTitleDisplayMode(.inline)
            // MARK: - Toolbar
            .toolbar {
//                ToolbarItem(placement: .principal) {
//                    Text(headline) // ' fileprivate let headline: String = "Text" ' should be declared on top of struct.
//                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save", role: .cancel) {
                        //                        addRestraint() // TODO: 'action' = cal a function.
                        dismiss()
                    }
                }
            }
        }
    }
    // MARK: - Functions for this View:
    func changeToggle() {
        isFixedOnAllPoints = commitment.isFixed
    }
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
}

#Preview {
    InvoluntaryPsychiatricCommitmentListDetailView(commitment: InvoluntaryPsychiatricCommitment.makeExample())
        .modelContainer(PersistenceDataController.previewModelContainer)
}
