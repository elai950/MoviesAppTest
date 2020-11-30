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
    
    @Namespace private var namespace
    @State private var scaleImage = false
    
    var body: some View {
        ZStack{
            GeometryReader{ geo in
                ScrollView{
                    VStack(alignment: .center, spacing: 8){
                        
                        VStack(alignment: .center, spacing: 2){
                            Text("Tap to scale")
                                .font(.footnote)
                                .foregroundColor(.secondary)
                            
                            ImageLoader(url: URL(string: "https://image.tmdb.org/t/p/w500/\(movie.posterPath ?? "")"), size: UIScreen.main.bounds.width.magnitudeSquared)
                                .matchedGeometryEffect(id: "\(movie.id)", in: namespace)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 250, alignment: .center)
                                .cornerRadius(20)
                                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)
                                .compositingGroup()
                                .onTapGesture(perform: {
                                    withAnimation(.spring()){
                                        scaleImage.toggle()
                                    }
                                })
                        }
                        .padding(.vertical)
                        
                        //Details about the movie (overview, votes, etc).
                        MovieInfoBox(movie: movie)
                    }
                    .padding(.bottom, 32)
                    
                }
                .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                .isEmpty(scaleImage)
            }
            .navigationBarTitle(movie.title, displayMode: .automatic)
            .background(Color(UIColor.systemGroupedBackground))
            .edgesIgnoringSafeArea(.bottom)
            
            ZStack{
                Color.black
                    .isEmpty(!scaleImage)
                ImageLoader(url: URL(string: "https://image.tmdb.org/t/p/w500/\(movie.posterPath ?? "")"), size: UIScreen.main.bounds.width.magnitudeSquared)
                    .matchedGeometryEffect(id: "\(movie.id)", in: namespace)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width, alignment: .center)
                    .compositingGroup()
                    .onTapGesture(perform: {
                        withAnimation(.spring()){
                            scaleImage.toggle()
                        }
                    })
                    .isEmpty(!scaleImage)
            }
            .edgesIgnoringSafeArea(.bottom)
        }
    }
}
