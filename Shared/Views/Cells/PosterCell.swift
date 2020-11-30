//
//  PosterCell.swift
//  test8200ac
//
//  Created by אילי זוברמן on 30/11/2020.
//

import SwiftUI

struct PosterCell: View{
        
    let movie: Movie
    
    var body: some View{
        ImageLoader(url: URL(string: "https://image.tmdb.org/t/p/w500/\(movie.posterPath ?? "")"), size: 100)
            .frame(width: 100, height: 100*1.5)
            .aspectRatio(contentMode: .fill)
            .cornerRadius(15)
            .compositingGroup()
    }
}
