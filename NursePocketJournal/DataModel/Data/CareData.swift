//
//  CareData.swift
//  CareNote
//
//  Created by Christian Schinkel on 2022-09-18.
//

import Foundation
/// Care-struct declared in CareData.swift is a struct that has much information and is very central in the app using it.
struct Care {
    struct AssessmentCollection {
        /// Assessment for identifying and treatment of life-threatening situations in the right order.
        /// * **Airway**,
        /// * **Breathing,**
        /// * **Circulation,**
        /// * **Disability** and
        /// * **Exposure.**
        struct AssessmentABCDE { // TODO: AssessmentABCDE needs to be completed with the missing categories: airway, breathing, circulation, exposure. (link: https://www.vardhandboken.se/vard-och-behandling/akut-bedomning-och-skattning/bedomning-enligt-abcde/oversikt/)
            /// Part of assessment.
            enum Category: Codable {
                case airway, breathing, circulation, disability, exposure
            }
            /// Disability: Assessment value (0 - 4) for a patients neurological status.
            enum Disability: String, CaseIterable, Codable, Identifiable {
                case alert, // Alert; fully awake.
                confusion, // Confusion; new or worsening confusion.
                voice, // Voice; responds to summons.
                pain, // Pain; reacts to painful stimuli.
                unresponsive, // Unresponsive; does not react to painful stimuli.
                none // None; not chosen.
                
                var id: Self { self } // --> (id: \.self )
            }
        }
        /// Assessment is used to identify need of interaction with the a patient.
        struct AssessmentPrimitiveConsciousness {
            /// Status-value for Primitive-Consciousness-Assessment.
            /// According to ACVPU (Alert, Confusion, Voice, Pain, Unresponsible).
            enum Status: String, CaseIterable, Codable, Identifiable {
                case alert, // Alert; fully awake.
                sleep, // Sleep; patienten sleeps.
                confusion, // Confusion; new or worsening confusion.
                voice, // Voice; responds to summons.
                pain, // Pain; reacts to painful stimuli.
                unresponsive, // Unresponsive; does not react to painful stimuli.
                none // None; not chosen.
                
                var id: Self { self } // --> (id: \.self )
                /// **ACVPU - Alert/Confusion/Voice/Pain/Unresponsive**
                /// 
                /// *En enklare skala än GCS och RLS är ACVPU, som är lämplig att använda initialt och när patientens tillstånd är mycket kritiskt.*
                /// - A = Alert; fullt vaken
                /// - C = Confusion; nytillkommen eller förvärrad förvirring
                /// - V = Voice; svarar på tilltal
                /// - P = Pain; reagerar på smärtstimuli
                /// - U = Unresponsive; reagerar inte på smärtstimuli
                ///
                ///
                /// **IMPORTANT**
                ///
                /// Return value is not ment to use in medical assessment. USE att your own risk.
                var acvpu: Double {
                    switch self {
                    case .alert:
                        return 15.0
                    case .sleep:
                        return 14.9
                    case .confusion:
                        return 12.0
                    case .voice:
                        return 10.0
                    case .pain:
                        return 8.0
                    case .unresponsive:
                        return 7.9
                    case .none:
                        return 0.0
                    }
                }
                func readACVPU(_ value: Double) -> Self {
                    switch value {
                    case 15.0:
                        return .alert
                    case 14.9:
                        return .sleep
                    case 12.0:
                        return .confusion
                    case 10.0:
                        return .voice
                    case 8.0:
                        return .pain
                    case 7.9:
                        return .unresponsive
                    default:
                        return .none
                    }
                }
//                /// **GCS - Glasgow Coma Scale**
//                ///
//                /// Med hjälp av GCS kan du bedöma hur och om patienten öppnar ögonen vid tilltal samt patientens motoriska och verbala respons. En patient som är helt medveten och som kan samarbeta kan ges max 15 poäng. Om poängen är 8 eller mindre innebär det att patienten är medvetslös.
//                var glc: Double {
//                    switch self {
//                    case .alert:
//                        <#code#>
//                    case .sleep:
//                        <#code#>
//                    case .confusion:
//                        <#code#>
//                    case .voice:
//                        <#code#>
//                    case .pain:
//                        <#code#>
//                    case .unresponsive:
//                        <#code#>
//                    case .none:
//                        <#code#>
//                    }
//                }
//                
//                /// **RLS - Reaction Level Scale**
//                ///
//                /// Med RLS används verbal - och/eller smärtstimuli.
//                /// - Om patienten svarar på tilltal räknas det som RLS 1-3, vilket innebär att patienten är vid medvetande.
//                /// - En medvetslös patient svarar inte alls på tilltal.
//                /// - Beroende på i vilken grad patienten reagerar på smärtstimuli skattas RLS 4-8, där 8 innebär ingen respons på smärtstimuli.
//                var rls: Double {
//                    switch self {
//                    case .alert:
//                        <#code#>
//                    case .sleep:
//                        <#code#>
//                    case .confusion:
//                        <#code#>
//                    case .voice:
//                        <#code#>
//                    case .pain:
//                        <#code#>
//                    case .unresponsive:
//                        <#code#>
//                    case .none:
//                        <#code#>
//                    }
//                }
            }
        }
    }
    /// Diagnose
    struct Diagnose {
        /// Common psychiatric diagnoses
        enum CommonPsychiatricDiagnoses: String, CaseIterable, Codable, Identifiable {
        case useOfAlcohol, alcoholAddictionDisorder, useOfSubstance, substanceAddictionDisorder, DUP, Psychose, delusions, adhd, ast, eips, asp
            
