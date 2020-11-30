//
//  RoundedGroupBoxStyle.swift
//  test8200ac
//
//  Created by אילי זוברמן on 29/11/2020.
//

import SwiftUI

/// Rounded Group Box Style:
/// Corner radius 20
/// Background - default (white/gray)
struct RoundedGroupBoxStyle: GroupBoxStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        GroupBox(label: HStack {
            configuration.label
        }) {
            configuration.content
        }
        .cornerRadius(20)
    }
}
