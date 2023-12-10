//
//  ContentView.swift
//  studyApp
//
//  Created by Harry Lewandowski on 9/11/2023.
//  NOTE 08/12/2023 @ 11:31am: this app might actually turn out to be good

import SwiftUI
import SPConfetti
import Foundation

let questionDictEN = [
    "What is the purpose of a context diagram?": "To illustrate the system boundaries and interactions with external entities.",
    "What is open source software?": "Software with source code that is freely available for anyone to view, modify, and distribute.",
    "What is public domain?": "Work that is no longer protected by copyright and can be freely used, copied, and distributed by anyone.",
    "What is shareware software?": "Software that is typically distributed for free, allowing users to evaluate it before purchasing the full version.",
    "What is commercial software?": "Software that is created and sold for profit.",
    "What are site licenses?": "Agreements that allow organisations to use software across multiple computers or devices within a specific location or site.",
    "What is disk copy protection?": "Method used to prevent unauthorized copying or duplication of software.",
    "What is Rapid Approach Development?": "Software development methodology that emphasizes iterative and fast-paced development cycles.",
    "What is the Structured development approach?": "A systematic software development process that breaks down the project into distinct phases or stages.",
    "What is the End User approach?": "Approach used for small-scale projects where the user with a limited budget quickly develops the product.",
    "What is the Agile approach?": "An iterative and flexible software development methodology that emphasizes collaboration and adaptability"
]

let questionDictFR = [
    "Quel est le but d'un diagramme de contexte ?": "Illustrer les limites du système et les interactions avec des entités externes.",
    "Qu'est-ce que le logiciel open source ?": "Un logiciel dont le code source est librement disponible pour que chacun puisse le consulter, le modifier et le distribuer.",
    "Qu'est-ce que le domaine public ?": "Un travail qui n'est plus protégé par le droit d'auteur et peut être librement utilisé, copié et distribué par tous.",
    "Qu'est-ce que le logiciel shareware ?": "Un logiciel distribué gratuitement, permettant aux utilisateurs de l'évaluer avant d'acheter la version complète.",
    "Qu'est-ce que le logiciel commercial ?": "Un logiciel créé et vendu à des fins lucratives.",
    "Qu'est-ce que les licences de site ?": "Des accords qui permettent aux organisations d'utiliser un logiciel sur plusieurs ordinateurs ou appareils au sein d'un emplacement ou site spécifique.",
    "Qu'est-ce que la protection contre la copie de disque ?": "Une méthode utilisée pour empêcher la copie ou la duplication non autorisée de logiciels.",
    "Qu'est-ce que le développement à approche rapide ?": "Une méthodologie de développement de logiciels qui met l'accent sur des cycles de développement itératifs et rapides.",
    "Qu'est-ce que l'approche de développement structuré ?": "Un processus systématique de développement de logiciels qui découpe le projet en phases ou étapes distinctes.",
    "Qu'est-ce que l'approche utilisateur final ?": "Une approche utilisée pour des projets de petite envergure où l'utilisateur avec un budget limité développe rapidement le produit.",
    "Qu'est-ce que l'approche agile ?": "Une méthodologie itérative et flexible de développement de logiciels qui met l'accent sur la collaboration et l'adaptabilité."
]


var question = "questionNonLoad"
var correctAnswer = "answerNonLoad1" // Always the correct answer
var answer2 = "answerNonLoad2"
var answer3 = "answerNonLoad3"
var answer4 = "answerNonLoad4"

func retrieveContent() {
    var questionDict = questionDictEN
    
    if Locale.preferredLanguages.first?.starts(with: "fr") == true {
        questionDict = questionDictFR
    }
    
    let keys = Array(questionDict.keys)
    let values = Array(questionDict.values)
    
    let randomIndex = Int.random(in: 0..<keys.count)
    question = keys[randomIndex]
    correctAnswer = values[randomIndex]
    
    for i in 0..<3 {
        let randomAnswer = Int.random(in: 0..<values.count)
        switch i {
        case 0:
            answer2 = values[randomAnswer]
        case 1:
            answer3 = values[randomAnswer]
        case 2:
            answer4 = values[randomAnswer]
        default:
            break
        }
    }

}

struct ContentView: View {
    @State private var showMultipleChoice = false
    @State private var showFlashCard = false
    @State private var showNonAvailable = false
    @State var nonAvailableUserText = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()

                NavigationLink(destination: multipleChoiceView()) {
                    HStack {
                        Image(systemName: "list.bullet")
                            .foregroundColor(.white)
                        
                        Text("multiChoice")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
                    .onAppear() {
                        retrieveContent()
                    }
                    .frame(width: 300, height: 100)
                    .background(Color.blue)
                    .cornerRadius(20.0)
                }
                
                NavigationLink(destination: flashCardView()) {
                    HStack {
                        Image(systemName: "menucard.fill")
                            .foregroundColor(.white)
                        
                        Text("flashCard")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
                    .onAppear() {
                        retrieveContent()
                    }
                    .frame(width: 300, height: 100)
                    .background(Color.blue)
                    .cornerRadius(20.0)
                }
                
                Spacer()
            }
            .navigationTitle("studyApp")
            .padding()
        }
    }
}

struct secondaryButton: View {
    var imageName: String
    var text: String
    
