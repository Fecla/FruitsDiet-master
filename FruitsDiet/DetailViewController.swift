//
//  DetailViewController.swift
//  FruitsDiet
//
//  Created by Ravi Shankar on 30/07/15.
//  Copyright (c) 2015 Ravi Shankar. All rights reserved.
//

import UIKit

let correctTextKey = "correctText"
let correctHypothesisKey = "correctHypothesis"

var lmPath: String!
var dicPath: String!
var words: Array<String> = []
var currentWord: String!

var kLevelUpdatesPerSecond = 18




class DetailViewController:  UIViewController, UITextFieldDelegate,  OEEventsObserverDelegate {
    
    
    let dataSource = DataSource()
    
    
    // Кнопкки и ввод текста для грамматики
    @IBOutlet weak var TextField1: UITextField!
    @IBOutlet weak var TextFieldButton1: UIButton!
    @IBOutlet weak var TextLabel1: UILabel!
    
    //Шарики Картинки
    @IBOutlet weak var BaloonStart: UIImageView!
    @IBOutlet weak var BaloonStart2: UIImageView!
   //Звездочки
    
    @IBOutlet weak var StarTextField: UIImageView!
    @IBOutlet weak var StarHypothesis: UIImageView!
    
    
    // кнопки и микрофон
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var heardTextView: UITextView!
    @IBOutlet weak var statusTextView: UITextView!
    
    @IBOutlet weak var CorrectHypothesisStar: UIImageView!
    @IBOutlet weak var CorrectTextStar: UIImageView!
    
    var openEarsEventsObserver = OEEventsObserver()
    var startupFailedDueToLackOfPermissions = Bool()
    var LabelNavi = String()
    //var correctText = Bool()
    var buttonFlashing = false
    
    @IBOutlet weak var imageView: UIImageView!
    
    var fruit: Fruit!
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad()
    {
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.navigationBarHidden = true
        navigationController?.toolbarHidden = true
        super.viewDidLoad()
        
        TextField1.delegate = self
        BaloonStart.hidden = true
        BaloonStart2.hidden = true
        StarTextField.hidden = true
        StarHypothesis.hidden = true
        
        
        
        if let fruit = fruit {
            print(fruit.correctText)
            //var Correct1 = defaults.boolForKey("Correct1")
            navigationItem.title = fruit.name?.capitalizedString
            imageView.image = UIImage(named: fruit.name!.lowercaseString)
            LabelNavi = navigationItem.title!
            //Correct1 = fruit.correctText!.boolValue
            

        
        if fruit.correctText == true {
           let imgData1 = defaults.objectForKey("image2") as? NSData
            if imgData1 != nil {
            StarTextField.hidden = false
            TextFieldButton1.hidden = true
            TextField1.hidden = true
            
            let image = UIImage(data: imgData1!)
            print("Star is Here")
           } else {
            print("IS fAc")
           }
        }
        else {
            
        }
            
        }
        
        loadOpenEars()
        
        func textFieldShouldReturn(textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
        
       
        /*if let fruit = fruit {
           
            navigationItem.title = fruit.name?.capitalizedString
            imageView.image = UIImage(named: fruit.name!.lowercaseString)
            LabelNavi = navigationItem.title!
            Correct1 = fruit.correctText!.boolValue
        }*/
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        //touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        if let _ = touches.first {
            view.endEditing(true)
        }
        super.touchesBegan(touches , withEvent:event)
    }
    
