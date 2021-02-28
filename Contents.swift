
import Foundation

// Частина 1

// Дано рядок у форматі "Student1 - Group1; Student2 - Group2; ..."

let studentsStr = "Дмитренко Олександр - ІП-84; Матвійчук Андрій - ІВ-83; Лесик Сергій - ІО-82; Ткаченко Ярослав - ІВ-83; Аверкова Анастасія - ІО-83; Соловйов Даніїл - ІО-83; Рахуба Вероніка - ІО-81; Кочерук Давид - ІВ-83; Лихацька Юлія - ІВ-82; Головенець Руслан - ІВ-83; Ющенко Андрій - ІО-82; Мінченко Володимир - ІП-83; Мартинюк Назар - ІО-82; Базова Лідія - ІВ-81; Снігурець Олег - ІВ-81; Роман Олександр - ІО-82; Дудка Максим - ІО-81; Кулініч Віталій - ІВ-81; Жуков Михайло - ІП-83; Грабко Михайло - ІВ-81; Іванов Володимир - ІО-81; Востриков Нікіта - ІО-82; Бондаренко Максим - ІВ-83; Скрипченко Володимир - ІВ-82; Кобук Назар - ІО-81; Дровнін Павло - ІВ-83; Тарасенко Юлія - ІО-82; Дрозд Світлана - ІВ-81; Фещенко Кирил - ІО-82; Крамар Віктор - ІО-83; Іванов Дмитро - ІВ-82"

// Завдання 1
// Заповніть словник, де:
// - ключ – назва групи
// - значення – відсортований масив студентів, які відносяться до відповідної групи

var studentsGroups: [String: [String]] = [:]

// Ваш код починається тут
let separateAllData = studentsStr.components(separatedBy:"; ")

for student in separateAllData {
    let studentAndGroup = student.components(separatedBy: " - ")
    if var groupArray = studentsGroups[studentAndGroup[1]] {
           groupArray.append(studentAndGroup[0])
            studentsGroups[studentAndGroup[1]] = groupArray
        } else {
            studentsGroups[studentAndGroup[1]] = [studentAndGroup[0]]
        }
}

// Ваш код закінчується тут

print("Завдання 1")
print(studentsGroups)
print()

// Дано масив з максимально можливими оцінками

let points: [Int] = [12, 12, 12, 12, 12, 12, 12, 16]

// Завдання 2
// Заповніть словник, де:
// - ключ – назва групи
// - значення – словник, де:
//   - ключ – студент, який відносяться до відповідної групи
//   - значення – масив з оцінками студента (заповніть масив випадковими значеннями, використовуючи функцію `randomValue(maxValue: Int) -> Int`)

func randomValue(maxValue: Int) -> Int {
    switch(arc4random_uniform(6)) {
    case 1:
        return Int(ceil(Float(maxValue) * 0.7))
    case 2:
        return Int(ceil(Float(maxValue) * 0.9))
    case 3, 4, 5:
        return maxValue
    default:
        return 0
    }
}

var studentPoints: [String: [String: [Int]]] = [:]

// Ваш код починається тут
for groupNumber in studentsGroups {
    var studentAndMarks: [String: [Int]] = [:]
    for student in groupNumber.value {
        studentAndMarks[student] = points.map{ randomValue(maxValue: $0) }
    }
    studentPoints[groupNumber.key] = studentAndMarks
}


// Ваш код закінчується тут

print("Завдання 2")
print(studentPoints)
print()

// Завдання 3
// Заповніть словник, де:
// - ключ – назва групи
// - значення – словник, де:
//   - ключ – студент, який відносяться до відповідної групи
//   - значення – сума оцінок студента

var sumPoints: [String: [String: Int]] = [:]

// Ваш код починається тут

for group in studentPoints {
    var sumMarksOfStudent: [String: Int] = [:]
    for student in group.value {
        sumMarksOfStudent[student.key] = student.value.reduce(0, +)
    }
    sumPoints[group.key] = sumMarksOfStudent
}

// Ваш код закінчується тут

print("Завдання 3")
print(sumPoints)
print()

