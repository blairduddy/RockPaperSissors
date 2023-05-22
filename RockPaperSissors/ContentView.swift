//
//  ContentView.swift
//  RockPaperSissors
//
//  Created by Blair Duddy on 2023-05-20.
//


// Each turn of the game, the app will randomly pick either rock, paper or scissors.
// Each turn, the app will alternate between prompting the player to win or lose.
// The player must then tap the corrrect move to win or lose the game.
// If they are correct, the score a point; otherwise they will lose a point.
// The game will end after 10 questoins, at which point their score is shown.




import SwiftUI

struct ContentView: View {
    
    @State private var appChoice = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random() //use toggle to swicth after rounds
    @State private var scoreTitle = ""
    @State private var userScore = 0
    @State private var presentScore = false
    @State private var questionNumber = 0
    
    
    @State private var moves = ["🪨", "🗞️", "✂️"]
    
    
    func selectionTapped(_ number: Int) {
        if questionNumber >= 10 {
            scoreTitle = "Game over! Your score is \(userScore)!"
            presentScore = true
        } else {
            let correctAnswer = (appChoice + (shouldWin ? 1 : 2) % 3)
            if number == correctAnswer {
                scoreTitle = "You win"
                userScore += 1
            } else {
                scoreTitle = "You Lose"
                userScore -= 1
            }
            presentScore = true
        }
        
    }
    
    
    func nextRound() {
        appChoice = Int.random(in: 0...2)
        shouldWin = Bool.random()
        questionNumber += 1
        presentScore = false
    }
    
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.green, .black]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                Text("Rock, Paper, Scissors!")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.primary)
                
                
                VStack(spacing: 15) {
                    VStack {
                     
                        Text("Computer has chosen \(moves[appChoice])")
                        Text(shouldWin ? "Your goal is to: Win" : "Your goal is to: Lose")
                        
                        VStack{
                            ForEach(0..<3) { number in
                                Button {
                                    selectionTapped(number)
                                } label: {
                                    Text(moves[number])
                                        .padding()
                                        .background(Capsule().fill(Color.white).frame(width: 200, height: 100))
                                        .font(.system(size: 75))
                                    
                                }
                            }
                            
                        }
                        Text("Score: \(userScore)")
                            .font(.title.bold())
                            .foregroundStyle(.secondary)
                        
                    }
                    //font
                    .padding()
                    .multilineTextAlignment(.center)
                    .font(.system(size: 25))
                    
                    //material/background
                    .frame(maxWidth: 300)
                    .padding(.vertical, 20)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                }
                .alert(isPresented: $presentScore){
                    Alert(title: Text(scoreTitle), dismissButton: .default(Text("Continue")) {
                        self.nextRound()
                    })
                }
            }
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
