//
//  VitalSignQuickView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2024-01-15.
//

import SwiftUI

struct VitalSignQuickView: View {
    var patient: Patient
    
    var body: some View {
        VStack(alignment: .leading) {
            
            HStack(alignment: .top) {
                
                Label {
                    Text("\(patient.heartRate.last?.value ?? 0, format: .number)")
                } icon: {
                    Image(systemName: "heart.fill")
                        .foregroundStyle(.red)
                }
                
                Label {
                    VStack(alignment: .leading) {
                        Text("\(patient.bloodOxygen.last?.value ?? 0, format: .number)") // Text("\()")
                        Text("\(patient.respiratoryRate.last?.value ?? 0, format: .number)")
                    }
                } icon: {
                    Image(systemName: "lungs.fill")
                        .foregroundStyle(.mint)
                }
                
                Label {
                    Text("\(patient.bloodPressureSystolic.last?.value ?? 0, format: .number)/\(patient.bloodPressureDiastolic.last?.value ?? 0, format: .number)")
                } icon: {
                    Image(systemName: "stethoscope")
                        .foregroundStyle(.red)
                }
            }
            
            HStack(alignment: .top) {
                
                VStack(alignment: .leading) {
                    Label {
                        Text("\(patient.bodyTemperature.last?.value ?? 0, format: .number)")
                    } icon: {
                        Image(systemName: "medical.thermometer.fill")
                            .foregroundStyle(.brown)
                    }
                    
                    Label {
                        Text("\(patient.breathAlcoholLevel.last?.value ?? 0, format: .number)")
                    } icon: {
                        Image(systemName: "wind")
                            .foregroundStyle(.blue)
                    }
                }
                
                Label {
                    Text("\(patient.consciousness.last?.value ?? 0, format: .number)")
                } icon: {
                    patient.consciousness.last?.value ?? 0 == 14.9 ?
                    Image(systemName: "zzz")
                        .foregroundStyle(.purple) :
                    Image(systemName: "brain")
                        .foregroundStyle(.pink)
                }
            }
        }
        .font(.caption2)
    }
}

#Preview {
    ModelPreview { patient in
        VitalSignQuickView(patient: patient)
    }
}
