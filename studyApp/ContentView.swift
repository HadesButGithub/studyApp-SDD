//
//  ContentView.swift
//  studyApp
//
//  Created by Harry Lewandowski on 9/11/2023.
//

import SwiftUI

var currentStudyType = ""
var question = "Question not loaded."
var correctAnswer = "Answer not loaded." // Always the correct answer
var answer2 = "Answer not loaded. -- ID1"
var answer3 = "Answer not loaded. -- ID2"
var answer4 = "Answer not loaded. -- ID3"

let questionDict = [
    "What is the purpose of a context diagram?": "Answer related to context diagrams",
    "Test question2": "Test answer2",
    "Test question3": "Test answer3",
    "Test question4": "Test answer4",
    "Test question5": "Test answer5",
    "Test question6": "Test answer6",
    "Test question7": "Test answer7",
    "Test question8": "Test answer8",
    "Test question9": "Test answer9"
]

func retrieveContent() {
    let keys = Array(questionDict.keys)
    let values = Array(questionDict.values)
    
    let randomIndex = Int.random(in: 0..<keys.count)
    question = keys[randomIndex]
    correctAnswer = values[randomIndex]
    
    // finish logic for getting random answers
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                NavigationLink(destination: multipleChoiceView()) {
                    mainButton(imageName: "play.fill", text: "Start")
                }
                .padding(.bottom, 20)
                
                Menu {
                    Button(action: {currentStudyType = "flashCard"}) {
                        Label("Flash Cards", systemImage: "menucard.fill")
                    }
                    Button(action: {currentStudyType = "multipleChoice"}) {
                        Label("Multiple Choice", systemImage: "list.bullet")
                    }
                } label: {
                    secondaryButton(imageName: "book.fill", text: "Study Types")
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
                
                Spacer()
            }
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
                .font(.title3)
                .fontWeight(.medium)
                .foregroundColor(.white)
        }
        .frame(width: 250, height: 60)
        .background(Color.blue)
        .cornerRadius(20.0)
    }
}

struct multipleChoiceView: View {
    
    func shuffleAnswers() {
        self.randAnswerOrder = [correctAnswer, answer2, answer3, answer4]
        randAnswerOrder.shuffle()
    }
    
    @State var randAnswerOrder = [correctAnswer, answer2, answer3, answer4]
    var body: some View {
        Spacer()
        Text("\(question)")
            .font(.largeTitle)
            .fontWeight(.regular)
            .multilineTextAlignment(.center)
        Spacer()
        VStack {
            Button {
                // add action
            } label: {
                multipleChoiceButton(text: "\(randAnswerOrder[0])")
            }
            Button {
                // add action
            } label: {
                multipleChoiceButton(text: "\(randAnswerOrder[1])")
            }
            Button {
                // add action
            } label: {
                multipleChoiceButton(text: "\(randAnswerOrder[2])")
            }
            Button {
                // add action
            } label: {
                multipleChoiceButton(text: "\(randAnswerOrder[3])")
            }
        }
        Spacer()
            .navigationTitle("Multiple Choice")
            .onAppear() {
                shuffleAnswers()
            }
    }
}

struct remindersView: View {
    var body: some View {
        Text("hello world! this is the reminders view")
    }
}

struct flashCardView: View {
    var body: some View {
        Text("hello world! this is the flash card view")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