    var body: some View {
        HStack {
            Image(systemName: imageName)
                .foregroundColor(.white)
            
            Text(text)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.white)
        }
        .onAppear() {
            retrieveContent()
        }
        .frame(width: 250, height: 75)
        .background(Color.blue)
        .cornerRadius(20.0)
    }
}

struct multipleChoiceButton: View {
    var text: String
    
    var body: some View {
        HStack {
            Text(text)
                .font(.body)
                .fontWeight(.medium)
                .foregroundColor(.white)
                .padding(10.0)
        }
        .frame(width: 370, height: 95)
        .background(Color.blue)
        .cornerRadius(20.0)
    }
}

struct multipleChoiceView: View {
    
    func shuffleAnswers() {
        self.randAnswerOrder = [correctAnswer, answer2, answer3, answer4]
        randAnswerOrder.shuffle()
    }
    
    func answerCorrect() {
        retrieveContent()
        shuffleAnswers()
        confettiPresent = true
        streak += 1
    }
    
    func answerIncorrect() {
        alertTitle = LocalizedStringKey("wrong")
        alertText = LocalizedStringKey("wrongDetailed")
        showAlert = true
        streak = 0
    }
    
    @State var randAnswerOrder = [correctAnswer, answer2, answer3, answer4]
    @State var alertTitle = LocalizedStringKey("")
    @State var alertText = LocalizedStringKey("")
    @State var streak = 0
    @State private var showAlert = false
    @State private var confettiPresent = false
    @State private var shakeAnim = false
    
    var body: some View {
        NavigationStack {
            Spacer()
            VStack {
                Text("highScore")
                    .fontWeight(.semibold)
                Text("\(streak)")
                    .fontWeight(.bold)
            }
            Spacer()
            Text(question)
                .font(.largeTitle)
                .fontWeight(.regular)
                .multilineTextAlignment(.center)
            Spacer()
            VStack {
                Button {
                    if randAnswerOrder[0] == correctAnswer {
                        answerCorrect()
                    } else {
                        answerIncorrect()
                    }
                } label: {
                    multipleChoiceButton(text: "\(randAnswerOrder[0])")
                }
                .confetti(isPresented: $confettiPresent,
                                      animation: .fullWidthToDown,
                                      particles: [.triangle, .arc],
                                      duration: 0.5)
                .confettiParticle(\.velocity, 800)
                
                Button {
                    if randAnswerOrder[1] == correctAnswer {
                        answerCorrect()
                    } else {
                        answerIncorrect()
                    }
                } label: {
                    multipleChoiceButton(text: "\(randAnswerOrder[1])")
                }
                .confetti(isPresented: $confettiPresent,
                                      animation: .fullWidthToDown,
                                      particles: [.triangle, .arc],
                                      duration: 0.5)
                .confettiParticle(\.velocity, 800)
                
                Button {
                    if randAnswerOrder[2] == correctAnswer {
                        answerCorrect()
                    } else {
                        answerIncorrect()
                    }
                } label: {
                    multipleChoiceButton(text: "\(randAnswerOrder[2])")
                }
                .confetti(isPresented: $confettiPresent,
                                      animation: .fullWidthToDown,
                                      particles: [.triangle, .arc],
                                      duration: 0.5)
                .confettiParticle(\.velocity, 800)
                
                Button {
                    if randAnswerOrder[3] == correctAnswer {
                        answerCorrect()
                    } else {
                        answerIncorrect()
                    }
                } label: {
                    multipleChoiceButton(text: "\(randAnswerOrder[3])")
                }
                .confetti(isPresented: $confettiPresent,
                                      animation: .fullWidthToDown,
                                      particles: [.triangle, .arc],
                                      duration: 0.5)
                .confettiParticle(\.velocity, 800)
                
            }
            .alert(isPresented: $showAlert){
                Alert(
                    title: Text(alertTitle),
                    message: Text(alertText),
                    dismissButton: .default(Text("dismiss"))
                )
            }
            Spacer()
                .navigationTitle("multiChoice")
                .onAppear() {
                    shuffleAnswers()
                }
        }
    }
}

struct flashCardView: View {
    @State private var flashCardContent = ""
    @State private var buttonContent = LocalizedStringKey("flashcardFlip")
    @State private var cardFlipped = false
    @State private var cardsStudied = 0
    
    func initFlashCard() {
        flashCardContent = "\(question)"
    }
    
    
    func flipOrNewCard() {
        if cardFlipped == false {
            flashCardContent = "\(correctAnswer)"
            buttonContent = LocalizedStringKey("flashcardNext")
            cardFlipped = true
            cardsStudied += 1
        } else {
            retrieveContent()
            flashCardContent = "\(question)"
            cardFlipped = false
            buttonContent = LocalizedStringKey("flashcardFlip")
        }
        
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                Text("\(flashCardContent)")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Spacer()
                
                Button(buttonContent) {
                    flipOrNewCard()
                }.buttonStyle(.bordered)
                
                Spacer()
                
                VStack {
                    Text("cardHighScore")
                        .fontWeight(.semibold)
                    Text("\(cardsStudied)")
                        .fontWeight(.bold)
                }
                
                Spacer()
                
            }.onAppear() {
                initFlashCard()
            }
            
        }.navigationTitle("flashCard")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        flashCardView()
    }
}
