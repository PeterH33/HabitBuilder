//
//  Habits.swift
//  HabitBuilder
//
//  Created by Peter Hartnett on 5/7/22.
//

import SwiftUI

class Habit: Identifiable, Codable, Hashable{
    static func == (lhs: Habit, rhs: Habit) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
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
    
    func addHabit(_ habit: Habit){
        habits.append(habit)
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
