//
//  ThemeController.swift
//  memoriseIOS
//
//  Created by xcode on 16.11.2022.
//  Copyright © 2022 xcode. All rights reserved.
//

import Foundation
import SwiftUI

// Абстракция для темы
protocol Theme {
    var name: String { get }
    var cardContent: Array<String> {get}
    var backgroundColor: Color { get }
    var cardColor: Color { get }
    var pieColor: Color { get }
}

struct AnimalsTheme: Theme{
    var name: String
    var cardContent: [String]
    var backgroundColor: Color
    var cardColor: Color
    var pieColor: Color
    
    init() {
        name = "animals"
        cardContent = ThemeData.animalsEmojies
        cardColor = Color.orange
        backgroundColor = Color.white
        pieColor = Color.green
    }
}

struct HignTechTheme: Theme{
    var name: String
    var cardContent: [String]
    var backgroundColor: Color
    var cardColor: Color
    var pieColor: Color
    
    init() {
        name = "hign tech"
        cardContent = ThemeData.highTechEmojies
        cardColor = Color.red
        backgroundColor = Color.black
        pieColor = Color.yellow
    }
}

struct SportTheme: Theme{
    var name: String
    var cardContent: [String]
    var backgroundColor: Color
    var cardColor: Color
    var pieColor: Color
    
    init() {
        name = "sport"
        cardContent = ThemeData.sportEmojies
        cardColor = Color.white
        backgroundColor = Color.green
        pieColor = Color.gray
    }
}

struct ThemeData {
    
    static var animalsEmojies = [
        "🐶",
        "🐱",
        "🐭",
        "🐹",
        "🐰",
        "🦊",
        "🐻",
        "🐼",
        "🐨",
        "🐯",
        "🦁",
        "🐮",
        "🐷",
        "🐽",
        "🐸",
        "🐵",
        "🐔",
        "🐧",
        "🐦",
        "🐣",
        "🦆",
        "🦅",
        "🦉",
        "🦇",
        "🐺"
    ]
    
    static var highTechEmojies = [
        "⌚️",
        "💻",
        "📱",
        "⌨️",
        "🖲",
        "🖥",
        "🖨",
        "🖱",
        "🕹",
        "💾",
        "💿",
        "📼",
        "📸",
        "📹",
        "📞",
        "📟",
        "📺",
        "🎚",
        "🎛",
        "💡",
        "🧪",
        "📇",
        "📓",
        "📊"
    ]
    
    static var sportEmojies = [
        "⚽️",
        "🏀",
        "🏈",
        "⚾️",
        "🥎",
        "🎾",
        "🏐",
        "🏉",
        "🥏",
        "🎱",
        "🏓",
        "🏸",
        "🏒",
        "🏑",
        "⛳️",
        "🏹",
        "🥊",
        "🛷",
        "🛹",
        "⛸",
        "🥌",
        "🎳",
        "🎮",
        "🎣",
        "🥋",
        "🏏",
    ]
}
