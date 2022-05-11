//
//  ContentView.swift
//  HabitBuilder
//
//  Created by Peter Hartnett on 2/3/22.
//

//TODO: - make it reset at midnight each day, or on some other schedule specified in the edit for a habit

//TODO: Make the colors more pleasant
//TODO: add some bounce animation and a slide in to adding the tiles
//TODO: make a small blip and haptic feedback to incrementing a tile
//TODO: Add in the notification system
//TODO: Make some system that spreads out the executions over a defined length fo the day
//TODO: Visuals for clicks, some sort of rewards system.



import SwiftUI

struct ContentView: View {
    @StateObject var habitList = Habits()
    
    @State private var showingAddHabit = false
    @State private var selectedHabit: Habit? = nil
    
    private let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationView {
            ScrollView{
                LazyVGrid(columns: columns) {
                    ForEach(habitList.habits) { habit in
                        Button{} label: {
                            VStack {
                                Text(habit.name)
                                    .font(.title)
                                    .foregroundColor(.primary)
                                    .background(.ultraThinMaterial)
                                Spacer()
                                HStack{
                                    Text("\(habit.currentCount) / \(habit.goalCount)")
                                        .foregroundColor(.primary)
                                        .background(.ultraThinMaterial)
                                        .font(.title2)
                                }
                            }
                            .padding(.vertical)
                            .frame(maxWidth: .infinity, minHeight: 150)
                            .background(habit.currentColor)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke()
                            )
                            .onTapGesture {
                                habitList.increaceCount(habit)
                            }
                            .onLongPressGesture(){
                                print("Longpress")
                                selectedHabit = habit
                            }
                            .sheet(item: $selectedHabit) { habit in
                                EditHabitView(habit: habit){
                                    withAnimation{
                                        habitList.removeHabit(habit)
                                    }
                                }
                            }
                        }//End tile
                    }//EndForEach
                    //Grey add habit tile button
                    Button{
                        showingAddHabit = true
                    } label: {
                        Image(systemName: "plus.circle")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .frame(maxWidth: .infinity, minHeight: 150)
                            .background(Color.gray)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke()
                            )
                    }
                }//End LazyVGrid
                .padding([.horizontal, .bottom])
            }//end ScrollView
            .navigationTitle("Habit Builder")
            .toolbar {
                ToolbarItem() {
                    Button(action: {showingAddHabit.toggle()}){
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddHabit){
                EditHabitView()
            }
        }//end NavigationView
        .environmentObject(habitList)
    }//end body
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}





