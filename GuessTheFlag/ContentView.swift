//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Damian on 09/05/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var showScore = false
    @State private var scoreTitle = ""
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "US"].shuffled()
    
    @State private var score: Int = 0
    @State private var correctAnswer = Int.random(in: 0...2)
    
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.5, green: 0.9, blue: 0.5), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 1500)
                .ignoresSafeArea()
                
         
                VStack(spacing: 40){
                    // Header on the top _______________________
                    VStack {
                        Text("Tap the flag of")
                            .fontWeight(.thin)
                            .font(.title2)
                            .foregroundColor(.primary)
                            .shadow(radius: 4)
                        Text(countries[correctAnswer])
                        .fontWeight(.bold)
                        .font(.system(size: 50))
                        .foregroundColor(.primary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(.regularMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(radius: 25)
                    
                    // Flags _________________________________
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .shadow(color: .black, radius: 6, x: 0, y: 0)
                        }
                    }
                    
                    // Score ______________________________
                    VStack{
                        Text("Score")
                            .fontWeight(.bold)
                            .font(.system(size: 30))
                        Text(score, format: .number)
                            .fontWeight(.bold)
                            .font(.system(size: 45))
                    }
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong"
            score = 0
        }
        showScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
