//
//  RockPaperScissorsView.swift
//  RockPaperScissors
//
//  WHAT THIS GAME DOES NOW
//  You pick rock, paper or scissors. The computer picks one at random.
//  The app shows both moves and counts how many rounds you have played.
//  It can tell when a round is a tie.
//
//  WHAT IT DOES NOT DO YET
//  When the two moves are different, it only says "Someone won".
//  It does not know who!
//  Rock beats scissors, scissors beats paper, and paper beats rock.
//

import SwiftUI

// The picture for each move. These are emoji, so they are just text.
// TRY: Change these to other emoji to give the game a new theme.
let rockEmoji: String = "😈"
let paperEmoji: String = "👻"
let scissorsEmoji: String = "🎃"

// The game itself: what it remembers, what it shows on the screen,
// and what it does when you click a button.
struct RockPaperScissorsView: View {
    
    // MARK: - Stored properties
    
    // Each @State variable is something the game remembers.
    // When one of them changes, the screen updates by itself.
    
    // The name of each move, such as "Rock", and the emoji that shows it.
    // Before the first round, nobody has picked a move yet.
    @State var playerMove: String = "No move yet"
    @State var playerEmoji: String = "❓"
    @State var computerMove: String = "No move yet"
    @State var computerEmoji: String = "❓"
    
    // What happened in the last round.
    @State var result: String = "Do you dare play ?"
    
    // How many rounds have been played.
    @State var roundsPlayed: Int = 0
    @State var playerWins: Int = 0
    @State var computerWins: Int = 0
    @State var gameOver: Bool = false
    
    
    // MARK: - Computed properties
    
    
    var body: some View {
        VStack(spacing: 24) {
            
            // The title at the top of the screen.
            Text("Who is gone win Halloween")
                .font(.largeTitle)
                .bold()
                .foregroundStyle(Color.orange)
            // Shrink the title a little if it does not fit on one line.
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            
            Spacer()
            
            // The two moves, side by side.
            HStack {
                VStack(spacing: 8) {
                    Label("You", systemImage: "person.fill")
                        .font(.headline)
                    Text(playerEmoji)
                        .font(.system(size: 90))
                    Text(playerMove)
                        .font(.title3)
                }
                .frame(maxWidth: .infinity)
                
                Text("vs")
                    .font(.title)
                    .foregroundStyle(Color.orange)
                
                VStack(spacing: 8) {
                    Label("Computer", systemImage: "desktopcomputer")
                        .font(.headline)
                    Text(computerEmoji)
                        .font(.system(size: 90))
                    Text(computerMove)
                        .font(.title3)
                }
                .frame(maxWidth: .infinity)
            }
            .padding(.vertical)
            .background(Color.orange.opacity(0.15))
            .clipShape(RoundedRectangle(cornerRadius: 24))
            
            // The result of the round.
            Text(result)
                .font(.largeTitle)
                .bold()
            
            Spacer()
            
            // One button for each move the player can make.
            // The code inside the braces runs when that button is clicked.
            Text("Choose your move")
                .font(.headline)
                .foregroundStyle(Color.orange)
            
            HStack(spacing: 12) {
                Button {
                    chooseRock()
                } label: {
                    VStack {
                        Text(rockEmoji)
                            .font(.system(size: 44))
                        Text("Devil")
                    }
                    .frame(maxWidth: .infinity)
                }
                .disabled(gameOver)
                Button {
                    choosePaper()
                } label: {
                    VStack {
                        Text(paperEmoji)
                            .font(.system(size: 44))
                        Text("Ghost")
                    }
                    .frame(maxWidth: .infinity)
                }
                .disabled(gameOver)
                Button {
                    chooseScissors()
                } label: {
                    VStack {
                        Text(scissorsEmoji)
                            .font(.system(size: 44))
                        Text("Pumpkin")
                    }
                    .frame(maxWidth: .infinity)
                }
                .disabled(gameOver)
            }
            
            .buttonStyle(.bordered)
            .font(.headline)
            // TRY: Change teal to another colour. Change it in the title and the moves box too.
            .tint(Color.orange)
            
            if gameOver {
                Button("Play Again") {
                    roundsPlayed = 0
                    playerWins = 0
                    computerWins = 0
                    gameOver = false
                    
                    playerMove = "No move yet"
                    playerEmoji = "❓"
                    computerMove = "No move yet"
                    computerEmoji = "❓"
                    
                    result = "Choose your move!"
                }
                .buttonStyle(.borderedProminent)
                .tint(Color.orange)
            }
            
            
            Text("Rounds played: \(roundsPlayed)/3")
                .font(.headline)
                .foregroundStyle(Color.orange)
            
            Text("You: \(playerWins)  |  Computer: \(computerWins)")
                .font(.headline)
                .foregroundStyle(Color.orange)
            
            
        }
        .padding(32)
        .fontDesign(.rounded)
        // How big the game's window is on the Mac. It can be made taller or wider.
        .frame(minWidth: 520, minHeight: 640)
    }
    
    
    // MARK: - Functions
    
    // The player picked rock.
    func chooseRock() {
        playerMove = "Rock"
        playerEmoji = rockEmoji
        playRound()
    }


    // The player picked paper.
    func choosePaper() {
        playerMove = "Paper"
        playerEmoji = paperEmoji
        playRound()
    }


    // The player picked scissors.
    func chooseScissors() {
        playerMove = "Scissors"
        playerEmoji = scissorsEmoji
        playRound()
    }


    // The computer picks its move at random.
    func chooseComputerMove() {
        
        // Pick 1, 2 or 3. Each number stands for one move.
        let randomNumber: Int = Int.random(in: 1...3)
        
        if randomNumber == 1 {
            computerMove = "Rock"
            computerEmoji = rockEmoji
        } else if randomNumber == 2 {
            computerMove = "Paper"
            computerEmoji = paperEmoji
        } else {
            computerMove = "Scissors"
            computerEmoji = scissorsEmoji
        }
    }
    
            // Play one round: the computer picks, then we decide who won.
                func playRound() {
                    guard !gameOver else { return }

                    chooseComputerMove()
                    roundsPlayed += 1

                    if playerMove == computerMove {
                        result = "It's a tie!"
                    } else if
                        (playerMove == "Rock" && computerMove == "Scissors") ||
                        (playerMove == "Paper" && computerMove == "Rock") ||
                        (playerMove == "Scissors" && computerMove == "Paper") {

                        result = "You won this round!"
                        playerWins += 1
                    } else {
                        result = "The computer won this round!"
                        computerWins += 1
                    }

                    if roundsPlayed == 3 {
                        gameOver = true

                        if playerWins > computerWins {
                            result = "You win Halloween and are the ruler!"
                        } else if computerWins > playerWins {
                            result = "The computer is now the new ruler of Halloween!"
                        } else {
                            result = "The game ends in a tie!"
                        }
                    }
                }
           
        }
        
    

        



#Preview {
    RockPaperScissorsView()
}