            var id: Self { self } // --> (id: \.self )
        } //; **-> Care.Patient.TestResults.Utox**
        enum CommonSomaticDiagnoses: String, CaseIterable, Codable, Identifiable {
            case epilepticSeizures, deliriumTremens, diabetesMellitusTypeOne, diabetesMellitusTypeTwo, hiv, hepatitA, hepatitB, hepatitC, mrsa, esbl, vre, covid19, atrialFibrillation, hypertension, hypotension, hyperthyroidism, hypothyroidism, liverCirrhosis, kidneyfailure
            
            var id: Self { self } // --> (id: \.self )
        }
        /* Common somatic diagnoses
        
        /// * EP (epileptic seizures)
        /// * DT (delirium tremens)
        /// * DiabetesMellitusTypeOne
        /// * DiabetesMellitusTypeTwo
        /// * Blodsmitta:
        /// * HIV
        /// * Hepatit A
        /// * Hepatit B
        /// * Hepatit C
        /// * Resistenta bakterier:
        /// * MRSA
        /// * ESBL
        /// * VRE
        /// * COVID-19
        /// * AF (Atrial fibrillation; FF, förmarksflimmer)
        /// * Hypertoni
        /// * Hypotoni
        /// * Hypertyreos
        /// * Hypotyreos
        /// * Levercirros
        /// * Njursvikt
         
         */
    }
    /// Aimed to triage the importans of interaction to support the patient.
    enum PriorityTriage: String, Codable {
        case green, yellow, orange, red, blue
    }
    /// Swedish laws associated with healthcare; often used in closed mental-health.
    enum Laws: String, CaseIterable, Codable {
        case HSL, LPT, LVM, LVU, LRV
    }
    ///  How a patient comes into hospital.
    enum HowPatientComesIn: String, CaseIterable, Codable, Identifiable {
        case police = "Police"
        case lob = "LOB"
        case lptParagraph47 = "LPT §47"
        case ss = "SS"
        case amb = "AMB"
        case pam = "PAM"
        case remissFrom = "Remiss från"
        
        
        var id: Self { self } // --> (id: \.self )
        /// Converts the enum value from string to a integer value type - as in a returning function.
        /// - Parameter self: Care.HowPatientComeIn
        /// - Returns: Int from 0 to 6.
        func converted(from self: Self) -> Int {
            switch self {
            case .police:
                return 0
            case .lob:
                return 1
            case .lptParagraph47:
                return 2
            case .ss:
                return 3
            case .amb:
                return 4
            case .pam:
                return 5
            case .remissFrom:
                return 6
            }
        }
    }
    /// How high is the risk that a patient commit a potential suicidal action on a scale from low to high.
    enum SuicidalRiskNiveau: String, CaseIterable, Codable, Identifiable {
        case low, little, medium, high // TODO: add ".none" and remove ".little"
        
