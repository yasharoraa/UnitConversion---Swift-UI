//
//  ContentView.swift
//  UnitConversion
//
//  Created by Yash Arora on 13/09/22.
//

import SwiftUI


struct ContentView: View {
    private let celsuis = "Celsius", fahrenheit = "Fahrenheit", kelvin = "Kelvin"
    @State private var temp = 0.0
    @State private var inputOutput: (String, String)
    @FocusState private var inputIsFocused: Bool
    private let units: Array<String>
    private var convertedValue: Double {
        switch(inputOutput) {
        case (celsuis, fahrenheit): return (temp*(9/5) + 32)
        case (celsuis, kelvin): return (temp + 273.15)
        case (fahrenheit, celsuis): return ((temp - 32) * 5/9)
        case (fahrenheit, kelvin): return ((temp - 32) * 5/9 + 273.15)
        case (kelvin, celsuis): return (temp - 273.15)
        case (kelvin, fahrenheit): return ((temp - 273.15) * 9/5 + 32)
        default: return temp
        }
    }
    
    init() {
        self.inputOutput = (celsuis, fahrenheit)
        self.units = [celsuis, fahrenheit, kelvin]
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Input Unit", selection: $inputOutput.0) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }.pickerStyle(.segmented)
                } header: {
                    Text("Select input unit")
                }
                Section {
                    Picker("Output Unit", selection: $inputOutput.1) {
                        ForEach(units, id: \.self) {
                            Text($0)
                        }
                    }.pickerStyle(.segmented)
                }header: {
                    Text("Select output unit")
                }
                Section {
                    TextField("Temperature", value: $temp, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputIsFocused)
                } header: {
                    Text("Enter input temperature")
                }
                Section {
                    Text(String(convertedValue))
                } header: {
                    Text("Output temperature will appear here")
                }
            }
            .navigationTitle("Temperature Conversion")
            .navigationBarTitleDisplayMode(.inline)
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
