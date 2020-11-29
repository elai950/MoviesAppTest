//
//  MovieDetails.swift
//  test8200ac
//
//  Created by אילי זוברמן on 29/11/2020.
//

import SwiftUI
import struct Kingfisher.KFImage

struct MovieDetails: View {
    
    let movie: Movie
    
    var body: some View {
        GeometryReader{ geo in
            VStack(alignment: .center, spacing: 8){
                KFImage(URL(string: "https://image.tmdb.org/t/p/w500/\(movie.posterPath ?? "")"))
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: 300, height: 450,alignment: .center)
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(20)
                    .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 10)
                    .compositingGroup()
                    .padding(.vertical)
                
                Text("Vote Count: \(movie.voteCount)")
                    .font(.headline)
                Text("Release Date: \(movie.releaseDate)")
                    .font(.headline)
                
                Spacer()
            }
            .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
        }
        .navigationTitle(movie.title)
        .background(Color(UIColor.systemGroupedBackground))
        .edgesIgnoringSafeArea(.bottom)
    }
}
