//
//  PatientListRowView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2023-11-16.
//

import SwiftUI

struct PatientListRowView: View {
    var patient: Patient
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(patient.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
                .font(.caption2)
                .foregroundStyle(.secondary)
            HStack {
                Text(patient.name)
                Text(patient.familyName)
            }
            .fontWeight(.semibold)
            
            Text("\(patient.swedishSocialSecurityNumber)")
                .font(.caption)
                .fontWeight(.thin)
                .foregroundStyle(.secondary)
            
            VitalSignQuickView(patient: patient)
        }
    }
}

#Preview {
    ModelPreview { patient in
        PatientListRowView(patient: patient)
    }
}
