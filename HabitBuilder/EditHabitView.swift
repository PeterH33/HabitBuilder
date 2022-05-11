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
    
    
    var habit: Habit?
    
    
    var removal: (() -> Void)? = nil
   
    @State private var showingDelete = false
    @State private var newName: String = ""
    @State private var newGoalCount: Int = 0
    
    var body: some View {
        NavigationView{
            Form{
               // Text("\(newName)")
                TextField("Habit Name", text: $newName)
                //TODO: Make this populate on appear, maybe start cursor here on new habit
                //TODO: add a clear line button (lookup and add textfield notes to book)

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
                            //TODO: Add confirmation dialog
                            //TODO: Change to a trash can icon
                            removal?()
                            dismiss()
                        }
                    }
                    Button("Save"){
                        //TODO: This might be something to consider, what is the current gesture and icon language for saving a file? It seems like apple is mostly of the auto save all changes mindset.
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
