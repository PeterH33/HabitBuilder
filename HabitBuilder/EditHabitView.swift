////
////  EditHabitView.swift
////  HabitBuilder
////
////  Created by Peter Hartnett on 2/7/22.
////

import SwiftUI

//TODO: The Add Habit can and should be collapsed into the Edit view. Adding a habit is just editing a non existant view into a new one... right?

struct EditHabitView: View {
    @EnvironmentObject var habitList: Habits
    @Environment(\.dismiss) var dismiss
    
    //TODO: Make the passed in habit optional? And then unwrap it into the new variables if its there, and hide the delete button at the top if its not?
    var habit: Habit?
    
    
    var removal: (() -> Void)? = nil
   
    @State private var showingDelete = false
    @State private var newName: String = ""
    @State private var newGoalCount: Int = 0
    
    var body: some View {
        NavigationView{
            Form{
                Text("\(newName)")
                TextField("New name", text: $newName)

                Section{
                    Picker("How many times per day", selection: $newGoalCount){
                        ForEach(1..<100){
                            Text($0, format: .number)
                        }//end foreach
                    }//end picker

                    .pickerStyle(.wheel)
                } header: {
                    Text("How many times per day: \(newGoalCount)")
                }
            }//end form
            .onAppear(){
                if let inHabit = habit{
                    newName = inHabit.name
                    newGoalCount = inHabit.goalCount - 1
                    showingDelete = true
                }
            }
            .navigationTitle("Edit Habit")
            .toolbar{
                ToolbarItemGroup(placement: .navigationBarTrailing){
                    if showingDelete{
                        Button("Delete"){
                            removal?()
                            dismiss()
                        }
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
