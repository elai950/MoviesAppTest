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
            GroupBox(content: {
                VStack(spacing: 16){
                    Text("Popularity: \(String(format: "%.2f", movie.popularity))")
                        .font(.headline)
                    Text("Vote Count: \(movie.voteCount)")
                        .font(.headline)
                    if let date = movie.releaseDate.toDate()?.date{
                        HStack{
                            Text("Release Date:")
                            Text(date, style: .date)
                        }
                        .font(.headline)
                    }
                    
                }
            })
            .groupBoxStyle(RoundedGroupBoxStyle())
            .padding(.horizontal, 32)
            
            GroupBox(label: Text("Overview:").padding(.bottom,8), content: {
                Text(movie.overview)
                    .fixedSize(horizontal: false, vertical: true)
            })
            .groupBoxStyle(RoundedGroupBoxStyle())
            .padding(.horizontal, 32)
        }
    }
}