        var id: Self { self } // --> (id: \.self )
        
        var nivea: String {
            return rawValue.capitalized
        }
        /// Converts the enum value from string to a 16-bit signed integer value type - as in a returning function.
        /// - Parameter self: Care.SuicidalRiskNiveau
        /// - Returns: Int 16 from 0 to 3.
        func converted(from self: Self) -> Int16 {
            switch self {
            case .low:
                return 0
            case .little:
                return 1
            case .medium:
                return 2
            case .high:
                return 3
            }
        }
    }
    /// How high is the potential risk a patient will harm somebody or furniture.
    enum ViolenceRiskNiveau: String, CaseIterable, Codable, Identifiable {
        case low, medium, high
        
        var id: Self { self } // --> (id: \.self )
        
        /// Capitalises the violence risk niveau
        var nivea: String {
            return rawValue.capitalized
        }
        /// Converts the enum value from string to a 16-bit signed integer value type - as a computed property.
        var converted: Int16 {
            switch self {
            case .low:
                return 0
            case .medium:
                return 1
            case .high:
                return 2
            }
        }
    }
    ///  How intense staff need to watch a patient. Normal: like all patients. X-OBS: every 15th minute. X-VAK: All the time. X-VAK/X-OBS: relies on previous but only when the patient is awake.
    enum TypesOfObservation: String, CaseIterable, Codable, Identifiable {
        case normal = "normal"
        case xobs = "X-OBS"
        case xvak = "X-VAK"
        case xvakXobs = "X-VAK/X-OBS"
        
        var id: Self { self } // --> (id: \.self )
        
        /// Converts the enum value from string to a 16-bit signed integer value type - as a computed property.
        var converted: Int16 {
            switch self {
                
            case .normal:
                return 0
            case .xobs:
                return 1
            case .xvak:
                return 2
            case .xvakXobs:
                return 3
            }
        }
    }
    
    /// Medicine-Struct with information to create a prescription of a medicine.
    struct Medicine {
//        var name: String
        /// Form of a medicine.
        enum Form: String, CaseIterable, Codable, Identifiable {
            case capsule, tablet, liquid, topical, cream, device, drops, foam, gel, inhaler, injection, lotion, ointment, patch, powder, spray, suppository, none
            
            var id: Self { self } // --> (id: \.self )
            
            var name: String {
                return rawValue.capitalized
            }
        }
        /// Unit of a medicine.
        enum Unit: String, CaseIterable, Codable, Identifiable {
            case milliGram = "mg"
            case mikroGram = "µg"
            case gram = "g"
            case milliLiter = "ml"
            case procent = "%"
            
            case milliGramPerLiter = "mg/L"
            case milliGramPerMilliLiter = "mg/mL"
            case milliGramPerMikroLiter = "mg/µL"
            
            case gramPerLiter = "g/L"
            case gramPerMilliLiter = "g/mL"
            case gramPerMikroLiter = "g/µL"
            case none = "-"
            
            var id: Self { self } // --> (id: \.self )
        }
        enum AmountUnit: String, CaseIterable, Codable, Identifiable {
            case gram = "g"
            case milliGram = "mg"
            case mikroGram = "µg"
            case liter = "L"
            case milliLiter = "mL"
            case mikroLiter = "µL"
            case pieces = "pcs"
            case none = "-"
            
            var id: Self { self } // --> (id: \.self )
        }
        /// Mode of administration
        enum ModeOfAdministration: String, CaseIterable, Codable, Identifiable {
            case oral, im, iv, sc
            
            var id: Self { self } // --> (id: \.self )
        }
        /// Reason of prescribing
        enum ReasonOfPrescribing: String, CaseIterable, Identifiable {
        case sleep, other
            
