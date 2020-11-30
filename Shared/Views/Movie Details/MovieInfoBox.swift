//
//  MovieInfoBox.swift
//  test8200ac
//
//  Created by אילי זוברמן on 30/11/2020.
//

import SwiftUI

struct MovieInfoBox: View {
    
    let movie: Movie
    
    var body: some View {
        VStack(spacing: 16){
            HStack{
                CustomLabel(image: "person.3.fill", description: String(format: "%.2f", movie.popularity))
                
                CustomLabel(image: "star.fill", description: "\(movie.voteAverage)")
                    
                if let date = movie.releaseDate.toDate()?.date{
                    CustomLabel(image: "calendar", description: "\(date.toFormat("MM.dd.yy"))")
                }
            }
            .padding(.horizontal)
            
            GroupBox(label: Text("Overview:").padding(.bottom,8), content: {
                Text(movie.overview)
                    .fixedSize(horizontal: false, vertical: true)
            })
            .groupBoxStyle(RoundedGroupBoxStyle())
            .padding(.horizontal, 32)
        }
    }
}
