//
//  TabTypes.swift
//  Practice SwiftUI
//
//  Created by Ahmed Yamany on 18/12/2023.
//

import SwiftUI


enum TabTypes: String, Hashable, CaseIterable {
    case home, chat, notification, bookmark, account
    
    @ViewBuilder
    var view: some View {
        switch self {
            case .home:
                Text("Home")
            case .chat:
                Text("Chat")
            case .notification:
                Text("Notification")
            case .bookmark:
                Text("Bookmark")
            case .account:
                Text("Account")
        }
    }
}
