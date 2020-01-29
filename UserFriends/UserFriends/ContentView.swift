//
//  ContentView.swift
//  UserFriends
//
//  Created by Matthew Mohrman on 12/29/19.
//  Copyright © 2019 Matthew Mohrman. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: User.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \User.name, ascending: true)]) var users: FetchedResults<User>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(users) { user in
                    NavigationLink(destination: UserDetailView(user: user)) {
                        VStack(alignment: .leading) {
                            Text(user.wrappedName)
                                .font(.headline)
                                .foregroundColor(user.isActive ? nil : .red)
                            Text(user.wrappedEmail)
                                .font(.subheadline)
                        }
                    }
                }
            }
            .navigationBarTitle("Users")
        }
        .onAppear(perform: loadDataIfNecessary)
    }
    
    func loadDataIfNecessary() {
        guard users.isEmpty else {
            return
        }
        
        let urlString = "https://www.hackingwithswift.com/samples/friendface.json"
        let url = URL(string: urlString)!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let data = data {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.dateDecodingStrategy = .iso8601
                jsonDecoder.userInfo[CodingUserInfoKey.context!] = self.moc

                if let _ = try? jsonDecoder.decode([User].self, from: data) {
                    DispatchQueue.main.async {
                        try? self.moc.save()
                    }
                }
            }
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
