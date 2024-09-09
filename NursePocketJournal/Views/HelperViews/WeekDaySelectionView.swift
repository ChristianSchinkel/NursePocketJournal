//
//  WeekDaySelectionView.swift
//  CareNote
//
//  Created by Christian Schinkel on 2024-03-28.
//

import SwiftUI


struct WeekDaySelectionView: View {
    @Binding var chosenDays: [Care.Medicine.ChosenDay] // chosen days to be a binding.
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack {
                ForEach(Care.Medicine.ChosenDay.allCases, id: \.self) { day in
                    Text(day.rawValue)
                        .bold()
                        .foregroundStyle(.white)
                        .frame(width: 30, height: 30)
                        .background(chosenDays.contains(day) ? Color.cyan.clipShape(Circle()) : Color.gray.clipShape(Circle()))
                        .onTapGesture {
                            if chosenDays.contains(day) {
                                chosenDays.removeAll(where: { $0 == day })
                            } else {
                                chosenDays.append(day)
                            }
                        }
                }
            }
            
            Text("\(chosenDays.count) \(checkGrammaOf(chosenDays.count))")
        }
        
    }
    // MARK: - Functions for this View:
    private func checkGrammaOf(_ selection: Int) -> String {
        if chosenDays.count > 1 {
            return "selections"
        } else if chosenDays.count == 1 {
            return "selection"
        } else {
            return "Nothing selected"
        }
    }
}

#Preview {
    struct Preview: View {
        @State private var chosenDays: [Care.Medicine.ChosenDay] = []
        
        var body: some View {
            WeekDaySelectionView(chosenDays: $chosenDays)
        }
    }
    
    return Preview()
}
