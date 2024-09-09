//
//  Medicine.swift
//  CareNote
//
//  Created by Christian Schinkel on 2023-12-22.
//

import Foundation


/// A medicine.
struct Medicine: Identifiable, Codable, Named, Exemplifiable {
    let id: UUID // A unique identifier that never changes.
    
    var name: String
    
    var activeSubstance: String
    
    var form: Care.Medicine.Form
    var strengthValue: Double
    var strengthValueUnit: Care.Medicine.Unit
    //    var strength: Measurement<UnitMass> // FIXME: doesn't work with Codble/@Model.
    // var amountValue: Double
    // var amountValueUnit: String
    
    
    var administrationDate: Date = Date.now // FIXME: remove this in a future version of CareNote. Administration vill be a separate class that holds a date and a medication.
    
    // MARK: Linked to ATC-register on FASS.se
    var linkToActRegister: String = "https://www.fass.se/LIF/atcregister?atcCode="
    
    var actCode: String = ""
    
    var linkToActOnFass: String {
        linkToActRegister + actCode
    }
//    init(name: String, activeSubstance: String, form: Care.Medicine.Form, strengthValue: Double, strengthValueUnit: Care.Medicine.Unit, amount: Double, actCode: String) {
//        self.name = name
//        self.activeSubstance = activeSubstance
//        self.form = form
//        self.strengthValue = strengthValue
//        self.strengthValueUnit = strengthValueUnit
//        self.amount = amount
//        self.actCode = actCode
//    }
    //    init(name: String, activeSubstance: String, form: Care.Medicine.Form, strength: Measurement<UnitMass>, amount: Double, actCode: String) {
    //        self.name = name
    //        self.activeSubstance = activeSubstance
    //        self.form = form
    //        self.strength = strength
    //        self.amount = amount
    //        self.actCode = actCode
    //    }
    // MARK: - functions goes here.
    static func makeExample() -> Medicine {
        Medicine(id: UUID(), name: "Stesolid", activeSubstance: "Diazepam", form: .tablet, strengthValue: 10.0, strengthValueUnit: .milliGram, actCode: "N05BA01")
    }
}
