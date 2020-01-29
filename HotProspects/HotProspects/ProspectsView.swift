//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Matthew Mohrman on 1/9/20.
//  Copyright © 2020 Matthew Mohrman. All rights reserved.
//

import CodeScanner
import SwiftUI
import UserNotifications

enum FilterType {
    case none, contacted, uncontacted
}

enum SortType: String {
    case name = "Name"
    case mostRecent = "Most Recent"
}

struct ProspectsView: View {
    @EnvironmentObject var prospects: Prospects
    @State private var isShowingScanner = false
    @State private var isShowingSortOptions = false
    @State private var sort = SortType.name
    let filter: FilterType
    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted people"
        case .uncontacted:
            return "Uncontacted people"
        }
    }
    var filteredProspects: [Prospect] {
        let filteredProspects: [Prospect]
        
        switch filter {
        case .none:
            filteredProspects = prospects.people
        case .contacted:
            filteredProspects = prospects.people.filter { $0.isContacted }
        case .uncontacted:
            filteredProspects = prospects.people.filter { !$0.isContacted }
        }
        
        switch sort {
        case .name:
            return filteredProspects.sorted { $0.name < $1.name }
        case .mostRecent:
            return filteredProspects.sorted { $0.introductionDate > $1.introductionDate }
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredProspects) { prospect in
                    HStack {
                        if self.filter == .none {
                            if prospect.isContacted {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                            } else {
                                Image(systemName: "questionmark.diamond.fill")
                                    .foregroundColor(.yellow)
                            }
                        }
                        VStack(alignment: .leading) {
                            Text(prospect.name)
                                .font(.headline)
                            Text(prospect.emailAddress)
                                .foregroundColor(.secondary)
                        }
                    }
                    .contextMenu {
                        Button(prospect.isContacted ? "Mark Uncontacted" : "Mark Contacted") {
                            self.prospects.toggle(prospect)
                        }
                        
                        if !prospect.isContacted {
                            Button("Remind Me") {
                                self.addNotification(for: prospect)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle(title)
            .navigationBarItems(leading:
                Button("Sort") {
                    self.isShowingSortOptions = true
                }
                , trailing:
                Button(action: {
                    self.isShowingScanner = true
                }) {
                    Image(systemName: "qrcode.viewfinder")
                    Text("Scan")
                }
            )
                .sheet(isPresented: $isShowingScanner) {
                    CodeScannerView(codeTypes: [.qr], simulatedData: "Matt\nmatt@example.com", completion: self.handleScan)
            }
            .actionSheet(isPresented: $isShowingSortOptions) {
                ActionSheet(title: Text(self.sort.rawValue), message: Text("Select a new sort type"), buttons: [
                    .default(Text(SortType.name.rawValue), action: {
                        self.sort = .name
                    }),
                    .default(Text(SortType.mostRecent.rawValue), action: {
                        self.sort = .mostRecent
                    }),
                    .cancel()
                ])
            }
        }
    }
    
    func handleScan(result: Result<String, CodeScannerView.ScanError>) {
        switch result {
        case .success(let code):
            let details = code.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            
            let person = Prospect()
            person.name = details[0]
            person.emailAddress = details[1]
            
            prospects.add(person)
        case .failure(_):
            print("Scanning failed")
        }
        
        self.isShowingScanner = false
    }
    
    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default
            
            var dateComponents = DateComponents()
            dateComponents.hour = 9
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            //let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }
        
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else {
                        print("D'oh")
                    }
                }
            }
        }
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none)
    }
}
