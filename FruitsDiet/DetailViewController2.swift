//
//  DetailViewController2.swift
//  FruitsDiet
//
//  Created by Alex Gr on 19.04.16.
//  Copyright © 2016 Ravi Shankar. All rights reserved.
//

import UIKit

class DetailViewController2: UIViewController, UITextFieldDelegate,  OEEventsObserverDelegate {
    
    @IBOutlet weak var TextField2: UITextField!
    @IBOutlet weak var TextFieldButton2: UIButton!
    @IBOutlet weak var TextLabel2: UILabel!
    
    @IBOutlet weak var BaloonStart: UIImageView!
    
    @IBOutlet weak var BaloonStart2: UIImageView!

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var heardTextView: UITextView!
    @IBOutlet weak var statusTextView: UITextView!
    
    var openEarsEventsObserver = OEEventsObserver()
    var startupFailedDueToLackOfPermissions = Bool()
    
    var buttonFlashing = false
    
    @IBOutlet weak var imageView: UIImageView!
    
    var fruit2: Fruit2?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TextField2.delegate = self
        BaloonStart.hidden = true
        BaloonStart2.hidden = true
        //navigationItem.title.hidden = true
        loadOpenEars()
        if let fruit2 = fruit2 {
            navigationItem.title = fruit2.name2?.capitalizedString
            imageView.image = UIImage(named: fruit2.name2!.lowercaseString)
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func TextFieldButton2(sender: AnyObject) {
        TextField2.resignFirstResponder()
        TextLabel2.text = TextField2.text
        
        
        if TextField2.text == navigationItem.title {
            TextField2.hidden = true
            BaloonStart2.hidden = false
            TextFieldButton2.hidden = true
            UIView.animateWithDuration(4.0, animations: {
                self.BaloonStart2.frame = CGRect(x: 142, y: CGRectGetMidY(self.view.frame)-800, width: 316, height: 158)}, completion: { animationFinished in self.BaloonStart2.removeFromSuperview()})
        } else {
            heardTextView.backgroundColor = UIColor.redColor()
            TextField2.hidden = false
            print("inCorrect TextField")
            

        }
        
    }
    
    func textFieldDidBeginEditing(TextField2: UITextField) {
        print("TextField did begin editing method called")
    }
    func textFieldDidEndEditing(TextField2: UITextField) {
        print("TextField did end editing method called")
    }
    func textFieldShouldBeginEditing(TextField2: UITextField) -> Bool {
        print("TextField should begin editing method called")
        return true
    }
    func textFieldShouldClear(TextField2: UITextField) -> Bool {
        print("TextField should clear method called")
        return true
    }
    func textFieldShouldEndEditing(TextField2: UITextField) -> Bool {
        print("TextField should snd editing method called")
        return true
    }
    func TextField2(TextField2: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        print("While entering the characters this method gets called")
        return true
    }
    func textFieldShouldReturn(TextField2: UITextField) -> Bool {
        print("TextField should return method called")
        TextField2.resignFirstResponder()
        
        return true
    }

    @IBAction func record(sender: AnyObject) {
        
        if !buttonFlashing {
            startFlashingbutton()
            startListening()
        } else {
            stopFlashingbutton()
            stopListening()
        }
    }
    
    func startFlashingbutton() {
        
        buttonFlashing = true
        recordButton.alpha = 1
        
        UIView.animateWithDuration(0.5 , delay: 0.0, options: [UIViewAnimationOptions.CurveEaseInOut, UIViewAnimationOptions.Repeat, UIViewAnimationOptions.Autoreverse, UIViewAnimationOptions.AllowUserInteraction], animations: {
            
            self.recordButton.alpha = 0.1
            
            }, completion: {Bool in
        })
    }
    
    func stopFlashingbutton() {
        
        buttonFlashing = false
        
        UIView.animateWithDuration(0.1, delay: 0.0, options: [UIViewAnimationOptions.CurveEaseInOut, UIViewAnimationOptions.BeginFromCurrentState], animations: {
            
            self.recordButton.alpha = 1
            
            }, completion: {Bool in
        })
    }
    
    func loadOpenEars() {
        
        self.openEarsEventsObserver = OEEventsObserver()
        self.openEarsEventsObserver.delegate = self
        
        let lmGenerator: OELanguageModelGenerator = OELanguageModelGenerator()
        
        addWords()
        let name = "LanguageModelFileStarSaver"
        lmGenerator.generateLanguageModelFromArray(words, withFilesNamed: name, forAcousticModelAtPath: OEAcousticModel.pathToModel("AcousticModelEnglish"))
        
        lmPath = lmGenerator.pathToSuccessfullyGeneratedLanguageModelWithRequestedName(name)
        dicPath = lmGenerator.pathToSuccessfullyGeneratedDictionaryWithRequestedName(name)
    }
    
    
    func pocketsphinxDidStartListening() {
        print("Pocketsphinx is now listening.")
        statusTextView.text = "Pocketsphinx is now listening."
    }
    
    func pocketsphinxDidDetectSpeech() {
        print("Pocketsphinx has detected speech.")
        statusTextView.text = "Pocketsphinx has detected speech."
    }
    
    func pocketsphinxDidDetectFinishedSpeech() {
        print("Pocketsphinx has detected a period of silence, concluding an utterance.")
        statusTextView.text = "Pocketsphinx has detected a period of silence, concluding an utterance."
    }
    
    func pocketsphinxDidStopListening() {
        print("Pocketsphinx has stopped listening.")
        statusTextView.text = "Pocketsphinx has stopped listening."
    }
    
    func pocketsphinxDidSuspendRecognition() {
        print("Pocketsphinx has suspended recognition.")
        statusTextView.text = "Pocketsphinx has suspended recognition."
    }
    
    func pocketsphinxDidResumeRecognition() {
        print("Pocketsphinx has resumed recognition.")
        statusTextView.text = "Pocketsphinx has resumed recognition."
    }
    
    func pocketsphinxDidChangeLanguageModelToFile(newLanguageModelPathAsString: String, newDictionaryPathAsString: String) {
        print("Pocketsphinx is now using the following language model: \(newLanguageModelPathAsString) and the following dictionary: \(newDictionaryPathAsString)")
    }
    
    func pocketSphinxContinuousSetupDidFailWithReason(reasonForFailure: String) {
        print("Listening setup wasn't successful and returned the failure reason: \(reasonForFailure)")
        statusTextView.text = "Listening setup wasn't successful and returned the failure reason: \(reasonForFailure)"
    }
    
    func pocketSphinxContinuousTeardownDidFailWithReason(reasonForFailure: String) {
        print("Listening teardown wasn't successful and returned the failure reason: \(reasonForFailure)")
        statusTextView.text = "Listening teardown wasn't successful and returned the failure reason: \(reasonForFailure)"
    }
    
    func testRecognitionCompleted() {
        print("A test file that was submitted for recognition is now complete.")
        statusTextView.text = "A test file that was submitted for recognition is now complete."
    }
    
    func startListening() {
        
        do {
            
            try OEPocketsphinxController.sharedInstance().setActive(true)
            
        } catch {
            
            print(error)
            
        }
        
        OEPocketsphinxController.sharedInstance().startListeningWithLanguageModelAtPath(lmPath, dictionaryAtPath: dicPath, acousticModelAtPath: OEAcousticModel.pathToModel("AcousticModelEnglish"), languageModelIsJSGF: false)
    }
    
    func stopListening() {
        OEPocketsphinxController.sharedInstance().stopListening()
    }
    
    func addWords() {
        //add any thing here that you want to be recognized. Must be in capital letters
        words.append("Crorodile")
        words.append("Cuckoo")
        words.append("Deer")
        words.append("Dog")
        words.append("Dolphin")
        words.append("Donkey")
        words.append("Cockroach")
        
        words.append("Cormorant")
        words.append("Cow")
        words.append("Crane")
        words.append("Boar")
        words.append("Botfly")
        words.append("Buffalo")
        words.append("Bullfinch")
        words.append("Camel")
        words.append("Cat")
        words.append("Catfish")
        words.append("Cavy")
        words.append("Capercaillie")
    }
    
    func getNewWord() {
        let randomWord = Int(arc4random_uniform(UInt32(words.count)))
        currentWord = words[randomWord]
    }
    
    func pocketsphinxFailedNoMicPermissions() {
        
        NSLog("Local callback: The user has never set mic permissions or denied permission to this app's mic, so listening will not start.")
        self.startupFailedDueToLackOfPermissions = true
        if OEPocketsphinxController.sharedInstance().isListening {
            let error = OEPocketsphinxController.sharedInstance().stopListening() // Stop listening if we are listening.
            if(error != nil) {
                NSLog("Error while stopping listening in micPermissionCheckCompleted: %@", error);
            }
        }
    }
    
    func pocketsphinxDidReceiveHypothesis(hypothesis: String!, recognitionScore: String!, utteranceID: String!) {
        
        NSLog("The received hypothesis is %@ with a score of %@ and an ID of %@", hypothesis, recognitionScore, utteranceID);
        //hypothesis то что выводится при Распознании речи он имеет класс String!
        
        heardTextView.text = "\(hypothesis)"
        
        
        if navigationItem.title == hypothesis {
            heardTextView.hidden = true
            print("Correct hypothesis")
            BaloonStart.hidden = false
            recordButton.hidden = true
            UIView.animateWithDuration(4.0, animations: {
                self.BaloonStart.frame = CGRect(x: 142, y: -800, width: 316, height: 158)}, completion: { animationFinished in self.BaloonStart.removeFromSuperview()})
            return stopFlashingbutton(stopListening(recordButton.alpha = 0.00))
        } else {
            heardTextView.backgroundColor = UIColor.redColor()
        }
        
        
    }
    
    
    

    
}
