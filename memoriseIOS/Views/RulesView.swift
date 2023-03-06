//
//  RulesView.swift
//  memoriseIOS
//
//  Created by xcode on 26.10.2022.
//  Copyright © 2022 xcode. All rights reserved.
//

import SwiftUI

struct RulesView: View {
    var body: some View {
        VStack(alignment: .leading) {
           Text("Правила игры")
           Text("1) Вы должны выбрать две карты.")
           Text("2) Если карты совпадут вы получаете два очка.")
           Text("3) В противном случае  вы теряете одно очко.")
           Text("4) Вы можете воспользоваться подсказкой стоимостью 5 очков.")
           Text("5) Игра завершается когда угаданы все карты.")
        }.padding(10)
    }
}

struct RulesView_Previews: PreviewProvider {
    static var previews: some View {
        RulesView()
    }
}
