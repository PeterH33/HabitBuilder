//
//  ContentView.swift
//  HabitBuilder
//
//  Created by Peter Hartnett on 2/3/22.
//
//Challenge from 100DaysofSwift day 47

//*Clear*At the very least, this means there should be a list of all activities they want to track, plus a form to add new activities – a title and description should be enough.
//
//*Clear* For a bigger challenge, tapping one of the activities should show a detail screen with the description. For a tough challenge – see the hints below! – make that detail screen contain how many times they have completed it, plus a button incrementing their completion count.
//
//*Clear* And if you want to make the app really useful, use Codable and UserDefaults to load and save all your data.


//TODO Personal challenge- make this so that on a long click we bring up the edit menu
//TODO - make it reset at midnight each day, or on some other schedule specified in the edit for a habit
//TODO Make it so a habit cant go past 100% completion? I mean thats not really an issue....
//TODO Make the colors more pleasant
//TODO add some bounce animation and a slide in to adding the tiles
//TODO make a small blip and haptic feedback to incrementing a tile
//TODO make the add a tile button into a tile itself.


import SwiftUI

struct ContentView: View {
    @StateObject var habitList = Habits()
    
    @State var showingAddHabit = false
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    //There should be a more readable or elegant way to do this, but this is old style for and forcing. It works, just ugly
    func upCount(id: UUID){
        var i = 0
        for habit in habitList.habits {
            
            if habit.id == id{
                habitList.habits[i].currentCount += 1
            }
            i += 1
        }
    }
    
    
    
    
    var body: some View {
        NavigationView {
            ScrollView{
            LazyVGrid(columns: columns) {
                ForEach(habitList.habits) { habit in
                    
                    Button {
                       //The button function is handled by .onTapGesture.
//                        upCount(id: item.id)
//                        print("\(item.currentCount)")
                        
                    } label: {
                        VStack {
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
                             
                                upCount(id: habit.id)
                                print("\(habit.currentCount)")
                            }
                            .onLongPressGesture(){
                                print("Longpress")
                                //add context menu for edit delete?
                            }
                            
                        }
                    }
                }//EndForEach
                //TODO consider adding a button to add a tile here, that might work fine
                Button{
                    // add habit button
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
               // .padding(.vertical)
            }//End LazyVGrid
            .padding([.horizontal, .bottom])
            
            
            }//End wrapper group
            
            .navigationTitle("Habit Builder")
            .toolbar {
                ToolbarItem() {
                    Button(action: {showingAddHabit.toggle()}){
                        //showingGrid ? Image( systemName: "list.dash") : Image(systemName: "square.grid.2x2")
                        Image(systemName: "plus")
                    }
                }
            }
            
        }//end NavigationView
        .sheet(isPresented: $showingAddHabit){
            AddHabitView(habitList: habitList)
        }
        
  
    }//end body
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}





