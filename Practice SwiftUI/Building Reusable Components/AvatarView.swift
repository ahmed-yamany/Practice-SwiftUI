//
//  AvatarView.swift
//  Practice SwiftUI
//
//  Created by Ahmed Yamany on 18/12/2023.
//

import SwiftUI

struct AvatarView: View {
    let person: Person
    @Environment(\.avatarStyle) var style
   
    
    var body: some View {
        let configurations = AvatarStyleConfiguration(title: person.fullName,
                                                      subtitle: person.jobtitle,
                                                      detailTitle: person.affiliation,
                                                      imageName: person.profileImageName)
        AnyView(style.resolve(configurations: configurations))
    }
    

   
}

#Preview {
   BuildingReusableComponents()
}
