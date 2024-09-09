//
//  UrineTestForDrugsAndSubstancesView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2023-12-21.
//

import SwiftUI

struct UrineTestForDrugsAndSubstancesView: View {
    @Binding var isUrineTestForDrugsAndSubstancesDone: Bool
    
    @Binding var isPositiveAmphetamine: Bool
    @Binding var isPositiveCocaine: Bool
    
    @Binding var isPositiveBenzodiazepine: Bool
    @Binding var isPositiveClonazepam: Bool
    
    @Binding var isPositiveCannabis: Bool
    @Binding var isPositiveSpice: Bool
    
    @Binding var isPositiveOpiates: Bool
    @Binding var isPositiveBuprenorphine: Bool
    @Binding var isPositiveMethadone: Bool
    
    @Binding var isPositiveTramadol: Bool
    @Binding var isPositiveOxycodone: Bool
    @Binding var isPositiveFentanyl: Bool
    
    var body: some View {
        VStack {
            Toggle("U-tox", isOn: $isUrineTestForDrugsAndSubstancesDone)
                .onChange(of: isUrineTestForDrugsAndSubstancesDone) { oldValue, newValue in
                    markTestAsTaken(newValue)
                    print("onChange(of: \(isUrineTestForDrugsAndSubstancesDone)) from OldValue: \(oldValue) to NewValue \(newValue).")
                }
        }
        if isUrineTestForDrugsAndSubstancesDone == true {
            VStack {
                Group {
                    Toggle("Amphetamine", isOn: $isPositiveAmphetamine)
                    Toggle("Cocaine", isOn: $isPositiveCocaine)
                }
                Group {
                    Toggle("Benzodiazepine", isOn: $isPositiveBenzodiazepine)
                    Toggle("Clonazepam", isOn: $isPositiveClonazepam)
                }
                
                Group {
                    Toggle("Cannabis", isOn: $isPositiveCannabis)
                    Toggle("Spice", isOn: $isPositiveSpice)
                }
                
                Group {
                    Toggle("Opiates", isOn: $isPositiveOpiates)
                    Toggle("Buprenorphine", isOn: $isPositiveBuprenorphine)
                    Toggle("Metadone", isOn: $isPositiveMethadone)
                }
                
                Group {
                    Toggle("Tramadol", isOn: $isPositiveTramadol)
                    Toggle("Oxycodone", isOn: $isPositiveOxycodone)
                    Toggle("Fentanyl", isOn: $isPositiveFentanyl)
                }
            }
        }
    }
    // MARK: - Functions for this View:
    /// If the test isn't taken, this function marks all test-results as false.
    private func markTestAsTaken(_ value: Bool) {
        if value == false {
            isPositiveAmphetamine = false
            isPositiveCocaine = false
            
            isPositiveBenzodiazepine = false
            isPositiveClonazepam = false
            
            isPositiveCannabis = false
            isPositiveSpice = false
            
            isPositiveOpiates = false
            isPositiveBuprenorphine = false
            isPositiveMethadone = false
            
            isPositiveTramadol = false
            isPositiveOxycodone = false
            isPositiveFentanyl = false
        }
    }
}

#Preview {
    struct Preview: View {
        @State private var isUrineTestForDrugsAndSubstancesDone: Bool = true
        
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
        
        var body: some View {
            UrineTestForDrugsAndSubstancesView(isUrineTestForDrugsAndSubstancesDone: $isUrineTestForDrugsAndSubstancesDone, isPositiveAmphetamine: $isPositiveAmphetamine, isPositiveCocaine: $isPositiveCocaine, isPositiveBenzodiazepine: $isPositiveBenzodiazepine, isPositiveClonazepam: $isPositiveClonazepam, isPositiveCannabis: $isPositiveCannabis, isPositiveSpice: $isPositiveSpice, isPositiveOpiates: $isPositiveOpiates, isPositiveBuprenorphine: $isPositiveBuprenorphine, isPositiveMethadone: $isPositiveMethadone, isPositiveTramadol: $isPositiveTramadol, isPositiveOxycodone: $isPositiveOxycodone, isPositiveFentanyl: $isPositiveFentanyl)
        }
    }
    
    return Preview()
}
