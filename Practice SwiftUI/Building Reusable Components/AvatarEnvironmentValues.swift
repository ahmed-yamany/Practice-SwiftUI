//
//  EnvironmentValuesValues.swift
//  Practice SwiftUI
//
//  Created by Ahmed Yamany on 18/12/2023.
//

import SwiftUI

// Creating Environment Variable for Avatar Image Shape
enum AvatarImageShape {
    case rounde, rectangle
}
// 1
struct AvatarImageShapeKey: EnvironmentKey {
    static var defaultValue: AvatarImageShape = .rounde
}
// 2
extension EnvironmentValues {
    var avatarImageShape: AvatarImageShape {
        get {self[AvatarImageShapeKey.self]}
        set {self[AvatarImageShapeKey.self] = newValue}
    }
}
// 3
extension View {
    func avatarImageShape(_ imageShepe: AvatarImageShape) -> some View {
        environment(\.avatarImageShape, imageShepe)
    }
}

// Creating Environment Variable for Avatar Image Click
// 1
struct AvatartClickHandler: EnvironmentKey {
    static var defaultValue: () -> Void = {}
}
// 2
extension EnvironmentValues {
    var editProfileHandler: () -> Void {
        get { self[AvatartClickHandler.self] }
        set { self[AvatartClickHandler.self] = newValue }
    }
}
// 3
extension AvatarView {
    func onAvatarClick(_ handler: @escaping () -> Void ) -> some View {
        environment(\.editProfileHandler, handler)
    }
}

// Creating Environment Variable for make AvatarView Stylable
///
struct AvatarStyleConfiguration {
    let title: String
    let subtitle: String
    let detailTitle: String
    let imageName: String
}

protocol AvatarStyle: DynamicProperty {
    associatedtype Body: View
    typealias Configurations = AvatarStyleConfiguration
    
    @ViewBuilder func makeBody(configuration: Configurations) -> Body
}
//
struct AvatarStyleKey: EnvironmentKey {
    static var defaultValue: any AvatarStyle = DefaultAvatarStyle()
}

extension EnvironmentValues {
    var avatarStyle: any AvatarStyle {
        get { self [AvatarStyleKey.self] }
        set { self [AvatarStyleKey.self] = newValue }
    }
}

extension View {
    func avatarStyle(_ style: some AvatarStyle) -> some View {
       environment(\.avatarStyle, style)
     }
}

// 3: Resove Stylable Avatar
struct ResovedAvatarStyle<Style: AvatarStyle> : View {
    var configuration: Style.Configurations
    var style: Style
    
    var body: some View {
        style.makeBody(configuration: configuration)
    }
}

extension AvatarStyle {
    func resolve(configurations: Configurations) -> some View {
        ResovedAvatarStyle(configuration: configurations, style: self)
    }
}
