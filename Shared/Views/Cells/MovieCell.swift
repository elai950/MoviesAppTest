//
//  MovieCell.swift
//  test8200ac
//
//  Created by אילי זוברמן on 30/11/2020.
//

import SwiftUI

struct MovieCell: View{
    
    let movie: Movie
    
    var body: some View{
        HStack(spacing: 16){
            ImageLoader(url: URL(string: "https://image.tmdb.org/t/p/w500/\(movie.posterPath ?? "")"), size: 100)
                .aspectRatio(contentMode: .fit)
                .frame(width: 100)
                .cornerRadius(10)
                .padding(.vertical, 8)
                .compositingGroup()
            VStack(alignment: .leading, spacing: 8){
                VStack(alignment: .leading){
                    Text(movie.title)
                        .font(.headline)
                    if let date = movie.releaseDate.toDate()?.date{
                        Text(date, style: .date)
                            .foregroundColor(.secondary)
                            .font(.footnote)
                    }
                }
                
                HStack{
                    Text("Vote average:")
                    Text(String(format: "%.1f", movie.voteAverage))
                }
                .font(.subheadline)
            }
        }
    }
}