            var id: Self { self } // --> (id: \.self )
        }
        /// The reason why the treatment ends
        enum TreatmentDurationEndReason: String, CaseIterable, Codable, Identifiable {
            case plannedStop
            
            var id: Self { self } // --> (id: \.self )
        }
        /// Frequency.
        enum Frequency: String, CaseIterable, Codable, Identifiable {
            case atRegularIntervals = "At Regular Intervals"
            case onSpecificDaysOfTheWeek = "On Specific Days of the Week"
            case asNeeded = "As Needed"
            case none = "At certain time"
            
            var id: Self { self } // --> (id: \.self )
            
            var isRepeated: Bool {
                switch self {
                case .atRegularIntervals:
                    return true
                case .onSpecificDaysOfTheWeek:
                    return true
                case .asNeeded:
                    return true
                case .none:
                    return false
                }
            }
        }
        /// Interval.
        enum ChosenInterval: String, CaseIterable, Codable, Identifiable {
            case day = "Day"
            case otherDay = "Other Day"
            case threeDays = "3 Days"
            case fourDays = "4 Days"
            case ninetyNineDays = "99 Days"
            
            var id: Self { self } // --> (id: \.self )
        }
        /// WeekDay.
        enum ChosenDay: String, CaseIterable, Codable, Identifiable {
            case Monday = "Mon"
            case Tuesday = "Tue"
            case Wednesday = "Wed"
            case Thursday = "Thu"
            case Friday = "Fri"
            case Saturday = "Sat"
            case Sunday = "Sun"
            
            var id: Self { self } // --> (id: \.self )
            
            /// Get the number of the day of the week to represent it in other API.
            /// - Parameter self: Enum: ChosenDay
            /// - Returns: Int() of that day in a week.
            func getDayNumber(from self: Self) -> Int {
                switch self {
                case .Monday:
                    return 2
                case .Tuesday:
                    return 3
                case .Wednesday:
                    return 4
                case .Thursday:
                    return 5
                case .Friday:
                    return 6
                case .Saturday:
                    return 7
                case .Sunday:
                    return 1
                }
            }
        }
        /// AdministrationStatus returns a value that represents if the medicine is prescripted, given or skipped.
        enum AdministrationStatus: String {
        case prescripted, given, skipped, taken, none
        }
        /// StartDate that returns Date.now.
        let startDate = Date.now
    }
    /// Peripheral venous catheter
    struct PeripheralVenousCatheter {
        var size: String
        var place: String
        
        enum SizeColors: String, CaseIterable, Codable, Identifiable {
            case black, yellow, blue, pink, green, white, grey, orange
            
            var id: Self { self } // --> (id: \.self )
            
            /// Size of a  peripheral venous catheter. https://en.wikipedia.org/wiki/Peripheral_venous_catheter
            /// - Parameter sizeColor: sizeColor from enumerations.
            /// - Returns: Tuple-value <(Int, Double)> == <(Birmingham gauge units, Diameter in millimeter)>
            func getSize(from sizeColor: SizeColors) -> (Int, Double) {
                switch sizeColor {
                    
                case .black:
                    return (26, 0.46)
                case .yellow:
                    return (24, 0.60)
                case .blue:
                    return (22, 0.90)
                case .pink:
                    return (20, 1.10)
                case .green:
                    return (18, 1.30)
                case .white:
                    return (17, 1.50)
                case .grey:
                    return (16, 1.80)
                case .orange:
                    return (14, 2.00)
                }
            }
            /// Maximum flow rate per minute. https://en.wikipedia.org/wiki/Peripheral_venous_catheter
            /// - Parameter sizeColor: sizeColor from enumerations.
            /// - Returns: String for Maximum flow rate per minute (ml/min).
            func getMaximumFlowRate(from sizeColor: SizeColors) -> String {
                switch sizeColor {
                    
                case .black:
                    return "13-15 ml/min"
                case .yellow:
                    return "36 ml/min"
                case .blue:
                    return "56 ml/min"
                case .pink:
                    return "40-80 ml/min"
                case .green:
                    return "75-120 ml/min"
                case .white:
                    return "128-133 ml/min"
                case .grey:
                    return "236 ml/min"
                case .orange:
                    return "270 ml/min"
                }
            }
        }
    }
    /// Urinary catheter
    struct UrinaryCatheter {
        var size: String
        
