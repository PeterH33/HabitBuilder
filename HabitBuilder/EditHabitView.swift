////
////  EditHabitView.swift
////  HabitBuilder
////
////  Created by Peter Hartnett on 2/7/22.
////

import SwiftUI

//This function helps to populate the TextField View and place the button on it when the view is first shown. It leaves the font blue, indicating that it can be clicked as well.
struct TextFieldClearButton: ViewModifier {
    @Binding var text: String
    
    func body(content: Content) -> some View {
        HStack {
            content
            if !text.isEmpty {
                Button(
                    action: { self.text = "" },
                    label: {
                        Image(systemName: "x.circle.fill")
                            .foregroundColor(.secondary)
                    }
                )
            }
        }
    }
}


struct EditHabitView: View {
    @EnvironmentObject var habitList: Habits
    @Environment(\.dismiss) var dismiss
    
    var habit: Habit?
    
    var removal: (() -> Void)? = nil
   
    @State private var editingHabit = false
    @State private var newName: String = ""
    @State private var newGoalCount: Int = 0
    @State private var showingDeleteConfirmation = false
    
    enum Field {
        case nameField
    }
    @FocusState private var focusedField : Field?
    
    var body: some View {
        NavigationView{
            Form{
               
                TextField("Habit Name", text: $newName)
                    .modifier(TextFieldClearButton(text: $newName))
                    .focused($focusedField, equals: .nameField)
                    
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
                    editingHabit = true
                } else {
                    //This focus is delayed because the sheet presentation animation prevents teh focus field from functioning for about 0.6 seconds
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.65)
                    {
                        focusedField = .nameField
                    }
                }
            }
            .navigationTitle(editingHabit ? "Edit Habit" : "Add Habit")
            .toolbar{
                ToolbarItemGroup(placement: .navigationBarTrailing){
                    if editingHabit{
                        Button(action: {
                           showingDeleteConfirmation = true
                        }){
                            Image(systemName: "trash")
                        }
                    }
                    Button("Save"){
                        //TODO: Consider autosave vs intentional save. Apple seems to favor autosave, I prefer intentional save.
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
            .confirmationDialog("Do you want to delete this habit?", isPresented: $showingDeleteConfirmation){
                Button("Delete Habit", role: .destructive){
                    removal?()
                    dismiss()
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
