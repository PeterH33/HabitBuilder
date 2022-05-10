//
//  AddHabitView.swift
//  HabitBuilder
//
//  Created by Peter Hartnett on 2/7/22.
//

import SwiftUI

struct AddHabitView: View {
    
    @EnvironmentObject var habitList: Habits
    
    @State private var name = ""
    @State private var perDayCount = 0
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView{
            Form{
                TextField("Habit Name", text: $name)
                
                Section{
                    Picker("How many times per day?", selection: $perDayCount){
                        ForEach(1..<100){
                            Text($0, format: .number)
                        }//end foreach
                    }//end picker
                    
                    .pickerStyle(.wheel)
                } header: {
                    Text("How many times per day?")
                }
            }//end form
            .navigationTitle("Add a new Habit")
            .toolbar{
                Button("Save"){
                    let habit = Habit()
                    habit.name = name
                    habit.goalCount = perDayCount + 1
                    habit.currentCount = 0
                    habitList.habits.append(habit)
                    dismiss()
                }
            }
        }//end navigation view
    }
}

struct AddHabitView_Previews: PreviewProvider {
    static var previews: some View {
        AddHabitView()
    }
}
