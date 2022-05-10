//
//  Habits.swift
//  HabitBuilder
//
//  Created by Peter Hartnett on 5/7/22.
//

import SwiftUI

class Habit: Identifiable, Codable{
    var id = UUID()
    var name : String = ""
    var goalCount : Int = 1
    var currentCount : Int = 0
    
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


@MainActor class Habits: ObservableObject{
    @Published var habits: [Habit] {
        didSet {
            save()
        }
    }
    
    func increaceCount(_ habit: Habit) {
        if habit.currentCount < habit.goalCount{
            objectWillChange.send()
            habit.currentCount += 1
            save()
        }
    }
    
    let saveKey = "SavedData"
    
    private func save() {
        FileManager.default.encode(habits, toFile: saveKey)
    }
    
    init() {
        if let decoded: [Habit] = FileManager.default.decode(saveKey){
            habits = decoded
            return
        }
        habits = []
    }
    
    
    
    
    
}