    //--- Вызывается, когда нажимается клавиша Return -----
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
        
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        navigationController?.setNavigationBarHidden(true, animated: false)
        BaloonStart.hidden = true
        BaloonStart2.hidden = true
    }
    
    
           //Функция Кнопки на подтверждение текста
    @IBAction func TextFieldButton1(sender: AnyObject) {
        TextField1.resignFirstResponder()
        TextLabel1.text = TextField1.text
        view.endEditing(true)
        
        if TextField1.text == navigationItem.title {
            TextField1.hidden = true
            BaloonStart2.hidden = false
            TextFieldButton1.hidden = true
            UIView.animateWithDuration(4.0, animations: {
            self.BaloonStart2.frame = CGRect(x: 142, y: -800, width: 316, height: 158)}, completion: { animationFinished in self.BaloonStart2.removeFromSuperview()})
            self.StarTextField.hidden = false
            UIView.animateWithDuration(8.0, animations: {
                self.StarTextField.frame = CGRect(x: 250, y: CGRectGetMidY(self.view.frame)-800, width: 175, height: 250)})
            navigationController?.setNavigationBarHidden(false, animated: false)
            navigationController?.navigationBarHidden = false
            

            let imgData1 = UIImagePNGRepresentation(StarTextField.image!)
            defaults.setObject(imgData1, forKey: "image2")
            defaults.synchronize()
            //fruit.correctText = true
            //defaults.setBool(Correct1, forKey: "Correct1")
            //print(fruit.correctText)
            
            
            //let paths = NSSearchPathForDirectoriesInDomains(.ApplicationDirectory, .UserDomainMask, true) as NSArray
            //let documentsDirectory = paths.objectAtIndex(0) as! NSString
            //let path = documentsDirectory.stringByAppendingPathComponent("Swa.plist")
            //let plist = NSMutableDictionary.init(object: "Swa.plist", forKey: "correctText")
            
                print(fruit.correctText)
            if let path = NSBundle.mainBundle().pathForResource("Swa", ofType: "plist") {
                print("path: \(path)")
                if let dictArray = NSArray(contentsOfFile: path) {
                    
                    for item in dictArray {
                        let dict = item as? NSDictionary
                           
            
                //dataSource.correctText = true
                //print(fruit.correctText)
                //print(dataSource.correctText)
                
                let fileManager = NSFileManager.defaultManager()
                        if(!fileManager.fileExistsAtPath(path)) {
                            // If it doesn't, copy it from the default file in the Bundle
                            if let bundlePath = NSBundle.mainBundle().pathForResource("Swa", ofType: "plist") {
                                
                                let resultDictionary = NSMutableDictionary(contentsOfFile: bundlePath)
                                print("Bundle Swa.plist file is --> \(resultDictionary?.description)")
                               
                                print("copy")
                            } else {
                                print("GameData.plist not found. Please, make sure it is part of the bundle.")
                            }
                        } else {
                            print("GameData.plist already exits at path.")
                            // use this to delete file from documents directory
                            //fileManager.removeItemAtPath(path, error: nil)
                        }
                        
                        let resultDictionary = NSMutableDictionary(contentsOfFile: path)
                        print("Loaded GameData.plist file is --> \(resultDictionary?.description)")
                        
                        var myDict = NSDictionary(contentsOfFile: path)
                        
                        if let dict = myDict {
                            //loading values
                            bedroomFloorID = dict.objectForKey(BedroomFloorKey)!
                            bedroomWallID = dict.objectForKey(BedroomWallKey)!
                            //...
                        } else {
                            print("WARNING: Couldn't create dictionary from GameData.plist! Default values will be used!")
                        }
                    }
                
                //let plist = NSMutableDictionary(dictionary: dict!)
                //var correctText = true
                //plist.setObject(NSNumber(bool: true), forKey: "correctText")
                //        plist.writeToFile(dict, atomically: <#T##Bool#>)
                //print(fruit.correctText)
                //print(dataSource.correctText)
                //let plist = NSMutableDictionary(contentsOfFile: "Swa.plist")
                //plist?.setObject(NSNumber(bool: true), forKey: "correctText")
                //plist?.writeToFile("Swa.plist", atomically: true)
                
                //print(datasource.correctText)
                
            
            
                
            }
            }
                print(fruit.correctText)


            
        } else {
            TextField1.hidden = false
            print("inCorrect TextField")
            navigationController?.setNavigationBarHidden(true, animated: false)
            //return stopFlashingbutton(stopListening())
            
            
        }
            
            }
    
   
    
    func textFieldDidBeginEditing(TextField1: UITextField) {
        print("TextField did begin editing method called")
    }
    func textFieldDidEndEditing(TextField1: UITextField) {
        print("TextField did end editing method called")
    }
    func textFieldShouldBeginEditing(TextField1: UITextField) -> Bool {
        print("TextField should begin editing method called")
        return true
    }
    func textFieldShouldClear(TextField1: UITextField) -> Bool {
        print("TextField should clear method called")
        return true
    }
    func textFieldShouldEndEditing(TextField1: UITextField) -> Bool {
        print("TextField should snd editing method called")
        return true
    }
    func TextField1(TextField1: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        print("While entering the characters this method gets called")
        return true
        
        
        
    }

    
    

    
    
    @IBAction func record(sender: AnyObject) {
        
        if !buttonFlashing {
            startFlashingbutton()
            startListening()
            navigationController?.setNavigationBarHidden(true, animated: false)
            navigationController?.navigationBarHidden = true
            navigationController?.toolbarHidden = true
        } else {
            stopFlashingbutton()
            stopListening()
            navigationController?.setNavigationBarHidden(true, animated: false)
            navigationController?.navigationBarHidden = true
            navigationController?.toolbarHidden = true
            
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
        words.append("Cock")
        words.append("Badger")
        words.append("Bat")
        words.append("Bear")
        words.append("Beaver")
        
        words.append("Bee")
        words.append("Beetle")
        words.append("Mantis")
        words.append("Boar")
        words.append("Botfly")
        words.append("Buffalo")
        words.append("Bullfinch")
        words.append("Camel")
        words.append("Cat")
        words.append("Catfish")
        words.append("Chipmunk")
        words.append("Cheetah")
        words.append("Chinchilla")
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
    
    func pocketsphinxDidReceiveHypothesis(hypothesis: String!, recognitionScore: String!, utteranceID: String!)  {
        
        NSLog("The received hypothesis is %@ with a score of %@ and an ID of %@", hypothesis, recognitionScore, utteranceID);
        //hypothesis то что выводится при Распознании речи он имеет класс String!
        
        heardTextView.text = "\(hypothesis)"
        
        
        if navigationItem.title == hypothesis {
            heardTextView.hidden = true
            print("Correct hypothesis")
            BaloonStart.hidden = false
            recordButton.hidden = true
            UIView.animateWithDuration(4.0, animations: {
            self.BaloonStart!.frame = CGRect(x: 142, y: 50, width: 316, height: 158)}, completion: { animationFinished in self.BaloonStart!.removeFromSuperview()})
            StarHypothesis.hidden = false
            UIView.animateWithDuration(8.0, animations: {
            self.StarHypothesis.frame = CGRect(x: 505, y: CGRectGetMidY(self.view.frame)-800, width: 75, height: 50)})
            
            navigationController?.setNavigationBarHidden(true, animated: false)
            navigationController?.navigationBarHidden = true
            navigationController?.toolbarHidden = true
            NSUserDefaults.standardUserDefaults().setValue(StarHypothesis, forKey: "StarHypothesisData")

        
            return stopFlashingbutton(stopListening(recordButton.alpha = 0.00))
        } else {
            heardTextView.backgroundColor = UIColor.redColor()
            print("inCorrect hypothesis")
            navigationController?.setNavigationBarHidden(true, animated: false)
        }
        
        

        
        
    }
    
    
    
}










