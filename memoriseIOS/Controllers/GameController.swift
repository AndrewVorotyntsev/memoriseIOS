import Foundation

class GameController {
    var cardPairs: Int
    var cards: [Card]
    var scoreController: ScoreController

    var amountOfTips: Int

    var firstChoosenCardIndex: Int?
    var secondChoosenCardIndex: Int?


    // Инициализация игры
    init(scoreController: ScoreController) {
        // Игра начинается со случайного количества карта от 2 до 5
        cardPairs = Int.random(in: 2..<5)
        self.scoreController = scoreController
        // Ограничиваем количество подсказок одной
        amountOfTips = 1
        cards = []
        startGame()
    }
    
    // Обновить раунд игры
    func updateGameRound(){
        firstChoosenCardIndex = nil
        secondChoosenCardIndex = nil
    }
    
    // Перевернуть карточку лицевой стороной вверх
    func turnOnCard(_ cardIndex: Int) {
        cards[cardIndex].isFaceUp = true
    }
    
    // Перевернуть карточку лицевой стороной вниз
    func turnOffCard(_ cardIndex: Int) {
        cards[cardIndex].isFaceUp = false
    }

    func chooseCard(cardIndex: Int) {
        // Выбранную карту выбрать уже нельзя
        if (firstChoosenCardIndex == cardIndex || secondChoosenCardIndex == cardIndex) {
            return;
        }

        // Если на экране две карты уже лежат лицевой стороной вверх, то скрываем их и обновляем раунд
        if (firstChoosenCardIndex != nil && secondChoosenCardIndex != nil) {
            turnOffCard(firstChoosenCardIndex!)
            turnOffCard(secondChoosenCardIndex!)
            updateGameRound()
        }
        
        // Если ни одна карта на экране не выбрана, выбираем первую карту
        if (firstChoosenCardIndex == nil && secondChoosenCardIndex == nil) {
            firstChoosenCardIndex = cardIndex
            turnOnCard(firstChoosenCardIndex!)
        } else {
            // Если выбрана одна карта
            secondChoosenCardIndex = cardIndex
            turnOnCard(secondChoosenCardIndex!)
            // Проверяем на совпадение
            if (cards[firstChoosenCardIndex!].contentID == cards[secondChoosenCardIndex!].contentID) {
                // Добавляем два очка за сопадение
                scoreController.addScore(2)
                cards[secondChoosenCardIndex!].isGuessed = true
                cards[firstChoosenCardIndex!].isGuessed = true
                
                // Скрыть последние карты
                if (cards.first(where: {$0.isGuessed == false}) == nil) {
                    self.cards[self.secondChoosenCardIndex!].isFaceUp = false
                    self.cards[self.firstChoosenCardIndex!].isFaceUp = false
                }
            } else {
                // Штраф за несовпадение
                scoreController.awardPenalty(1)
            }
        }
        
    }

    func startGame() {
        initCards()
        shuffleCard()
        amountOfTips = 1
        scoreController.reset()
    }

    func shuffleCard() {
        cards.shuffle()
    }

    // Создает список упорядоченных карт
    private func initCards() {
        self.cards = []
        for i in 0..<cardPairs * 2 {
            cards.append(Card(i, content: Int(floor( Float(i) / 2))))
        }
    }

    func changeDifficulty(newDifficulty: Int) {
        cardPairs = newDifficulty
        startGame()
    }

    func turnOnAllCard() {
        for i in 0..<cardPairs * 2 {
            cards[i].isFaceUp = true
        }
    }
    
    func turnOffAllCard() {
        for i in 0..<cardPairs * 2 {
           cards[i].isFaceUp = false
        }
    }

}

struct Card: Identifiable {
    var id: Int
    var contentID: Int
    var isFaceUp: Bool
    var isGuessed: Bool

    init(_ i: Int, content: Int){
        id = i
        contentID = content
        isFaceUp = false
        isGuessed = false
    }
}
