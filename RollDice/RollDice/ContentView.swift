//
//  ContentView.swift
//  RollDice
//
//  Created by Matthew Mohrman on 1/22/20.
//  Copyright © 2020 Matthew Mohrman. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    
    enum TabState {
        case rollDice, history
    }
    
    var body: some View {
        TabView {
            RollDiceView().environment(\.managedObjectContext, moc)
            .tabItem {
                Image(systemName: "questionmark.square")
                Text("Roll Dice")
            }
            .tag(TabState.rollDice)
            
            
            HistoryView()
            .tabItem {
                Image(systemName: "text.justify")
                Text("History")
            }
            .tag(TabState.history)
        }
        .navigationViewStyle(StackNavigationViewStyle()) 
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
