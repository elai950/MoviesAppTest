//
//  ScoreCircle.swift
//  test8200ac
//
//  Created by אילי זוברמן on 30/11/2020.
//

import SwiftUI

struct ScoreCircle: View {
    
    var progress: Float
    let size: CGFloat
    
    init(progress: Float, size: CGFloat = 75){
        self.progress = progress
        self.size = size
    }
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: size * 0.04)
                .opacity(0.3)
                .foregroundColor(progressColor())
                .padding(size * 0.08)
                .background(Color.black.opacity(0.85))
                .clipShape(Circle())
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: size * 0.04, lineCap: .round, lineJoin: .round))
                .foregroundColor(progressColor())
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear)
                .padding(size * 0.08)
            
            Text(String(format: "%.0f%%", min(self.progress, 1.0)*100.0))
                .font(.system(size: (size / 4), weight: .bold, design: .rounded))
                .foregroundColor(.white)
        }
        .frame(width: size, height: size, alignment: .center)
        .padding(5)
    }
    
    private func progressColor() -> Color{
        if progress >= 0.7{
            return Color.green
        }else if progress >= 0.3 && progress <= 0.7{
            return Color.orange
        }else{
            return Color.red
        }
    }
}

struct ScoreCircle_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            ScoreCircle(progress: 0.71, size: 30)
            ScoreCircle(progress: 0.53, size: 30)
            ScoreCircle(progress: 0.25, size: 30)
        }
    }
}