        enum SizeColors: String, CaseIterable, Codable, Identifiable {
        case yellowGreen, cornflowerBlue, black, white, green, orange, red, yellow, purple, blue, pink
            
            var id: Self { self } // --> (id: \.self )
            
            /// Size of a Urinary catheter. https://en.wikipedia.org/wiki/Foley_catheter
            /// - Parameter sizeColor: sizeColor from enumerations.
            /// - Returns: Tuple-value <(Int, Double)> == <(Charriere units, millimeter)>
            func getSize(from sizeColor: SizeColors) -> (Int, Double) {
                switch sizeColor {
                    
                case .yellowGreen:
                    return (6, 2.0)
                case .cornflowerBlue:
                    return (8, 2.7)
                case .black:
                    return (10, 3.3)
                case .white:
                    return (12, 4.0)
                case .green:
                    return (14, 4.7)
                case .orange:
                    return (16, 5.3)
                case .red:
                    return (18, 6.0)
                case .yellow:
                    return (20, 6.7)
                case .purple:
                    return (22, 7.3)
                case .blue:
                    return (24, 8.0)
                case .pink:
                    return (26, 8.7)
                }
            }
        }
    }
    /// Patients -Struct is used for texts that are used very often.
    struct Patient {
        /// How is it gong for the patient.
        enum ActivityStatus: String, CaseIterable, Codable, Identifiable {
            case awake, sleeping, none
            
            var id: Self { self } // --> (id: \.self )
        }
        struct Disability {
            var isPermanent: Bool
            let when: Date
            enum AidToolToCope: String, CaseIterable, Codable, Identifiable {
                case rolator, wheelchair, crutches, walkingStick, none
                
                var id: Self { self } // --> (id: \.self )
            }
        }
        struct Excrement {
            enum Vomit: String, CaseIterable, Codable, Identifiable {
                case yes, no, notObserved, none
                
                var id: Self { self } // --> (id: \.self )
            }
            enum Nausea: String, CaseIterable, Codable, Identifiable {
                case yes, no, notObserved, none
                
                var id: Self { self } // --> (id: \.self )
            }
            enum Micturition: String, CaseIterable, Codable, Identifiable {
                case alguria, dysuria, pollakiuria, stranguria, urinary , incontinence, urinaryRetention, notObserved, none
                
                var id: Self { self } // --> (id: \.self )
            }
            enum Faeces: String, CaseIterable, Codable, Identifiable {
                case diarrhoea, constipation, notObserved, none
                
                var id: Self { self } // --> (id: \.self )
            }
        }
        /// Testresults for example tests on Drugs.
        struct TestResults {
            /// UrineTox should be taken.
            enum UrineTox: String, CaseIterable, Codable, Identifiable {
                case yes, no, none
                
                var id: Self { self } // --> (id: \.self )
            }
            /// Dictionary with keys (short) and values for substance's name.
            let drugs: [String: String] = [
                "ACL": "Klonazepam",
                "AMP": "Amfetamin",
                "BZO": "Bensodiazepiner",
                "BUP": "Buprenorfin",
                "CAT": "KAT",
                "COC": "Kokain",
                "EDDP": "Metadonmetabolit",
                "EtG": "Etylglukuronid/Alkohol",
                "FYL": "Fentanyl",
                "GAB": "Gabapentin",
                "KET": "Ketamin",
                "MDMA": "Ecstasy",
                "MEF": "Mefedron",
                "MET": "Metamfetamin",
                "MPD": "Metylfenidat",
                "MTD": "Metadon",
                "MOP": "Morfin/Heroin (Opiater)",
                "OXY": "Oxikodon",
                "PPX": "Dextropropoxifen",
                "PGB": "Pregabalin",
                "THC": "Cannabis",
                "TML": "Tramadol",
                "ZOL": "Zolpidem",
                "ZOP": "Zopiklon",
                "6-MAM": "Heroin"
             ]
        }
    }
}
