//
//  Habits.swift
//  HabitBuilder
//
//  Created by Peter Hartnett on 5/7/22.
//

import SwiftUI

struct Habit: Identifiable, Codable{
    var id = UUID()

    
    var name : String
    var goalCount : Int
    var currentCount : Int
    
//    init(name: String, goalCount: Int, currentCount: Int){
//        self.name = name
//        self.goalCount = goalCount
//        self.currentCount = currentCount
//    }
    var colorRatio : Double{
        get{
            Double(currentCount)/Double(goalCount)
        }
    }
    var currentColor : Color {
        //calculate the color as a hue shift between Red and green
        get{
            Color.init(red: 1 - colorRatio, green:  colorRatio, blue: 0)
        }
        
    }
    
}


class Habits: ObservableObject{
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") { //check for our "Items" key in userdefaults
            if let decodedItems = try? JSONDecoder().decode([Habit].self, from: savedItems) {// make a decoder and have it do decoding
                habits = decodedItems //assign that array to items
                return
            }
        }

        habits = [] // if fails, then just make items [] empty
    }
    
    @Published var habits = [Habit]() {
        didSet { //note, xcode seems to not want to auto complete didSet at all, watch out for that
            if let encoded = try? JSONEncoder().encode(habits) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
}
