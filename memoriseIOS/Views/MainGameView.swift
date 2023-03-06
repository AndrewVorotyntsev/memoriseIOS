//
//  ContentView.swift
//  memoriseIOS
//
//  Created by xcode on 12.10.2022.
//  Copyright © 2022 xcode. All rights reserved.
//

import SwiftUI

struct MainGameView: View {
    @ObservedObject private var viewModel: GameViewModel;
    @ObservedObject private var settingsViewModel: SettingsViewModel;
    
    init() {
        let model = GameViewModel()
        self.viewModel = model
        settingsViewModel = SettingsViewModel(game: model)
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20)
            {
                HStack(alignment: .top, spacing: 10) {
                    Button(action: {
                        self.viewModel.useTip()
                    }) {
                        Text(self.viewModel.gameController.amountOfTips > 0
                            ? "💡"
                            : "🚫"
                        )
                    }
                    Spacer()
                    Text(String(self.viewModel.gameController.scoreController.score))
                    Spacer()
                    NavigationLink(destination: SettingsView(viewModel: settingsViewModel)) {
                        Text(String(settingsViewModel.theme.name))
                    }
                }.padding()
                HStack(){
                    Grid (viewModel.cards) {
                        card in CardView(card: self.viewModel.gameController.cards[card.id], theme: self.settingsViewModel.theme).onTapGesture {
                            withAnimation(.linear) {
                                // Если карта лежит лицевой стороной вверх выбрать уже нельзя
                                //if (!card.isFaceUp) {
                                    self.viewModel.chooseCard(cardIndex: card.id)
                                //}
                            }
                        }.padding(5)
                    }
                }.padding().foregroundColor(self.settingsViewModel.theme.cardColor).font(Font.largeTitle)
                HStack(spacing: 10) {
                    NavigationLink(destination: RulesView()) {
                        Text("?")
                    }
                    Spacer()
                    Button(action: {
                        withAnimation(.easeInOut) {
                            self.viewModel.startGame(newDifficulty: nil)
                        }
                    }) {Text("Start")}
                    Spacer()
                    Button(action: {
                        withAnimation(.easeInOut) {
                            self.viewModel.shuffleCard()
                        }
                    }) {Text("Shuffle")}
                }
                .padding()
                
            }
            .navigationBarTitle("Memory game")
            .background(self.settingsViewModel.theme.backgroundColor)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainGameView()
    }
}


struct CardView: View {
    var card: Card
    var theme: Theme
    
    var body : some View {
        GeometryReader {
            geometry in self.body(for: geometry.size)
        }
    }
    
    @ViewBuilder
    private func body (for size: CGSize) -> some View {
        // Показываем неугаданные карты и карты которые были угаданы в прошлом раунде
        if !self.card.isGuessed || (self.card.isGuessed && self.card.isFaceUp) {
            ZStack {
                if self.card.isFaceUp {
                    Group{
                        RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
                        RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth
                        )
                        Pie(startAngle: Angle.degrees(0 - 90), endAngle: Angle.degrees(110 - 90), clockwise: true)
                            .padding(5)
                            .opacity(0.4)
                            .foregroundColor(theme.pieColor)
                        // Получаем содержимое карты по ид
                        Text(theme.cardContent[card.contentID])
                            .rotationEffect(Angle.degrees(card.isGuessed ? 360 : 0))
                            .animation(
                                card.isGuessed
                                    ? Animation.linear(duration: 1).repeatForever(autoreverses: false)
                                    : .default
                        )
                    }.opacity(card.isFaceUp ? 1 : 0)
                }
                else {
                    RoundedRectangle(cornerRadius: cornerRadius).fill()
                    .opacity(card.isFaceUp ? 0 : 1)
                }
            }
            .rotation3DEffect(Angle.degrees(card.isFaceUp ? 0 : 180), axis: (x: 0, y: 1, z: 0))
            .transition(AnyTransition.scale)
        }
    }
    let cornerRadius: CGFloat = 10.0
    let edgeLineWidth: CGFloat = 3
    
    //    func fontSize (for size: CGFloat) -> CGFloat {
    //        min(size.width, size.height) * 0.75
    //    }
    
}
