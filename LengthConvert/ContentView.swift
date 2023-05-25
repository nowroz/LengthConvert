//
//  ContentView.swift
//  LengthConvert
//
//  Created by Nowroz Islam on 24/5/23.
//

import SwiftUI

enum LengthUnit: String, CaseIterable, Identifiable {
    case millimeter
    case centimeter
    case meter
    case kilometer
    case feet
    case inch
    case yard
    case mile
    
    var id: Self {
        self
    }
}

extension LengthUnit {
    var selectedUnit: UnitLength {
        switch self {
        case .millimeter:
            return UnitLength.millimeters
        case .centimeter:
            return UnitLength.centimeters
        case .meter:
            return UnitLength.meters
        case .kilometer:
            return UnitLength.kilometers
        case .feet:
            return UnitLength.feet
        case .inch:
            return UnitLength.inches
        case .yard:
            return UnitLength.yards
        case .mile:
            return UnitLength.miles
        }
    }
}

struct ContentView: View {
    @State private var input = 0.0
    @State private var inputUnit: LengthUnit = .meter
    @State private var outputUnit: LengthUnit = .kilometer
    
    @FocusState private var inputIsFocused: Bool
    
    private var output: Measurement<UnitLength> {
        let length = Measurement(value: input, unit: inputUnit.selectedUnit)
        let convertedLength = length.converted(to: outputUnit.selectedUnit)
        
        return convertedLength
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Input", value: $input, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputIsFocused)
                    
                    Picker("Select input unit", selection: $inputUnit) {
                        ForEach(LengthUnit.allCases) {
                            Text($0.rawValue)
                        }
                    }
                }
                
                Section {
                    Picker("Select output unit", selection: $outputUnit) {
                        ForEach(LengthUnit.allCases) {
                            Text($0.rawValue)
                        }
                    }
                    
                    Text(output.value, format: .number)
                } header: {
                    Text("OUTPUT")
                }
            }
            .navigationTitle("LengthConvert")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        inputIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
