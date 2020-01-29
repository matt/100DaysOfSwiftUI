//
//  UserDetailView.swift
//  UserFriends
//
//  Created by Matthew Mohrman on 12/29/19.
//  Copyright © 2019 Matthew Mohrman. All rights reserved.
//

import CoreData
import SwiftUI

struct UserDetailView: View {
    let user: User
    var fetchRequest: FetchRequest<User>
    var friendUsers: FetchedResults<User> {
        fetchRequest.wrappedValue
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("\(self.user.age)")
                    Text(self.user.wrappedCompany)
                    Text(self.user.wrappedEmail)
                    Text(self.user.displayAddress)
                    
                    Text(self.user.displayRegistered)
                    Text(self.user.isActive ? "Active" : "Inactive")
                    
                    Text(self.user.wrappedAbout)
                        .frame(maxWidth: geometry.size.width)
                    
                    Text(self.user.displayTags)
                    
                    ForEach(self.friendUsers) { friend in
                        NavigationLink(destination: UserDetailView(user: friend)) {
                            Text(friend.wrappedName)
                        }
                    }
                }
                .padding()
                
                Spacer()
            }
            
        }
        .navigationBarTitle(Text(self.user.wrappedName), displayMode: .inline)
    }
    
    init(user: User) {
        self.user = user
        
        let friendUserIds = user.friendsArray.map { $0.id }
        
        self.fetchRequest = FetchRequest<User>(entity: User.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \User.name, ascending: true)], predicate: NSPredicate(format: "id IN %@", friendUserIds))
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let user = User(context: moc)
        user.id = UUID()
        user.isActive = true
        user.name = "First Last"
        user.age = Int16(21)
        user.company = "Apple"
        user.email = "first.last@example.com"
        user.address = "1 N Main St, City, St 12345"
        user.about = "Not very interesting"
        user.registered = Date()
        user.tags = NSSet(array: [])
        user.friends = NSSet(array: [])
        
        return UserDetailView(user: user)
    }
}
