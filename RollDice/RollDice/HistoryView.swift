//
//  HistoryView.swift
//  RollDice
//
//  Created by Matthew Mohrman on 1/22/20.
//  Copyright © 2020 Matthew Mohrman. All rights reserved.
//

import SwiftUI

struct HistoryView: View {
    @FetchRequest(entity: Roll.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Roll.created, ascending: false)]) var rolls: FetchedResults<Roll>
    
    var body: some View {
        NavigationView {
            List(rolls, id: \.self) { roll in
                VStack(alignment: .leading) {
                    Text("Total: \(roll.diceArray.reduce(0) { $0 + Int($1.value) })")
                        .font(.title)
                    
                    HStack(spacing: 15) {
                        ForEach(roll.diceArray, id: \.self) { dice in
                            ZStack {
                                Rectangle()
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(10)
                                Text(String(dice.value))
                                    .font(.title)
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle(Text("History"))
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
