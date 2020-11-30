//
//  CustomLabel.swift
//  test8200ac
//
//  Created by אילי זוברמן on 30/11/2020.
//

import SwiftUI

struct CustomLabel: View{
    
    @Environment(\.colorScheme) var colorScheme
    
    let image: String
    let description: String
    
    var body: some View{
        HStack(spacing: 16){
            Image(systemName: image)
                .renderingMode(.template)
                .aspectRatio(contentMode: .fit)
                .frame(width: 30)
                .foregroundColor(.secondary)
            Text(description)
        }
        .padding(8)
        .background(colorScheme == .dark ? Color(UIColor.systemGray5) : Color.white)
        .cornerRadius(10)
    }
}
