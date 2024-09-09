//
//  PatientMedicalQuickView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2023-12-21.
//

import SwiftUI

struct PatientMedicalQuickView: View {
    var patient: Patient
    
    var body: some View {
        HStack(alignment: .top) {
            if UIDevice.current.userInterfaceIdiom == .pad { // If the app runs on an iPad this code is running.
                
                Label {
                    Text("66") // TODO: Change to realValueType stored in the patient.
                } icon: {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                }
                
                Label {
                    VStack(alignment: .leading) {
                        Text("98 %") // TODO: Change to realValueType stored in the patient.
                        Text("16 B/M") // TODO: Change to realValueType stored in the patient.
                    }
                } icon: {
                    Image(systemName: "lungs.fill")
                        .foregroundColor(.mint)
                }
                
                Label {
                    Text("80/120") // TODO: Change to realValueType stored in the patient.
                } icon: {
                    Image(systemName: "stethoscope")
                        .foregroundColor(.red)
                }
                
                VStack(alignment: .leading) {
                    Label {
                        Text("36.7°C") // TODO: Change to realValueType stored in the patient.
                    } icon: {
                        Image(systemName: "medical.thermometer.fill")
                            .foregroundColor(.brown)
                    }
                    
                    Label {
                        Text("1.20 ‰") // TODO: Change to realValueType stored in the patient.
                    } icon: {
                        Image(systemName: "wind")
                    }
                }
                
                Label {
                    Text("?") // TODO: Change to realValueType stored in the patient.
                } icon: {
                    Image(systemName: "brain")
                        .foregroundColor(.pink)
                }
                
            } else { // If the app runs on  other devices this code is running
                
                Label {
                    Text("66") // TODO: Change to realValueType stored in the patient.
                } icon: {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                }
                
                Label {
                    VStack(alignment: .leading) {
                        Text("98 %") // TODO: Change to realValueType stored in the patient.
                        Text("16 B/M") // TODO: Change to realValueType stored in the patient.
                    }
                } icon: {
                    Image(systemName: "lungs.fill")
                        .foregroundColor(.mint)
                }
                
                Label {
                    Text("80/120") // TODO: Change to realValueType stored in the patient.
                } icon: {
                    Image(systemName: "stethoscope")
                        .foregroundColor(.red)
                }
                
                VStack(alignment: .leading) {
                    Label {
                        Text("36.7°C") // TODO: Change to realValueType stored in the patient.
                    } icon: {
                        Image(systemName: "medical.thermometer.fill")
                            .foregroundColor(.brown)
                    }
                    
                    Label {
                        Text("1.20 ‰") // TODO: Change to realValueType stored in the patient.
                    } icon: {
                        Image(systemName: "wind")
                    }
                }
                
                Label {
                    Text("?") // TODO: Change to realValueType stored in the patient.
                } icon: {
                    Image(systemName: "brain")
                        .foregroundColor(.pink)
                }
            }
        }
        .font(.caption2)
    }
}

#Preview {
    ModelPreview { patient in
        PatientMedicalQuickView(patient: patient)
    }
}
