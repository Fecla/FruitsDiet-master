//
//
//
//
//
//  
//

class Fruit {
    var name:String?
    var group:String?
    var correctHypothesis:Bool?
    var correctText:Bool!
    
    init(name: String, group: String, correctHypothesis: Bool?, correctText: Bool!) {
        self.name = name
        self.group = group
        self.correctHypothesis = correctHypothesis
        self.correctText = correctText
    }
}