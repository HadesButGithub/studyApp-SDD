# studyApp
A free, open-source, SwiftUI study assistant. Work in progress.
# User Documentation
### Multiple Choice
Simply open the app, and press the multiple choice button. You'll be presented with a random question and 4 possible answers. Tap the one you think is correct. If you get it right, you'll be served another random question, and you'll have a point added to your streak. If not, you'll get an alert and a second try at the same question, and your streak will be reset.
### Flash Cards
In app, press the flash card button. You'll be given a random question. Press "Flip" or the localised equivalent to see the answer. Then, hit "Next Card". After you hit "Next Card", you'll be given another question and one point will be added to your "Cards Studied" total.
### Accessing Localised Versions
studyApp supports English, French, and Spanish, and adapts based on your system language. To change the studyApp language, [change your system language.](https://support.apple.com/en-au/HT204031)
# Developer Documentation
### Opening in Xcode
1. In your terminal, type `git clone https://github.com/HadesButGithub/studyApp-SDD`
2. Open the `studyApp.xcodeproj` file.
3. Install the SPConfetti package.
<div class="callout">
Installing the SPConfetti package can be done through the Swift Package Manager, CocoaPods, or by manually importing the git repo. Detailed instructions can be found at the SPConfetti GitHub page: https://github.com/ivanvorobei/SPConfetti.
</div>
