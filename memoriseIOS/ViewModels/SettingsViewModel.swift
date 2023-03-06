//
//  SettingsViewModel.swift
//  memoriseIOS
//
//  Created by xcode on 23.11.2022.
//  Copyright © 2022 xcode. All rights reserved.
//

import Foundation
import SwiftUI

class SettingsViewModel: ObservableObject {
    
    @ObservedObject private var game: GameViewModel;
    
    // Когда меняется сложность - начинаем новую игру
    var diffuculty: Int {
        didSet {
            if diffuculty > oldValue  {
                game.startGame(newDifficulty: diffuculty)
            }
        }
    }
    
    var theme: Theme
    
    init(game: GameViewModel) {
        self.game = game
        self.diffuculty = 0
        self.theme = AnimalsTheme()
    }
    
    func changeDifficulty(newDifficulty: Int) {
        objectWillChange.send()
        diffuculty = newDifficulty
    }
    
    func changeTheme(newTheme: Theme?) {
        objectWillChange.send()
        if (newTheme != nil) {
            theme = newTheme!
        } else {
            let randomThemeIndex = Int.random(in: 0..<2)
            switch randomThemeIndex {
            case 0:
                theme = AnimalsTheme()
            case 1:
                theme = HignTechTheme()
            case 2:
                theme = SportTheme()
            default:
                return;
            }
        }
    }

}
