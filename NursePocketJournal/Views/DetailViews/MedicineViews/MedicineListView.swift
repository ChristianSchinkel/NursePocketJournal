////
////  MedicineListView.swift
////  CareNote
////
////  Created by Christian Schinkel on 2024-01-11.
////
//
//import SwiftUI
//
//struct MedicineListView: View {
//    @Environment(\.modelContext) private var modelContext
//    
//    @Bindable var patient: Patient
//    @State private var isShowingMedicineAddSheet: Bool = false
//    
//    var body: some View {
//        List {
//            ForEach(patient.medicines) { medicine in
//                NavigationLink {
//                    MedicineListDetailView(medicine: medicine)
//                } label: {
//                    MedicineListRowView(medicine: medicine)
//                }
//            }
//            .onDelete(perform: deleteMedicines)
//        }
//        .navigationTitle("Medicinelist")
//        .navigationBarTitleDisplayMode(.large)
//        // MARK: - Sheets
//        .sheet(isPresented: $isShowingMedicineAddSheet) {
//            MedicineAddSheetView(patient: patient)
//        }
//        // MARK: - Toolbar
//        .toolbar {
//            ToolbarItem(placement: .topBarTrailing) {
//                EditButton()
//            }
//            ToolbarItem {
//                Button(action: addMedicine) {
//                    Label("Add Medicine", systemImage: "plus")
//                }
//            }
//        }
//    }
//    // MARK: - Functions for this View:
//    private func addMedicine() {
//        isShowingMedicineAddSheet.toggle()
//    }
//    
//    private func deleteMedicines(offsets: IndexSet) {
//        withAnimation {
//            for index in offsets {
//                patient.medicines.remove(at: index)
//            }
//        }
//    }
//}
//
//#Preview {
//    ModelPreview { patient in
//        MedicineListView(patient: patient)
//    }
//}
