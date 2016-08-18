
// |=------------------------------------------------------=|
//  Copyright (c) 2016 Juan Antonio Karmy.
//  Licensed under MIT License
//
//  See https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/ for Swift Language Reference
//
//  See Juan Antonio Karmy - http://karmy.co | http://twitter.com/jkarmy
//
// |=------------------------------------------------------=|


import UIKit

struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: 0.0, count: rows * columns)
    }
    func indexIsValidForRow(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    /*
     This is how you define subscripts.
     In this case, the matrix is accessed via subscripts i.e. matrix[1,2]
     */
    subscript(row: Int, column: Int) -> Double {
        //Subcripts can be read-write or read-only (no need for getters and setters in that case)
        get {
            assert(indexIsValidForRow(row: row, column: column), "Index out of range")
            return grid[(row * columns) + column]
        }
        //newValue is provided by default, but you can change the name of the received value.
        set {
            assert(indexIsValidForRow(row: row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
        }
    }
}

class ViewController: UIViewController {
    
    var matrix = Matrix(rows: 2, columns: 2)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //This is setting up the first position of the matrix
        matrix[0, 0] = 2.5
        let number = matrix[0,0]
        print(number)
        
        //This call will fail, since it's out of bounds.
        matrix[3, 3] = 4.5
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

