//
//  PosterCell.swift
//  test8200ac
//
//  Created by אילי זוברמן on 30/11/2020.
//

import SwiftUI

struct PosterCell: View{
        
    let movie: Movie
    @Namespace private var animation

    var body: some View{
        ZStack(alignment: .bottomLeading){
            ImageLoader(url: URL(string: "https://image.tmdb.org/t/p/w500/\(movie.posterPath ?? "")"), size: 150)
                .aspectRatio(contentMode: .fit)
                .frame(width: 100)
                .cornerRadius(15)
                .compositingGroup()
            ScoreCircle(progress: Float(movie.voteAverage / 10), size: 35)
        }
    }
}

struct PosterCellLarge: View{
        
    let movie: Movie
    @Namespace private var animation

    var body: some View{
        ZStack(alignment: .bottomLeading){
            ImageLoader(url: URL(string: "https://image.tmdb.org/t/p/w500/\(movie.posterPath ?? "")"), size: 200)
                .aspectRatio(contentMode: .fit)
                .cornerRadius(15)
                .compositingGroup()
            ScoreCircle(progress: Float(movie.voteAverage / 10), size: 50)
        }
    }
}
