//
//  ContentView.swift
//  studyApp
//
//  Created by Harry Lewandowski on 9/11/2023.
//  NOTE 08/12/2023 @ 11:31am: this app might actually turn out to be good

import SwiftUI
import SPConfetti

var question = "Question not loaded."
var correctAnswer = "Answer not loaded." // Always the correct answer
var answer2 = "Answer not loaded. -- ID1"
var answer3 = "Answer not loaded. -- ID2"
var answer4 = "Answer not loaded. -- ID3"

let questionDict = [
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

func retrieveContent() {
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
                    .onAppear() {
                        showMultipleChoice = false
                        showFlashCard = false
                    }
                
                Menu {
                    Button(action: {showMultipleChoice = true}) {
                        Label("Multiple Choice", systemImage: "list.bullet")
                    }
                    Button(action: {showFlashCard = true}) {
                        Label("Flash Cards", systemImage: "menucard.fill")
                    }
                } label: {
                    mainButton(imageName: "play.fill", text: "Start")
                }
                .padding(.bottom, 20)
                .navigationDestination(isPresented: $showMultipleChoice) {
                    multipleChoiceView()
                }
                .navigationDestination(isPresented: $showFlashCard) {
                    flashCardView()
                }
                
                
                NavigationLink(destination: remindersView()) {
                    secondaryButton(imageName: "bell.fill", text: "Reminders")
                }
                
                Menu {
                    Text("English")
                    Text("French")
                    Text("Spanish")
                } label: {
                    secondaryButton(imageName: "bubble.fill", text: "Language")
                }
                
                NavigationLink(destination: settingsView()) {
                    secondaryButton(imageName: "gearshape.fill", text: "More Settings")
                }
                
                Spacer()
            }
            .alert(isPresented: $showNonAvailable, content: {
                Alert(
                    title: Text("Coming soon!"),
                    message: Text("The \(nonAvailableUserText) study type is currently unavailable."),
                    dismissButton: .default(Text("ok :("))
                )
            })
            .navigationTitle("studyApp")
            .padding()
        }
    }
}


struct mainButton: View {
    var imageName: String
    var text: String
    
    var body: some View {
        HStack {
            Image(systemName: imageName)
                .foregroundColor(.white)
            
            Text(text)
                .font(.title)
                .fontWeight(.semibold)
                .foregroundColor(.white)
        }
        .frame(width: 300, height: 100)
        .background(Color.blue)
        .cornerRadius(20.0)
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
        alertTitle = "wrong 💀"
        alertText = "you got it wrong 💀💀💀"
        showAlert = true
        streak = 0
    }
    
    @State var randAnswerOrder = [correctAnswer, answer2, answer3, answer4]
    @State var alertTitle = ""
    @State var alertText = ""
    @State var streak = 0
    @State private var showAlert = false
    @State private var confettiPresent = false
    
    var body: some View {
        NavigationStack {
            Spacer()
            VStack {
                Text("Answer Streak")
                    .fontWeight(.semibold)
                Text("\(streak)")
                    .fontWeight(.bold)
            }
            Spacer()
            Text("\(question)")
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
                    title: Text("\(alertTitle)"),
                    message: Text("\(alertText)"),
                    dismissButton: .default(Text("dismiss"))
                )
            }
            Spacer()
                .navigationTitle("Multiple Choice")
                .onAppear() {
                    shuffleAnswers()
                }
        }
    }
}

struct remindersView: View {
    var body: some View {
        Text("hello world! this is the reminders view")
    }
}

struct settingsView: View {
    var body: some View {
            Text("hello!")
            .navigationTitle("More Settings")
        }
    }

struct flashCardView: View {
    @State private var flashCardContent = ""
    
    func initFlashCard() {
        flashCardContent = "\(question)"
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
                
                Button("Flip") {
                    flashCardContent = "\(correctAnswer)"
                }
                
                Spacer()
                
            }.onAppear() {
                initFlashCard()
            }
            
        }.navigationTitle("Flash Cards")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
