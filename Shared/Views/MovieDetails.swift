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
            ScrollView{
                VStack(alignment: .center, spacing: 8){
                    ImageLoader(url: URL(string: "https://image.tmdb.org/t/p/w500/\(movie.posterPath ?? "")"), size: 300)
                        .frame(width: geo.size.width / 1.5, height: geo.size.height * 0.55, alignment: .center)
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(20)
                        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
                        .compositingGroup()
                        .padding(.vertical)
                    
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
                    
                    Spacer()
                }
                .padding(.bottom)
            }
            .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
        }
        .navigationTitle(movie.title)
        .background(Color(UIColor.systemGroupedBackground))
        .edgesIgnoringSafeArea(.bottom)
    }
}
