//: Playground - noun: a place where people can play
//Created by Yogesh Kohli on 04/14/2018

import UIKit

var str = "Hello, playground"

class Person {
    
    let name : String
    var macbook : MacBook?
    
    init(name: String, macbook: MacBook?) {
        self.name = name
        self.macbook = macbook
    }
    
    deinit {
        print("\(name) is being deinitalised")
    }
}

class MacBook {
    let name : String
  weak var owner : Person? // made this owner variable weak and see the result on Case - 2
    
    init(name: String, owner : Person?) {
        self.name = name
        self.owner = owner
    }
    
    deinit {
         print("Macbook named \(name) is being deinitalised")
    }
}


/* CASE - 1 When there is no deadlock, So - Both objects are being deinitalised here */
// If you want to run - uncomment this piece of code and check it yourself

/*
class Main {
    var yogesh : Person?
    var macbookPro : MacBook?
    
    func createObjects() {
        yogesh = Person(name: "Yogesh", macbook: nil)
        macbookPro = MacBook(name: "MacbookPro", owner: nil)
        
        yogesh = nil
        macbookPro = nil
    }

}

let mainObject = Main()
mainObject.createObjects()
*/
/* CASE - 1 ENDS HERE */


/* CASE - 2 - ARC STRONG REFERENCE CYCLE CASE - RETAIN CYCE / MEMORY LEAK */
//Solution is to make an instance weak - weak doesn't increase the reference count of an object

class Main {
    var yogesh : Person?
    var macbookPro : MacBook?
    
    func createObjects() {
        yogesh = Person(name: "Yogesh", macbook: nil)
        macbookPro = MacBook(name: "MacbookPro", owner: nil)
    }
    
    func assignProperties() {
        yogesh?.macbook = macbookPro
        macbookPro?.owner = yogesh
        
        yogesh = nil
        macbookPro = nil
        print(macbookPro?.owner)
        print(yogesh?.macbook)
    }
    
}

let mainObject = Main()
mainObject.createObjects() //if you don't create weak instance of macbook, then it will not deinitialised, you can remove weak from macbook and check it
mainObject.assignProperties()


