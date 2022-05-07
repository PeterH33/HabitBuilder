//
//  AddHabitView.swift
//  HabitBuilder
//
//  Created by Peter Hartnett on 2/7/22.
//

import SwiftUI

struct AddHabitView: View {
    @ObservedObject var habitList: Habits
    
    @State private var name = ""
    @State private var perDayCount = 0
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView{
            Form{
                TextField("Name", text: $name)
                
                Section{
                    Picker("Goal per day", selection: $perDayCount){
                        ForEach(0..<12){
                            Text($0, format: .number)
                        }//end foreach
                    }//end picker
                    
                    .pickerStyle(.wheel)
                } header: {
                    Text("Goal per day")
                }
            }//end form
            .navigationTitle("Add new Habit")
            .toolbar{
                Button("Save"){
                    let item = Habit(name: name, goalCount: perDayCount, currentCount: 0)
                    habitList.habits.append(item)
                    dismiss()
                }
            }
        }//end navigation view
    }
}

struct AddHabitView_Previews: PreviewProvider {
    static var previews: some View {
        AddHabitView(habitList: Habits())
    }
}