// Завдання 4
// Заповніть словник, де:
// - ключ – назва групи
// - значення – середня оцінка всіх студентів групи

var groupAvg: [String: Float] = [:]

// Ваш код починається тут

var avgPoint: [String: Float] = [:]
for group in sumPoints {
    let avgMarkInGroup = group.value.values.reduce(0, +)
    groupAvg[group.key] = Float(avgMarkInGroup)/Float(group.value.values.count)
}

// Ваш код закінчується тут

print("Завдання 4")
print(groupAvg)
print()

// Завдання 5
// Заповніть словник, де:
// - ключ – назва групи
// - значення – масив студентів, які мають >= 60 балів

var passedPerGroup: [String: [String]] = [:]

// Ваш код починається тут

let passedMark: Int = 60
for group in sumPoints {
    var studentPassedMark: [String] = []
    for student in group.value {
        if passedMark <= student.value  {
            studentPassedMark.append(student.key)
        }
    }
    passedPerGroup[group.key] = studentPassedMark
}

// Ваш код закінчується тут

print("Завдання 5")
print(passedPerGroup)

// Приклад виведення. Ваш результат буде відрізнятися від прикладу через використання функції random для заповнення масиву оцінок та через інші вхідні дані.
//
//Завдання 1
//["ІВ-73": ["Гончар Юрій", "Давиденко Костянтин", "Капінус Артем", "Науменко Павло", "Чередніченко Владислав"], "ІВ-72": ["Бортнік Василь", "Киба Олег", "Овчарова Юстіна", "Тимко Андрій"], "ІВ-71": ["Андрющенко Данило", "Гуменюк Олександр", "Корнійчук Ольга", "Музика Олександр", "Трудов Антон", "Феофанов Іван"]]
//
//Завдання 2
//["ІВ-73": ["Давиденко Костянтин": [5, 8, 9, 12, 11, 12, 0, 0, 14], "Капінус Артем": [5, 8, 12, 12, 0, 12, 12, 12, 11], "Науменко Павло": [4, 8, 0, 12, 12, 11, 12, 12, 15], "Чередніченко Владислав": [5, 8, 12, 12, 11, 12, 12, 12, 15], "Гончар Юрій": [5, 6, 0, 12, 0, 11, 12, 11, 14]], "ІВ-71": ["Корнійчук Ольга": [0, 0, 12, 9, 11, 11, 9, 12, 15], "Музика Олександр": [5, 8, 12, 0, 11, 12, 0, 9, 15], "Гуменюк Олександр": [5, 8, 12, 9, 12, 12, 11, 12, 15], "Трудов Антон": [5, 0, 0, 11, 11, 0, 12, 12, 15], "Андрющенко Данило": [5, 6, 0, 12, 12, 12, 0, 9, 15], "Феофанов Іван": [5, 8, 12, 9, 12, 9, 11, 12, 14]], "ІВ-72": ["Киба Олег": [5, 8, 12, 12, 11, 12, 0, 0, 11], "Овчарова Юстіна": [5, 8, 12, 0, 11, 12, 12, 12, 15], "Бортнік Василь": [4, 8, 12, 12, 0, 12, 9, 12, 15], "Тимко Андрій": [0, 8, 11, 0, 12, 12, 9, 12, 15]]]
//
//Завдання 3
//["ІВ-72": ["Бортнік Василь": 84, "Тимко Андрій": 79, "Овчарова Юстіна": 87, "Киба Олег": 71], "ІВ-73": ["Капінус Артем": 84, "Науменко Павло": 86, "Чередніченко Владислав": 99, "Гончар Юрій": 71, "Давиденко Костянтин": 71], "ІВ-71": ["Корнійчук Ольга": 79, "Трудов Антон": 66, "Андрющенко Данило": 71, "Гуменюк Олександр": 96, "Феофанов Іван": 92, "Музика Олександр": 72]]
//
//Завдання 4
//["ІВ-71": 79.333336, "ІВ-72": 80.25, "ІВ-73": 82.2]
//
//Завдання 5
//["ІВ-72": ["Бортнік Василь", "Киба Олег", "Овчарова Юстіна", "Тимко Андрій"], "ІВ-73": ["Давиденко Костянтин", "Капінус Артем", "Чередніченко Владислав", "Гончар Юрій", "Науменко Павло"], "ІВ-71": ["Музика Олександр", "Трудов Антон", "Гуменюк Олександр", "Феофанов Іван", "Андрющенко Данило", "Корнійчук Ольга"]]



