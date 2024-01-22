//
//  ContentView.swift
//  CarCustomiser
//
//  Created by Kim, Joshua (WING) on 19/01/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var starterCars = StarterCars()
    @State private var selectedCar: Int = 0 {
        didSet {
            if selectedCar >= starterCars.cars.count {
                selectedCar = 0
            }
        }
    }
    
    @State private var exhaustPackage = false
    @State private var tiresPackage = false
    @State private var suspensionPackage = false
    @State private var boosterPackage = false
    @State private var remainingFunds = 1000
    
    var exhaustPackageDisabled: Bool {
        if exhaustPackage {
            return false
        } else {
            if remainingFunds < 500 {
                return true
            } else {
                return false
            }
        }
    }
    
    var tiresPackageDisabled: Bool {
        if tiresPackage {
            return false
        } else {
            if remainingFunds < 500 {
                return true
            } else {
                return false
            }
        }
    }
    
    var suspensionPackageDisabled: Bool {
        if suspensionPackage {
            return false
        } else {
            if remainingFunds < 500 {
                return true
            } else {
                return false
            }
        }
    }
    
    var boosterPackageDisabled: Bool {
        if boosterPackage {
            return false
        } else {
            if remainingFunds < 500 {
                return true
            } else {
                return false
            }
        }
    }
    
    var body: some View {
        let exhaustPackageBinding = Binding<Bool>(
            get: { self.exhaustPackage },
            set: { newValue in
                self.exhaustPackage = newValue
                if newValue == true {
                    starterCars.cars[selectedCar].topSpeed += 5
                    remainingFunds -= 500
                } else {
                    starterCars.cars[selectedCar].topSpeed -= 5
                    remainingFunds += 500
                }
            }
        )
        
        let tiresPackageBinding = Binding<Bool>(
            get: { self.tiresPackage },
            set: { newValue in
                self.tiresPackage = newValue
                if newValue == true {
                    starterCars.cars[selectedCar].handling += 2
                    remainingFunds -= 500
                } else {
                    starterCars.cars[selectedCar].handling -= 2
                    remainingFunds += 500

                }
            }
        )
        
        let suspensionPackageBinding = Binding<Bool>(
            get: { self.suspensionPackage },
            set: { newValue in
                self.suspensionPackage = newValue
                if newValue == true {
                    starterCars.cars[selectedCar].handling += 1
                    starterCars.cars[selectedCar].topSpeed += 1
                    remainingFunds -= 500
                } else {
                    starterCars.cars[selectedCar].handling -= 1
                    starterCars.cars[selectedCar].topSpeed -= 1
                    remainingFunds += 500
                }
            }
        )
        
        let boosterPackageBinding = Binding<Bool>(
            get: { self.boosterPackage },
            set: { newValue in
                self.boosterPackage = newValue
                if newValue == true {
                    starterCars.cars[selectedCar].acceleration -= 1
                    remainingFunds -= 1000
                } else {
                    starterCars.cars[selectedCar].acceleration += 1
                    remainingFunds += 1000
                }
            }
        )
        
        VStack {
            Form {
                VStack(alignment: .leading, spacing: 20) {
                    Text("\(starterCars.cars[selectedCar].displayStats())")
                    Button("Next Car", action: {
                        resetDisplay()
                        selectedCar += 1
                    })
                }
                Section {
                    Toggle("Exhaust Package (Cost: 500)", isOn: exhaustPackageBinding)
                        .disabled(exhaustPackageDisabled)
                    Toggle("Tires Package (Cost: 500)", isOn: tiresPackageBinding)
                        .disabled(tiresPackageDisabled)
                    Toggle("Suspension Package (Cost: 500)", isOn: suspensionPackageBinding)
                        .disabled(suspensionPackageDisabled)
                    Toggle("Booster Package (Cost: 1000)", isOn: boosterPackageBinding)
                        .disabled(boosterPackageDisabled)
                }
            }
            Text("Remaining Funds: \(remainingFunds)")
                .foregroundColor(.red)
                .baselineOffset(20)
        }
    }
    
    func resetDisplay() {
        if exhaustPackage {
            exhaustPackage = false
            starterCars.cars[selectedCar].topSpeed -= 5
        }
        
        if tiresPackage {
            tiresPackage = false
            starterCars.cars[selectedCar].handling -= 2

        }
        
        if suspensionPackage {
            suspensionPackage = false
            starterCars.cars[selectedCar].handling -= 1
            starterCars.cars[selectedCar].topSpeed -= 1
        }
        
        if boosterPackage {
            boosterPackage = false
            starterCars.cars[selectedCar].acceleration += 1
        }
        
        remainingFunds = 1000
    }
}

#Preview {
    ContentView()
}
