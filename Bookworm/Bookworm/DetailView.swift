//
//  DetailView.swift
//  Bookworm
//
//  Created by Matthew Mohrman on 12/27/19.
//  Copyright © 2019 Matthew Mohrman. All rights reserved.
//

import CoreData
import SwiftUI

struct DetailView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var showingDeleteAlert = false
    
    let book: Book
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack(alignment: .bottomTrailing) {
                    if self.book.genre?.isEmpty == true {
                        AnyView(
                            Rectangle()
                                .fill(Color.green)
                                .frame(width: geometry.size.width, height: 420 / 828 * geometry.size.width)
                        )
                    } else {
                        AnyView(
                            Image(self.book.genre ?? "Fantasy")
                                .frame(maxWidth: geometry.size.width)
                        )
                    }
                    
                    Text(self.book.displayGenre.uppercased())
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(8)
                        .foregroundColor(.white)
                        .background(Color.black.opacity(0.75))
                        .clipShape(Capsule())
                        .offset(x: -5, y: -5)
                }
                
                Text(self.book.author ?? "Unknown author")
                    .font(.title)
                    .foregroundColor(.secondary)
                
                Text(self.book.displayDate)
                    .font(.subheadline)
                
                Text(self.book.review ?? "No review")
                    .padding()
                
                RatingView(rating: .constant(Int(self.book.rating)))
                    .font(.largeTitle)
                
                Spacer()
            }
        }
        .navigationBarTitle(Text(book.title ?? "Unknown Book"), displayMode: .inline)
        .alert(isPresented: $showingDeleteAlert) {
            Alert(title: Text("Delete book"), message: Text("Are you sure?"), primaryButton: .destructive(Text("Delete"), action: deleteBook), secondaryButton: .cancel())
        }
        .navigationBarItems(trailing:
            Button(action: {
                self.showingDeleteAlert = true
            }) {
                Image(systemName: "trash")
            }
        )
    }
    
    func deleteBook() {
        moc.delete(book)
        
        try? moc.save()
        
        presentationMode.wrappedValue.dismiss()
    }
}

struct DetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let book = Book(context: moc)
        book.title = "Test book"
        book.author = "Test author"
        book.genre = "Fantasy"
        book.rating = 4
        book.review = "This was a great book; I really enjoyed it."
        book.date = Date()
        
        return NavigationView {
            DetailView(book: book)
        }
    }
}
