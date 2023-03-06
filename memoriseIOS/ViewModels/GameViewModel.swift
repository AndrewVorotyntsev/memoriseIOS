//
//  GameViewModel.swift
//  memoriseIOS
//
//  Created by xcode on 15.11.2022.
//  Copyright © 2022 xcode. All rights reserved.
//

import Foundation
import SwiftUI

class GameViewModel: ObservableObject {
    
    var score: Int {
        get {
            let score = scoreController.score
            return score
        }
    }
    
    var cards: [Card] {
        get {
            let cards = gameController.cards
            return cards
        }
    }
    
    var scoreController: ScoreController
    var gameController: GameController
    
    init() {
        let scoreController = ScoreController()
        self.scoreController = scoreController
        gameController = GameController(scoreController: scoreController)
    }
    
    func chooseCard(cardIndex: Int) {
        objectWillChange.send()
        gameController.chooseCard(cardIndex: cardIndex)
    }

    func startGame(newDifficulty: Int?) {
        print("Game start")
        objectWillChange.send()
        if (newDifficulty != nil) {
            gameController.changeDifficulty(newDifficulty: newDifficulty!)
        }
        gameController.startGame()
    }
    
    func useTip() {
        if (gameController.amountOfTips > 0) {
            self.gameController.turnOffAllCard()
            objectWillChange.send()
            gameController.turnOnAllCard()
            // TODO: chnage to five seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                print("end")
                self.objectWillChange.send()
                self.gameController.turnOffAllCard()
                // При использовании подсказки начислить штрафные 5 очков
                self.gameController.scoreController.awardPenalty(5)
                self.gameController.amountOfTips = 0
                self.gameController.firstChoosenCardIndex = nil
                self.gameController.secondChoosenCardIndex = nil
            })
        }
    }
    
    func shuffleCard() {
        objectWillChange.send()
        gameController.shuffleCard()
    }
    
}
