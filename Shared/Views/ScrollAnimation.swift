//
//  ScrollAnimation.swift
//  test8200ac
//
//  Created by אילי זוברמן on 01/12/2020.
//

import SwiftUI

struct ScrollAnimation: View {
    
    let title: String
    let movies: [Movie]
    
    var body: some View {
        VStack(spacing: 0){
            
            HStack{
                Text(title)
                    .bold()
                    .font(.system(.title3, design: .rounded))
                Spacer()
            }
            .padding(.leading)
            
            ScrollView(.horizontal, showsIndicators: false){
                HStack(spacing: 20){
                    ForEach(movies){ movie in
                        
                        GeometryReader{ geo in
                            NavigationLink(destination: MovieDetails(movie: movie)) {
                                PosterCellLarge(movie: movie)
                            }
                            .rotation3DEffect(
                                Angle(degrees: Double(geo.frame(in: .global).minX - 32) / -20),
                                axis: (x: 0.0, y: 10.0, z: 0.0))
                        }
                        .frame(width: UIScreen.main.bounds.width - 64*3, height: 300)
                    }
                }
                .padding(.horizontal, 32)
                .padding(.top)
                
                Spacer()
            }
        }
    }
}
