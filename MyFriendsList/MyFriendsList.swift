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
    @State private var searchString: String = ""
    @State private var isSearching: Bool = false
    
    var body: some View {
        ZStack {
            Color.cyan.edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    if !isSearching {
                        TextField("Enter your friend's name to add", text: $friendName)
                            .onSubmit {
                                if !friendName.isEmpty {
                                    friends.append(friendName)
                                    friendName = ""
                                }
                            }
                            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 10))
                            .textFieldStyle(.roundedBorder)
                    }
                    
                    if !isSearching {
                        
                        Button("Add") {
                            withAnimation {
                                if !friendName.isEmpty {
                                    friends.append(friendName)
                                    friendName = ""
                                }
                            }
                        }
                        .buttonStyle(.bordered)
                        .tint(.white)
                        
                        Button("Search") {
                            withAnimation {
                                isSearching.toggle()
                            }
                        }
                        .buttonStyle(.bordered)
                        .tint(.white)
                        .padding()
                    }
                }
                
                if isSearching {
                    
                    VStack {
                        
                        Button("Add Friend") {
                            withAnimation {
                                isSearching.toggle()
                            }
                        }
                        .buttonStyle(.bordered)
                        .tint(.white)
                        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                        
                        List(filteredFriends, id: \.self) { friend in
                            VStack {
                                Text(friend)
                            }
                            .listRowSeparator(.visible)
                        }
                        .searchable(text: $searchString)
                        .onChange(of: searchString) { oldValue, newValue in
                            if searchString.isEmpty {
                                filteredFriends = friends
                            } else {
                                filteredFriends = friends.filter{ $0.contains(searchString) }
                            }
                        }
                        .onAppear {
                            filteredFriends = friends
                        }
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
