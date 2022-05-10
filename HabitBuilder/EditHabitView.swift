////
////  EditHabitView.swift
////  HabitBuilder
////
////  Created by Peter Hartnett on 2/7/22.
////

import SwiftUI

struct EditHabitView: View {
    @EnvironmentObject var habitList: Habits
    @Environment(\.dismiss) var dismiss
    var habit: Habit
    
    @State private var newName: String = ""
    @State private var newGoalCount: Int = 0
    
    var body: some View {
        NavigationView{
            Form{
                TextField("Name", text: $newName)

                Section{
                    Picker("How many times per day", selection: $newGoalCount){
                        ForEach(1..<100){
                            Text($0, format: .number)
                        }//end foreach
                    }//end picker

                    .pickerStyle(.wheel)
                } header: {
                    Text("How many times per day")
                }
            }//end form
            .navigationTitle("Edit Habit")
            .toolbar{
                Button("Save"){
                    let newHabit = Habit()
                    newHabit.goalCount = newGoalCount
                    newHabit.name = newName
                    newHabit.currentCount = habit.currentCount
                    habitList.addHabit(newHabit)
                    habitList.habits.removeAll { $0 == habit}
                    dismiss()
                }
            }
            .onAppear(){
                newName = habit.name
                newGoalCount = habit.goalCount
            }
        }//end navigation view
    }//end body
}

struct EditHabitView_Previews: PreviewProvider {
    static var previews: some View {
        EditHabitView(habit: Habit())
    }
}
