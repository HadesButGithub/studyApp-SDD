//
//  ContentView.swift
//  studyApp
//
//  Created by Harry Lewandowski on 9/11/2023.
//  NOTE 08/12/2023 @ 11:31am: this app might actually turn out to be good

// Imports libraries for user interface development, confetti effects, and base layer functionality.
import SwiftUI
import SPConfetti
import Foundation

// Establishes dictionary for study set in English
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

// Establishes dictionary for study set in French
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

// Establishes dictionary for study set in Spanish
let questionDictES = [
    "¿Cuál es el propósito de un diagrama de contexto?": "Ilustrar los límites del sistema y las interacciones con entidades externas.",
    "¿Qué es el software de código abierto?": "Software cuyo código fuente está disponible libremente para que cualquier persona lo vea, modifique y distribuya.",
    "¿Qué es el dominio público?": "Obra que ya no está protegida por derechos de autor y puede ser utilizada, copiada y distribuida libremente por cualquier persona.",
    "¿Qué es el software de prueba?": "Software que se distribuye de forma gratuita y permite a los usuarios evaluarlo antes de comprar la versión completa.",
    "¿Qué es el software comercial?": "Software que se crea y se vende con fines de lucro.",
    "¿Qué son las licencias de sitio?": "Acuerdos que permiten a las organizaciones usar software en varios equipos o dispositivos dentro de una ubicación o sitio específico.",
    "¿Qué es la protección de copia del disco?": "Método utilizado para evitar la copia o duplicación no autorizada de software.",
    "¿Qué es el Desarrollo Rápido de Aplicaciones?": "Metodología de desarrollo de software que enfatiza ciclos de desarrollo iterativos y rápidos.",
    "¿Qué es el enfoque de desarrollo estructurado?": "Un proceso sistemático de desarrollo de software que divide el proyecto en fases o etapas distintas.",
    "¿Qué es el enfoque del usuario final?": "Enfoque utilizado para proyectos de pequeña escala en los que el usuario, con un presupuesto limitado, desarrolla rápidamente el producto.",
    "¿Qué es el enfoque ágil?": "Una metodología de desarrollo de software iterativa y flexible que enfatiza la colaboración y la adaptabilidad."
]


// Establishes variables for the question, correct answer, and 3 other random questions.
var question = "questionNonLoad"
var correctAnswer = "answerNonLoad1" // Always the correct answer
var answer2 = "answerNonLoad2"
var answer3 = "answerNonLoad3"
var answer4 = "answerNonLoad4"

// Function to retrieve random question, correct answer, and 3 random answers
func retrieveContent() {
    var questionDict = questionDictEN // Sets questionDict to questionDictEN by default
    
    if Locale.preferredLanguages.first?.starts(with: "fr") == true {
        questionDict = questionDictFR // Uses French dictionary if system language set to French
    } else if Locale.preferredLanguages.first?.starts(with: "es") == true {
        questionDict = questionDictES // Uses Spanish dictionary if system language is Spanish
    }
    
    let keys = Array(questionDict.keys) // Establishes keys variable to an Array of all keys from questionDict
    let values = Array(questionDict.values) // Does same for values
    
    let randomIndex = Int.random(in: 0..<keys.count) // Gets a random number from 1 to the last number in the dictionary
    question = keys[randomIndex] // Sets question var to randomly selected key from dictionary
    correctAnswer = values[randomIndex] // Sets correctAnswer var to correlating answer
    
    for i in 0..<3 { // Gets 3 random answers and sets them to answer2, 3, and 4
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
    var body: some View {
        NavigationStack {
            VStack { // Creates a stack of vertically aligned elements
                Spacer() // Spaces out UI elements

                // Button that navigates to multipleChoiceView()
                NavigationLink(destination: multipleChoiceView()) {
                    HStack {
                        Image(systemName: "list.bullet")
                            .foregroundColor(.white)
                        
                        Text("multiChoice") // String for localisation, appears differently based on system language
                            .font(.title) // Text modifiers
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
                    .onAppear() {
                        retrieveContent() // Runs the retrieveContent() function when the multiple choice button is visible on screen
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
                    .frame(width: 300, height: 100)
                    .background(Color.blue)
                    .cornerRadius(20.0)
                }
                
                Spacer()
            }
            .navigationTitle("studyApp") // Adds studyApp title to homepage
        }
    }
}

// Establishes template for multiple choice answer buttons
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
    @State var randAnswerOrder = [correctAnswer, answer2, answer3, answer4] // Creates array used for button shuffling
    @State var alertTitle = LocalizedStringKey("") // Creates alert variables for incorrect answers
    @State var alertText = LocalizedStringKey("")
    @State var streak = 0 // Adds answer streak counter
    @State private var showAlert = false // When true, shows alert
    @State private var confettiPresent = false // When true, shows confetti
    
    // Shuffles the multiple choice buttons
    func shuffleAnswers() {
        self.randAnswerOrder = [correctAnswer, answer2, answer3, answer4]
        randAnswerOrder.shuffle()
    }
    
    // Function when answer is correct
    func answerCorrect() {
        retrieveContent() // Gets new question and answer set
        shuffleAnswers() // Shuffles the buttons
        confettiPresent = true // Displays confetti
        streak += 1 // Adds 1 to the answer streak
    }
    
    func answerIncorrect() {
        alertTitle = LocalizedStringKey("wrong") // Sets variables for alert content
        alertText = LocalizedStringKey("wrongDetailed")
        showAlert = true // Displays alert
        streak = 0 // Resets answer streak
    }
    

    
    var body: some View {
        NavigationStack {
            Spacer()
            VStack { // Displays high score label and streak
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
