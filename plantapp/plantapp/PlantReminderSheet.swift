//
//  Setpage.swift
//  plantapp
//
//  Created by Sarah ali  on 18/04/1446 AH.
//

import SwiftUI


struct PlantReminderSheet: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var plantName = ""
    @State private var room = "Bedroom"
    @State private var light = "Full sun"
    @State private var wateringDays = "Every day"
    @State private var waterAmount = "20-50 ml"
    
    var onSave: (PlantReminder) -> Void
    
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 80) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Cancel")
                        .foregroundColor(.blue)
                        .padding()
                }
                
                Text("Set Reminder")
                    .bold()
                    .foregroundColor(.black)
                
                Button(action: {
                    let reminder = PlantReminder(
                        plantName: plantName,
                        room: room,
                        light: light,
                        wateringDays: wateringDays,
                        waterAmount: waterAmount
                    )
                    onSave(reminder)
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Save")
                        .foregroundColor(.blue)
                }
            }
            
            Form {
                Section {
                    HStack {
                        Text("Plant Name")
                        TextField("Pothos", text: $plantName)
                            .foregroundColor(.primary)
                    }
                }
                
                Section {
                    HStack {
                        Image(systemName: "location")
                        Picker("Room", selection: $room) {
                            Text("Bedroom").tag("Bedroom")
                            Text("Living Room").tag("Living Room")
                            Text("Kitchen").tag("Kitchen")
                            Text("Bathroom").tag("Bathroom")
                        }
                    }
                    
                    HStack {
                        Image(systemName: "sun.max")
                        Picker("Light", selection: $light) {
                            Text("Full sun").tag("Full sun")
                            Text("Partial sun").tag("Partial sun")
                            Text("Shade").tag("Shade")
                        }
                    }
                }
                .pickerStyle(MenuPickerStyle())
                
                Section {
                    HStack {
                        Image(systemName: "drop")
                        Picker("Watering Days", selection: $wateringDays) {
                            Text("Every day").tag("Every day")
                            Text("Every 2 days").tag("Every 2 days")
                            Text("Twice a week").tag("Twice a week")
                            Text("Once a week").tag("Once a week")
                        }
                    }
                    
                    HStack {
                        Image(systemName: "drop")
                        Picker("Water Amount", selection: $waterAmount) {
                            Text("20-50 ml").tag("20-50 ml")
                            Text("50-100 ml").tag("50-100 ml")
                            Text("100-150 ml").tag("100-150 ml")
                        }
                    }
                }
                .pickerStyle(MenuPickerStyle())
            }
            .padding()
        }
    }
}
