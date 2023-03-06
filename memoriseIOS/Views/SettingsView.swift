//
//  SettingsView.swift
//  memoriseIOS
//
//  Created by xcode on 26.10.2022.
//  Copyright © 2022 xcode. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    
    @ObservedObject private var viewModel: SettingsViewModel
    
    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Themes").font(
                .system(size: 20, weight: .bold) )     ;
            Button(
                action: {
                    self.viewModel.changeTheme(newTheme: AnimalsTheme())
                }
            ) {Text("animals")}
            Button(
                action: {
                self.viewModel.changeTheme(newTheme: HignTechTheme())
                }
            ) {Text("hign tech")}
            Button(
                action: {
                self.viewModel.changeTheme(newTheme: SportTheme())
                }
            ) {Text("sport")}
            Button(
                action: {
                self.viewModel.changeTheme(newTheme: nil)
                }
            ) {Text("random")}
            Text("Difficulty").font(
                .system(size: 20, weight: .bold)  )       ;   HStack(alignment: .top, spacing: 10){
                    Button(action: {
                        self.viewModel.changeDifficulty(newDifficulty: 8)
                    }) {Text("8")}
                    
                    Button(action: {
                        self.viewModel.changeDifficulty(newDifficulty: 12)
                    }) {Text("12")}
                    Button(action: {
                        self.viewModel.changeDifficulty(newDifficulty: 24)
                    }) {Text("24")}
            }
        }
    }
}
