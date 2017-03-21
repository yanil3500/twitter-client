//: Playground - noun: a place where people can play

import UIKit

//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


//First implementation of reversed array uses an external data structure to hold reversed value
func reversedArr(_ sourceArray : [Int]) -> [Int]  {
    
    var reversedArray = [Int]()
    
    for index in sourceArray.indices{
        reversedArray.append(sourceArray[sourceArray.count - index - 1])
    }
    
    return reversedArray
}


var numbers = [11,22,43,54,75,87,98,199]

print("Reversed array (Uses external variable): \(reversedArr(numbers))\n")

//Reverses elements in the array in-place
func reversedArrInPlace(_ sourceArray: inout [Int]) {
    for index in 0..<sourceArray.count {
        print("Reversed Array Iteration \(index): \(sourceArray)\n")

        sourceArray.insert(sourceArray.popLast()!, at: index)
        
    }
}

print("Array before values are swapped in place: \(numbers)\n")
reversedArrInPlace(&numbers)
print("Array after value have been swapped in place: \(numbers)")
