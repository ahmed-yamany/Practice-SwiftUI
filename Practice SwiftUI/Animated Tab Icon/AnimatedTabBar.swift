//
//  AnimatedTabBar.swift
//  Practice SwiftUI
//
//  Created by Ahmed Yamany on 18/12/2023.
//

import SwiftUI

struct AnimatedTabBar: View {
    @StateObject private var viewModel = AnimateTabbarViewModel()
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack(alignment: .bottom) {
            tabViews
            tabBar
        }
        .ignoresSafeArea()
        .onAppear {
            UITabBar.appearance().isHidden = true
        }
        .onDisappear {
            UITabBar.appearance().isHidden = false
        }
    }
    
    var tabViews: some View {
        TabView(selection: $viewModel.selectedTab) {
            ForEach(TabTypes.allCases, id: \.hashValue) { tabType in
                    tabType
                        .view
                        .tag(tabType)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.primary.opacity(0.05))
                        .ignoresSafeArea()
            }
        }
    }
    
    var tabBar: some View {
        HStack(spacing: 0) {
            
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal)
        .padding(.vertical, 10)
        .background {
            colorScheme == .dark ? Color.black : Color.white
        }
    }
}

#Preview {
    AnimatedTabBar()
}
