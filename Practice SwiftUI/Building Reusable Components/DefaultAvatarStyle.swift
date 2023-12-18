//
//  DefaultAvatarStyle.swift
//  Practice SwiftUI
//
//  Created by Ahmed Yamany on 18/12/2023.
//

import SwiftUI

struct DefaultAvatarStyle: AvatarStyle {
    @Environment(\.avatarImageShape) private var imageShape
    @Environment(\.editProfileHandler) private var editProfileHandler
    
    func makeBody(configuration: Configurations) -> some View {
        HStack(alignment: .top) {
            profileImage(configuration.imageName)
                .accessibilityLabel(configuration.title)
                .onTapGesture {
                    editProfileHandler()
                }
            
            VStack(alignment: .leading) {
                titleLabel(configuration.title)
                detailsLabel(configuration.subtitle)
                detailsLabel(configuration.detailTitle)
            }
            Spacer()
        }
        .accessibilityElement(children: .contain)
        .accessibilityLabel(configuration.subtitle)
    }
    
    @ViewBuilder
    private func profileImage(_ imageName: String) -> some View {
        if imageShape == .rounde {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 75, height: 75)
                .clipShape(.circle)
        } else {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 75, height: 75)
        }
    }
    
    @ViewBuilder
    private func titleLabel(_ text: String) -> some View {
        Text(text)
            .font(.headline)
    }
    
    private func detailsLabel( _ text: String) -> some View {
        Text(text)
            .font(.subheadline)
    }
    
}

