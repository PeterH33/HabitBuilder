////
////  GridView.swift
////  HabitBuilder
////
////  Created by Peter Hartnett on 2/3/22.
////
//
//import SwiftUI
//
//struct GridView: View {
//    var habitList: Habits
//    @StateObject var habitList =
//
//    let columns = [
//        GridItem(.adaptive(minimum: 150))
//    ]
//
//
//
//    var body: some View {
//        ScrollView {
//            LazyVGrid(columns: columns) {
//                ForEach(habitList.habits, id:\.self) { habit in
//
//                    Button {
//                        //TODO button function
//                      //habit.upCurrentConut()
//
//                    } label: {
//                        VStack {
//
//
//                            VStack {
//                                Text(habit.name)
//                                    .font(.headline)
//                                    .foregroundColor(.primary)
//                                    .background(.ultraThinMaterial)
//                                Spacer()
//                                HStack{
//                                    Text("\(habit.currentCount) / \(habit.goalCount)")
//                                        .foregroundColor(.primary)
//                                        .background(.ultraThinMaterial)
//
//                                }
//                            }
//
//
//                            .padding(.vertical)
//                            .frame(maxWidth: .infinity, minHeight: 150)//Use the frame to make these things squares somehow
//                            .background(habit.currentColor)
//                        }
//                        .clipShape(RoundedRectangle(cornerRadius: 10))
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 10)
//                                .stroke()
//                        )
//                    }
//                }//EndForEach
//                //TODO consider adding a button to add a tile here, that might work fine
//
//            }//End LazyVGrid
//            .padding([.horizontal, .bottom])
//        }//end ScrollView
//        .navigationTitle("Habit Builder")
//        .preferredColorScheme(.dark)
//    }//End body view
//}
//
//struct GridView_Previews: PreviewProvider {
//    static var previews: some View {
//        let dummyData = Habits()
//        GridView(habitList: dummyData)
//    }
//}
