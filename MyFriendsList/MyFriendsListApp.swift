//
//  MyFriendsListApp.swift
//  MyFriendsList
//
//  Created by Goutham Devaraju on 29/10/24.
//

import SwiftUI

@main
struct MyFriendsListApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                MyFriendsList()
                    .tint(.white)
            }
        }
    }
}
