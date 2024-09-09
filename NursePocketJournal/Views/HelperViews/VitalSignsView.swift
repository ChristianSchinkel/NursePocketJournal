//
//  VitalSignsView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2023-12-21.
//

import SwiftUI

struct VitalSignsView: View {
    @Binding var heartRate: String
    
    @Binding var systolic: String
    @Binding var diastolic: String
    
    @Binding var bodyTemperature: String
    
    @Binding var bloodAlcoholContent: String
    
    @Binding var bloodOxygenLevel: String
    @Binding var respiratoryRate: String
    
    @Binding var isNeededToObserveBloodOxygen: Bool
    @Binding var bloodOxygenGoal: String
    
    @Binding var bloodGlucose: String
    
    var body: some View {
        Section {
            TextField("BPM", text: $heartRate)
                .keyboardType(.decimalPad)
            TextField("systolic", text: $systolic)
                .keyboardType(.decimalPad)
            TextField("diastolic", text: $diastolic)
                .keyboardType(.decimalPad)
        } header: {
            Text("Circulation")
        }
        Section {
            TextField("Blood-oxygen level", text: $bloodOxygenLevel)
                .keyboardType(.decimalPad)
            TextField("Breaths per minute", text: $respiratoryRate)
                .keyboardType(.decimalPad)
            Toggle(isOn: $isNeededToObserveBloodOxygen) {
                Text("Saturations-OBS")
            }
            if isNeededToObserveBloodOxygen == true {
                withAnimation {
                    TextField("Blood-oxygen level", text: $bloodOxygenGoal)
                        .keyboardType(.decimalPad)
                }
            }
        } header: {
            Text("Airway & breathing")
        }
        Section {
            TextField("Bloodglucose", text: $bloodGlucose)
                .keyboardType(.decimalPad)
            TextField("Bodytemperature", text: $bodyTemperature)
                .keyboardType(.decimalPad)
            TextField("Blood Alcohol content", text: $bloodAlcoholContent)
                .keyboardType(.decimalPad)
        } header: {
            Text("Exposure")
        }
    }
}

#Preview {
    struct Preview: View {
        @State private var heartRate: String = "60"
        
        @State private  var systolic: String = "80"
        @State private  var diastolic: String = "120"
        
        @State private  var bodyTemperature: String = "37.1"
        
        @State private  var bloodAlcoholContent: String = "1.68"
        
        @State private  var bloodOxygenLevel: String = "98"
        @State private  var respiratoryRate: String = "16"
        
        @State private  var isNeededToObserveBloodOxygen: Bool = true
        @State private  var bloodOxygenGoal: String = "90"
        
        @State private  var bloodGlucose: String = "5.4"
        
        var body: some View {
            VitalSignsView(heartRate: $heartRate, systolic: $systolic, diastolic: $diastolic, bodyTemperature: $bodyTemperature, bloodAlcoholContent: $bloodAlcoholContent, bloodOxygenLevel: $bloodOxygenLevel, respiratoryRate: $respiratoryRate, isNeededToObserveBloodOxygen: $isNeededToObserveBloodOxygen, bloodOxygenGoal: $bloodOxygenGoal, bloodGlucose: $bloodGlucose)
        }
    }
    
    return Preview()
}
