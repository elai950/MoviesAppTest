//
//  ContentView.swift
//  Shared
//
//  Created by אילי זוברמן on 29/11/2020.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var moviesViewModel = MoviesViewModel()
    
    @State private var selectedSegment = 0

    private let column = [
        GridItem(.flexible(minimum: 75, maximum: 200), spacing: 8),
        GridItem(.flexible(minimum: 75, maximum: 200), spacing: 8),
        GridItem(.flexible(minimum: 75, maximum: 200), spacing: 8)
    ]
    
    var body: some View {
        
        ZStack{
            VStack(spacing: 16){
                Spacer(minLength: 40)
                HStack{
                    Text("Movies")
                        .bold()
                        .font(.system(.largeTitle, design: .rounded))
                    Spacer()
                    NavigationLink(destination: SearchMovieView(moviesViewModel: moviesViewModel), label: {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 40, height: 40, alignment: .center)
                            .overlay(
                                Image(systemName: "magnifyingglass")
                                    .renderingMode(.template)
                                    .imageScale(.medium)
                            )
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0.0, y: 5)
                    })
                }
                .padding(.horizontal)
                
                ScrollAnimation(title: "Popular", movies: moviesViewModel.popularMovies)
                
                ScrollAnimation(title: "Top Rated", movies: moviesViewModel.topratedMovies)
            }
        }
        .background(Color(UIColor.systemGroupedBackground))
        .edgesIgnoringSafeArea(.vertical)
        .navigationTitle("Movies")
        .navigationBarHidden(true)
        .toolbar(content: {
            ToolbarItem(placement: .principal, content: {
                Picker("", selection: $selectedSegment.animation(.spring()), content: {
                    Text("Popular")
                        .tag(0)
                    Text("Most Rated")
                        .tag(1)
                })
                .labelsHidden()
            })
            
            ToolbarItem(placement: .navigationBarTrailing, content: {
                NavigationLink(destination: SearchMovieView(moviesViewModel: moviesViewModel), label: {
                    Image(systemName: "magnifyingglass")
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 25)
                })
            })
        })
    }
}
