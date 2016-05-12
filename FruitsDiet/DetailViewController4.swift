//
//  DetailViewController4.swift
//  FruitsDiet
//
//  Created by Alex Gr on 20.04.16.
//  Copyright © 2016 Ravi Shankar. All rights reserved.
//

import UIKit

class DetailViewController4: UIViewController, UITextFieldDelegate, OEEventsObserverDelegate {
    
    
    @IBOutlet weak var TextField4: UITextField!
    @IBOutlet weak var TextFieldButton4: UIButton!
    @IBOutlet weak var TextLabel4: UILabel!
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var heardTextView: UITextView!
    @IBOutlet weak var statusTextView: UITextView!
    
    var openEarsEventsObserver = OEEventsObserver()
    var startupFailedDueToLackOfPermissions = Bool()
    
    var buttonFlashing = false
    
    @IBOutlet weak var imageView: UIImageView!
    
    var fruit4: Fruit4?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TextField4.delegate = self
        
        loadOpenEars()
        if let fruit4 = fruit4 {
            navigationItem.title = fruit4.name4?.capitalizedString
            imageView.image = UIImage(named: fruit4.name4!.lowercaseString)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func TextFieldButton4(sender: AnyObject) {
        TextField4.resignFirstResponder()
        TextLabel4.text = TextField4.text
        
        if TextField4.text == navigationItem.title {
            TextField4.hidden = true
            heardTextView.backgroundColor = UIColor.greenColor()
            return (recordButton.alpha = 0.05)
        } else {
            heardTextView.backgroundColor = UIColor.redColor()
            TextField4.hidden = false
        }
        
    }
    
    func textFieldDidBeginEditing(TextField4: UITextField) {
        print("TextField did begin editing method called")
    }
    func textFieldDidEndEditing(TextField4: UITextField) {
        print("TextField did end editing method called")
    }
    func textFieldShouldBeginEditing(TextField4: UITextField) -> Bool {
        print("TextField should begin editing method called")
        return true
    }
    func textFieldShouldClear(TextField4: UITextField) -> Bool {
        print("TextField should clear method called")
        return true
    }
    func textFieldShouldEndEditing(TextField4: UITextField) -> Bool {
        print("TextField should snd editing method called")
        return true
    }
    func TextField4(TextField4: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        print("While entering the characters this method gets called")
        return true
    }
    func textFieldShouldReturn(TextField4: UITextField) -> Bool {
        print("TextField should return method called")
        TextField4.resignFirstResponder()
        
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
        words.append("Ant")
        words.append("Antelope")
        words.append("Apple")
        words.append("Badger")
        words.append("Bat")
        words.append("Bear")
        words.append("Beaver")
        
        words.append("Bee")
        words.append("Beetle")
        words.append("Blackcock")
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
            heardTextView.backgroundColor = UIColor.greenColor()
            return stopFlashingbutton(stopListening(recordButton.alpha = 0.05))
        } else {
            heardTextView.backgroundColor = UIColor.redColor()
        }
        
        
    }
    
    
    
    
    
}