//Частина 2
print()

class TimeDB{
    var hour: UInt
    var minute: UInt
    var seconds: UInt
    
    init (hour: UInt = 0, minute: UInt = 0, seconds: UInt = 0) {
        
        switch (hour, minute, seconds) {
        case (0..<24, 0..<60, 0..<60):
            self.hour = hour
            self.minute = minute
            self.seconds = seconds
        default:
            fatalError("Incorect data")
        }
    }
    
    init(date: Date) {
            
        let days = Calendar.current
        self.hour = UInt(days.component(.hour, from: date))
        self.minute = UInt(days.component(.minute, from: date))
        self.seconds = UInt(days.component(.second, from: date))
    }
    
    func styleDate() -> Date {
        let stDate = DateFormatter()
        stDate.dateFormat = "HH:mm:ss"
        return stDate.date(from: "\(hour):\(minute):\(seconds)")!
    }
    
    func timeToString() -> String {
        let stDate = DateFormatter()
        stDate.dateFormat = "hh:mm:ss a"
        return stDate.string(from: styleDate())
    }

    func sumTime(defaultTime: TimeDB) -> TimeDB {
        let stDate = DateFormatter()
        stDate.dateFormat = "HH:mm:ss"
        var tempDate = self.styleDate()
        tempDate.addTimeInterval(defaultTime.styleDate().timeIntervalSince(stDate.date(from: "00:00:00")!))
        return TimeDB(date: tempDate)
    }

    func diffTime(defaultTime: TimeDB) -> TimeDB {
        let stDate = DateFormatter()
        stDate.dateFormat = "HH:mm:ss"
        var tempDate = self.styleDate()
        tempDate.addTimeInterval(-defaultTime.styleDate().timeIntervalSince(stDate.date(from: "00:00:00")!))
        return TimeDB(date: tempDate)
    }
    
   class func sumTime2(T1: TimeDB, T2: TimeDB) -> TimeDB {
        let stDate = DateFormatter()
        stDate.dateFormat = "HH:mm:ss"
        var tempDate = T2.styleDate()
        tempDate.addTimeInterval(T1.styleDate().timeIntervalSince(stDate.date(from: "00:00:00")!))
        return TimeDB(date: tempDate)
    }

   class func diffTime2(T1: TimeDB, T2: TimeDB) -> TimeDB {
        let stDate = DateFormatter()
        stDate.dateFormat = "HH:mm:ss"
        var tempDate = T1.styleDate()
        tempDate.addTimeInterval(-T2.styleDate().timeIntervalSince(stDate.date(from: "00:00:00")!))
        return TimeDB(date: tempDate)
    }

}

var T0 = TimeDB()
var T1 = TimeDB(hour: 0, minute: 0, seconds: 0)
var T2 = TimeDB(hour: 0, minute: 0, seconds: 1)
var T3 = TimeDB(hour: 4, minute: 59, seconds: 1)
print("T0 -> ", T0.timeToString())
print("T1 -> ", T1.timeToString())
print("T2 -> ", T2.timeToString())
print("T3 -> ", T3.timeToString())
print()
print("T2 + T3 -> ", T2.sumTime(defaultTime: T3).timeToString())
print("T1 - T2 -> ", T1.diffTime(defaultTime: T2).timeToString())
print("T1 + T2 -> ", T1.sumTime(defaultTime: T2).timeToString())
print("T2 - T1 -> ", T2.diffTime(defaultTime: T1).timeToString())

print("T2 + T3 -> ", TimeDB.sumTime2(T1: T2, T2: T3).timeToString())
print("T1 - T2 -> ", TimeDB.diffTime2(T1: T1, T2: T2).timeToString())

