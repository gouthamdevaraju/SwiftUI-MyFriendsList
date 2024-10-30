//
//  MyFriendsList.swift
//  MyFriendsList
//
//  Created by Goutham Devaraju on 29/10/24.
//

import SwiftUI

struct MyFriendsList: View {
    
    @State private var friends: [String] = []
    @State private var filteredFriends: [String] = []
    @State private var friendName: String = ""
    @State private var isSearching: Bool = false
    
    var body: some View {
        ZStack {
            Color.cyan.edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    
                    TextField(isSearching ? "Search Friend" : "Enter a name to add", text: $friendName)
                        .onSubmit {
                            if !friendName.isEmpty {
                                friends.append(friendName)
                                friendName = ""
                            }
                        }
                        .padding(EdgeInsets(top: 0, leading: 20, bottom: 10, trailing: 10))
                        .textFieldStyle(.roundedBorder)
                        .onChange(of: friendName) {
                            
                            if friendName.isEmpty {
                                filteredFriends = friends
                            } else {
                                filteredFriends = friends.filter{ $0.contains(friendName) }
                            }
                        }
                    
                    Button(isSearching ? "Add Friend" : "Add") {
                        withAnimation {
                            
                            if !isSearching {
                                if !friendName.isEmpty {
                                    friends.append(friendName)
                                    friendName = ""
                                }
                            } else {
                                isSearching.toggle()
                            }
                        }
                    }
                    .buttonStyle(.bordered)
                    .tint(.white)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: isSearching ? 20 : 0))
                    
                    if !isSearching {
                        
                        Button("Search") {
                            withAnimation {
                                isSearching.toggle()
                                filteredFriends = friends
                            }
                        }
                        .buttonStyle(.bordered)
                        .tint(.white)
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 20))
                    }
                }
                
                if isSearching {
                    
                    List(filteredFriends, id: \.self) { friend in
                        VStack {
                            Text(friend)
                        }
                        .listRowSeparator(.visible)
                    }
                    .onAppear {
                        filteredFriends = friends
                    }
                } else {
                    List(friends, id: \.self) { friend in
                        VStack {
                            Text(friend)
                        }
                        .listRowSeparator(.visible)
                    }
                }
            }
        }
        .navigationTitle(isSearching ? "Search Friends" : "Add Friends")
    }
}

#Preview {
    NavigationStack {
        MyFriendsList()
    }
}
