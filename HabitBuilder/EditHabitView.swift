////
////  EditHabitView.swift
////  HabitBuilder
////
////  Created by Peter Hartnett on 2/7/22.
////
//
//import SwiftUI
//
//struct EditHabitView: View {
//    @EnvironmentObject var habitList: Habits
//    var id: UUID
//    //Get a proper reference to the tile in question
//    
//    var body: some View {
//        NavigationView{
//            Form{
//                TextField("Name", text: $name)
//                
//                Section{
//                    Picker("Goal per day", selection: $perDayCount){
//                        ForEach(0..<12){
//                            Text($0, format: .number)
//                        }//end foreach
//                    }//end picker
//                    
//                    .pickerStyle(.wheel)
//                } header: {
//                    Text("Goal per day")
//                }
//            }//end form
//            .navigationTitle("Add new Habit")
//            .toolbar{
//                Button("Save"){
//                    let item = Habit(name: name, goalCount: perDayCount, currentCount: 0)
//                    habitList.habits.append(item)
//                    dismiss()
//                }
//            }
//        }//end navigation view
//    }//end body
//}
//
//struct EditHabitView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditHabitView(habitList: Habits())
//    }
//}
