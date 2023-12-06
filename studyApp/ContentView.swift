//
//  ContentView.swift
//  studyApp
//
//  Created by Harry Lewandowski on 9/11/2023.
//

import SwiftUI

var studyType = ""
var question = "Question not loaded."

let questionDict = [
    "Test Q1": "Test answer1",
    "Test question2": "Test answer2",
    "Test question3": "Test answer3",
    "Test question4": "Test answer4",
    "Test question5": "Test answer5",
    "Test question6": "Test answer6",
    "Test question7": "Test answer7",
    "Test question8": "Test answer8",
    "Test question9": "Test answer9"
]

var randAnswerArray = [
    "Test 1",
    "test 2",
    "Test 3",
    "Test 4",
    "Test 5",
    "Test 6",
    "Test 7"
]

func retrieveQuestion() {
    let keys = Array(questionDict.keys)
    let randomIndex = Int.random(in: 0..<keys.count)
    let randomQuestion = keys[randomIndex]
    question = String(randomQuestion)
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("studyApp")
                    .font(.title)
                    .fontWeight(.heavy)
                    .padding(.bottom, 20)
                    .onAppear() {
                        retrieveQuestion()
                    }
                
                Spacer()
                
                NavigationLink(destination: multipleChoiceView()) {
                    mainButton(imageName: "play.fill", text: "Start")
                }
                .padding(.bottom, 20)
                
                Menu {
                    Button(action: {studyType = "flashCard"}) {
                        Label("Flash Cards", systemImage: "menucard.fill")
                    }
                    Button(action: {studyType = "multipleChoice"}) {
                        Label("Multiple Choice", systemImage: "list.bullet")
                    }
                    Button(action: {studyType = "closedPassage"}) {
                        Label("Closed Passage", systemImage: "pencil")
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
                .font(.title3)
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
        .frame(width: 250, height: 75)
        .background(Color.blue)
        .cornerRadius(20.0)
    }
}

struct multipleChoiceView: View {
    var body: some View {
        
        Text("studyApp")
            .font(.title)
            .fontWeight(.heavy)
        Text("Multiple Choice")
            .font(.headline)
            .fontWeight(.bold)
        Spacer()
        Text("\(question)")
            .font(.largeTitle)
            .fontWeight(.regular)
        Spacer()
        
    }
}

struct remindersView: View {
    var body: some View {
        Text("hello world! this is the reminders view")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
