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
    
    
    var removal: (() -> Void)? = nil
   
    
    @State private var newName: String = ""
    @State private var newGoalCount: Int = 0
    
    var body: some View {
        NavigationView{
            Form{
                Text("\(habit.name)")
                TextField("New name", text: $newName)

                Section{
                    Picker("How many times per day", selection: $newGoalCount){
                        ForEach(1..<100){
                            Text($0, format: .number)
                        }//end foreach
                    }//end picker

                    .pickerStyle(.wheel)
                } header: {
                    Text("Old number per day: \(habit.goalCount)")
                }
            }//end form
            .onAppear(){
                newName = habit.name
                newGoalCount = habit.goalCount - 1
            }
            .navigationTitle("Edit Habit")
            .toolbar{
                ToolbarItemGroup(placement: .navigationBarTrailing){
                    Button("Delete"){
                        removal?()
                        dismiss()
                    }
                    Button("Save"){
                        let newHabit = Habit()
                        newHabit.goalCount = newGoalCount + 1
                        newHabit.name = newName
                        newHabit.currentCount = 0
                        habitList.addHabit(newHabit)
                        removal?()
                        dismiss()
                    }
                }
            }
        }//end navigation view
        
    }//end body
}

struct EditHabitView_Previews: PreviewProvider {
    static var previews: some View {
        EditHabitView(habit: Habit())
    }
}
