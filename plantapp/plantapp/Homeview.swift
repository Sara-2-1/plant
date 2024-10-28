//
//  Homeview.swift
//  plantapp
//
//  Created by Sarah ali  on 18/04/1446 AH.
//


import SwiftUI

struct HomeView: View {
    @State private var plants: [Plant] = []
    @State private var showReminderForm = false
    @State private var selectedPlant: Plant?
    @State private var isFirstTime = true

    var body: some View {
        VStack {
            VStack {
                Text("My Plants 🌱")
                    .font(.system(size: 34, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                Divider()
                    .background(Color.white)
            }
            
            if plants.isEmpty {
                if isFirstTime {
                    VStack(spacing: 20) {
                        Image("icon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 164.0, height: 200.0)
                        
                        Text("Start your plant journey!")
                            .font(.headline)
                            .padding(5)
                        
                        Text("Now all your plants will be in one place and we will help you take care of them :)🪴")
                            .foregroundColor(.gray)
                            .padding()
                        Button(action: {
                            showReminderForm = true
                            isFirstTime = false
                        }) {
                            Text("Set Plant Reminder")
                                .font(.system(size: 15, weight: .medium))
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.color)
                                .foregroundColor(.black)
                                .cornerRadius(10)
                                .padding(.horizontal, 60)
                        }
                    }
                    .padding(.top, 50)
                } else {
                    VStack(spacing: 20) {
                        Image("icon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 164, height: 200)
                        
                        Text("All Done! 🎉")
                            .font(.title2)
                            .fontWeight(.bold)
                        Text("All Reminders Completed")
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.gray)
                            .padding()
                    }
                }
                Spacer()
            } else {
                VStack(alignment: .leading) {
                    Text("Today")
                        .font(.title)
                        .padding(.horizontal)
                        .bold()
                        
                    
                    List {
                        ForEach(sortedPlants()) { plant in
                            VStack{
                                PlantRow(plant: plant, toggleWatered: toggleWatered)
                                    .padding(.vertical , 10)
                                    .padding(.horizontal)
                                Divider()
                            }
                            .listRowInsets(EdgeInsets())
                            .listRowBackground(Color.clear)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                selectedPlant = plant
                                showReminderForm = true
                            }
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive) {
                                    deletePlant(plant)
                                } label: {
                                    Image(systemName: "trash")
                                }
                            }
                        }
                    }
                }
                .listStyle(PlainListStyle())
            }
            Spacer()

            if !isFirstTime {
                Button(action: {
                    showReminderForm = true
                }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.color)
                        Text("New Reminder")
                            .foregroundColor(.color)
                        Spacer()
                    }
                    .padding()
                }
                .sheet(isPresented: $showReminderForm) {
                    PlantReminderSheet(plants: $plants, plantToEdit: selectedPlant)
                        .onDisappear {
                            selectedPlant = nil
                        }
                }
            }
        }
    }

    private func sortedPlants() -> [Plant] {
        return plants.sorted { !$0.isChecked && $1.isChecked }
    }

    private func toggleWatered(_ plant: Plant) {
        if let index = plants.firstIndex(where: { $0.id == plant.id }) {
            plants[index].isChecked.toggle()
            plants = sortedPlants()
        }
    }

    private func deletePlant(_ plant: Plant) {
        if let index = plants.firstIndex(where: { $0.id == plant.id }) {
            plants.remove(at: index)
        }
    }
}

struct PlantRow: View {
    var plant: Plant
    var toggleWatered: (Plant) -> Void
    
    var body: some View {
        HStack {
            Button(action: {
                toggleWatered(plant)
            }) {
                Image(systemName: plant.isChecked ? "checkmark.circle.fill" : "circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 23, height:23 )
                    .padding(3)
                    .foregroundColor(plant.isChecked ? .color : .gray)
            }
            .buttonStyle(PlainButtonStyle())

                VStack(alignment: .leading, spacing:5) {
                    HStack {
                        Image(systemName: "location")
                            .foregroundColor(.gray)
                        Text("in \(plant.room)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                    Text(plant.name)
                        .font(.system(size: 28 , weight: .light))
                        .foregroundColor(plant.isChecked ?  .secondary : .primary)
                                            
                  
                    HStack {
                        Label(plant.light, systemImage: "sun.max")
                            .font(.system(size: 14, weight: .light))
                            .padding(3)
                            .foregroundColor( .colory)
                            .background(plant.isChecked ? Color.gray.opacity(0.1) :Color.gray.opacity(0.2) )
                            .cornerRadius(8)
                        Label(plant.waterAmount, systemImage: "drop")
                            .font(.system(size: 14, weight: .light))
                            .padding(3)
                            .foregroundColor(.colorb)
                            .background(plant.isChecked ? Color.gray.opacity(0.1) :Color.gray.opacity(0.2) )                            .cornerRadius(8)
                    }
                }
                Spacer()
            }
        }
    }
    
    struct HomeView_Previews: PreviewProvider {
        static var previews: some View {
            HomeView()
        }
    }

