//
//  Setpage.swift
//  plantapp
//
//  Created by Sarah ali  on 18/04/1446 AH.
//
import SwiftUI

struct PlantReminderSheet: View {
    @Binding var plants: [Plant]
    @State var name = ""
    @State var room = "Bedroom"
    @State var light = "Full sun"
    @State var wateringDays = "Every day"
    @State var waterAmount = "20-50 ml"
    @Environment(\.presentationMode) var presentationMode
    var plantToEdit: Plant?

    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        Text("Plant Name")
                        TextField("Pothos", text: $name)
                            .foregroundColor(.white)
                    }
                }
                
                Section {
                    HStack {
                        Image(systemName: "location")
                            .foregroundColor(.white)
                        
                        Picker("Room", selection: $room) {
                            Text("Bedroom").tag("Bedroom")
                            Text("Living Room").tag("Living Room")
                            Text("Kitchen").tag("Kitchen")
                            Text("Bathroom").tag("Bathroom")
                        }
                    }
                    HStack {
                        Image(systemName: "sun.max")
                            .foregroundColor(.white)
                        
                        Picker("Light", selection: $light) {
                            Text("Full sun").tag("Full sun")
                            Text("Partial sun").tag("Partial sun")
                            Text("Low light").tag("Low light")
                        }
                    }
                }
                    Section {
                        HStack {
                            Image(systemName: "drop")
                                .foregroundColor(.white)
                            
                            Picker("Watering Days", selection: $wateringDays) {
                                Text("Every day").tag("Every day")
                                Text("Every 2 days").tag("Every 2 days")
                                Text("Every 3 days").tag("Every 3 days")
                                Text("Once a week").tag("Once a week")
                                Text("Every 10 days").tag("Every 10 days")
                                Text("Every 2 weeks").tag("Every 2 weeks")
                            }
                        }
                        HStack {
                            Image(systemName: "drop")
                                .foregroundColor(.white)
                            Picker("Water Amount", selection: $waterAmount) {
                                Text("20-50 ml").tag("20-50 ml")
                                Text("50-100 ml").tag("50-100 ml")
                                Text("100-200 ml").tag("100-200 ml")
                                Text("200-300 ml").tag("200-300 ml")
                            }
                        }
                    }
                    if plantToEdit != nil {
                        Section {
                            Button(action: deletePlant) {
                                Text("Delete Plant")
                                    .frame(maxWidth: .infinity)
                                    .foregroundColor(.red)
                                    .font(.system(size: 20))
                                    .padding(.vertical, 8)
                            }
                        }
                    }
                
            }
            .navigationTitle(plantToEdit == nil ? "Plant Data" : "Edit Reminder")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
                    .foregroundColor(.color),
                trailing: Button("Save") {
                    savePlant()
                }
                    .foregroundColor(.color)
            )
            .onAppear {
                if let plant = plantToEdit {
                    name = plant.name
                    room = plant.room
                    light = plant.light
                    wateringDays = plant.wateringDays
                    waterAmount = plant.waterAmount
                }
            }
        }
    }

    private func savePlant() {
        if let plant = plantToEdit {
            if let index = plants.firstIndex(where: { $0.id == plant.id }) {
                plants[index] = Plant(id: plant.id, name: name, room: room, light: light, wateringDays: wateringDays, waterAmount:waterAmount)
            }
        } else {
            let newPlant = Plant(name: name, room: room, light: light, wateringDays: wateringDays, waterAmount: waterAmount)
            plants.append(newPlant)
        }
        presentationMode.wrappedValue.dismiss()
    }

    private func deletePlant() {
        if let plant = plantToEdit, let index = plants.firstIndex(where: { $0.id == plant.id }) {
            plants.remove(at: index)
        }
        presentationMode.wrappedValue.dismiss()
    }
}

