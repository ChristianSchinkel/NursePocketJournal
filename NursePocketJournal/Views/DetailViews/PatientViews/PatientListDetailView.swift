//
//  PatientListDetailView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2023-11-19.
//

import SwiftUI
import SwiftData

struct PatientListDetailView: View {
    @Environment(\.modelContext) private var modelContext
    @Bindable var patient: Patient
    @Query private var rooms: [Room]
    
    @State private var isShowingVitalparameterAddSheet: Bool = false
    @State private var isShowingUrineTestSubstanceAddSheet: Bool = false
    @State private var isShowingConfirmationDialog: Bool = false
    @State private var isShowingAlertChangeName: Bool = false
    @State private var selectedRoom: Int = 0 // MARK: Room
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(patient.name)
                Text(patient.familyName)
            }
            .font(.title)
            .padding()
            .onLongPressGesture {
                isShowingAlertChangeName.toggle()
            }
            .alert("Rename patients identity", isPresented: $isShowingAlertChangeName) {
                VStack(alignment: .leading) {
                    TextField("Name", text: $patient.name)
                    TextField("Family name", text: $patient.familyName)
                    TextField("Person- / reservnummer", text: $patient.swedishSocialSecurityNumber)
                }
            } message: {
                Text("Important you are going to change patients names and identities!")
            }

            
            Divider()
            Form {
                Text("\(patient.room?.name ?? "Not placed")")
                    .contextMenu {
                        RoomSelecterView(selectedRoom: $selectedRoom) // TODO: .OnAppear + .OnDisappear call to func
                            .onAppear {
                                selectedRoom = patient.room?.number ?? 0
                            }
                            .onDisappear(perform: uppdateRoom)
                    }
                NavigationLink(destination: JournalListView(patient: patient)) {
                    Label("Journaltext", systemImage: "note.text.badge.plus")
                }
                NavigationLink(destination: PreScriptionListView(patient: patient)) {
                    Label("Medicine", systemImage: "pills")
                }
                NavigationLink(destination: InvoluntaryPsychiatricCommitmentListView(patient: patient)) {
                    Label("Commitment", systemImage: "lock")
                }
                Button(action: toggleConfigDialog) {
                    Label("Medvetandegrad", systemImage: "brain")
                }
                .tint(.pink)
                .confirmationDialog("Select an option", isPresented: $isShowingConfirmationDialog, titleVisibility: .visible) {
                    Button(Care.AssessmentCollection.AssessmentPrimitiveConsciousness.Status.alert.rawValue.capitalized, systemImage: "person") {
                        addPatientStatus(with: .alert) // TODO: do it like here with te rest of all buttons down here.
                    }
                    
                    Button(Care.AssessmentCollection.AssessmentPrimitiveConsciousness.Status.sleep.rawValue.capitalized, systemImage: "person") {
                        addPatientStatus(with: .sleep) // TODO: do it like here with te rest of all buttons down here.
                    }
                    
                    Button(Care.AssessmentCollection.AssessmentPrimitiveConsciousness.Status.confusion.rawValue.capitalized, systemImage: "person") {
                        addPatientStatus(with: .confusion) // TODO: do it like here with te rest of all buttons down here.
                    }
                    
                    Button(Care.AssessmentCollection.AssessmentPrimitiveConsciousness.Status.voice.rawValue.capitalized, systemImage: "person") {
                        addPatientStatus(with: .voice) // TODO: do it like here with te rest of all buttons down here.
                    }
                    
                    Button(Care.AssessmentCollection.AssessmentPrimitiveConsciousness.Status.pain.rawValue.capitalized, systemImage: "person") {
                        addPatientStatus(with: .pain) // TODO: do it like here with te rest of all buttons down here.
                    }
                    
                    Button(Care.AssessmentCollection.AssessmentPrimitiveConsciousness.Status.unresponsive.rawValue.capitalized, systemImage: "person") {
                        addPatientStatus(with: .unresponsive) // TODO: do it like here with te rest of all buttons down here.
                    }
                    
                    Button(Care.AssessmentCollection.AssessmentPrimitiveConsciousness.Status.none.rawValue.capitalized, systemImage: "person") {
                        addPatientStatus(with: .none) // TODO: do it like here with te rest of all buttons down here.
                    }
                }
                
                Button(action: addUrineTestResult) {
                    Label("U-tox", systemImage: "toilet")
                        .tint(.yellow)
                }
                .sheet(isPresented: $isShowingUrineTestSubstanceAddSheet) {
                    UrineTestSubstanceAddSheetView(patient: patient)
                }
                
                
                Button(action: addRecord) {
                    Label("Vital parameter", systemImage: "pencil.and.list.clipboard")
                }
                .sheet(isPresented: $isShowingVitalparameterAddSheet) {
                    VitalparameterAddSheetView(patient: patient)
                }
                
            }
        }
        .navigationTitle("Mer om patienten")
    }
    
    // MARK: - Functions for this View:
    private func addUrineTestResult() {
        isShowingUrineTestSubstanceAddSheet.toggle()
    }
    private func addRecord() {
        withAnimation {
            isShowingVitalparameterAddSheet.toggle()
        }
    }
    private func toggleConfigDialog() {
        isShowingConfirmationDialog.toggle()
    }
    private func addPatientStatus(with status: Care.AssessmentCollection.AssessmentPrimitiveConsciousness.Status) {
        // MARK:  patient.consciousness[Consciousness]
        patient.consciousness.append(Consciousness(id: UUID(), date: Date.now, value: status.acvpu))
        // TODO: patient.journal[Journal]
        patient.journals.append(Journal(date: Date.now, isConfirmed: false, isDocumentedOfficially: false, isLocked: false, text: Journal.writeJournalText(status.acvpu)))
    }
    
    private func uppdateRoom() {
        patient.room = rooms[selectedRoom]
    }
}

#Preview {
    ModelPreview { patient in
        PatientListDetailView(patient: patient)
    }
}
