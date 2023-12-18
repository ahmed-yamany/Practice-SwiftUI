//
//  BuildingReusableComponents.swift
//  Practice SwiftUI
//
//  Created by Ahmed Yamany on 18/12/2023.
//

import SwiftUI
/*
 1: Creating Environvent variable
 2: Creating Stylable Component
 3: Resove Stylable Component
 */
struct BuildingReusableComponents: View {
    @State private var people = Person.samples
    @State private var participants = Person.samples.filter { $0.isParticipant }
    
    var body: some View {
        List {
            Section("Pariticipants") {
                ForEach(participants) { participant in
                    AvatarView(person: participant)
                        .avatarImageShape(.rounde)
                        
                }
            }
            
            Section("Speakers") {
                ForEach(people) { person in
                    AvatarView(person: person)
                        .onAvatarClick {
                            print("You've tapped on the \(person.fullName) profile image!")
                        }
                }
            }
        }
        .avatarImageShape(.rectangle)
    }
}

#Preview {
    BuildingReusableComponents()
}
