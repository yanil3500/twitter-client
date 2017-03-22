//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

//First implementation of reversed array uses an external data structure to hold reversed value
func reversedArr(_ sourceArray: [Int]) -> [Int] {

    var reversedArray = [Int]()

    for index in sourceArray.indices {
        reversedArray.append(sourceArray[sourceArray.count - index - 1])
    }

    return reversedArray
}

var numbers = [11, 22, 43, 54, 75, 87, 98, 199]

print("Reversed array (Uses external variable): \(reversedArr(numbers))\n")

//Reverses elements in the array in-place
func reversedArrInPlace(_ sourceArray: inout [Int]) {
    for index in 0..<sourceArray.count {

        sourceArray.insert(sourceArray.popLast()!, at: index)

    }
}

print("Array before values are swapped in place: \(numbers)\n")
reversedArrInPlace(&numbers)
print("Array after values have been swapped in place: \(numbers)\n")

//Reverses elements in the array in-place (recursively)
func reversedArrayRecursive(_ sourceArray: inout [Int], index: Int = 0) -> [Int] {
    if index < sourceArray.count {

        print("Array at Iteration \(index): \(sourceArray)")
        sourceArray.insert(sourceArray.popLast()!, at: index)

        reversedArrayRecursive(&sourceArray, index: index + 1)
    }

    return sourceArray
}

print("First call to recursive function: Array after values are swapped in place (recursively): \((reversedArrayRecursive(&numbers, index: 0)))\n")

print("Second call to recursiveefunction: Array after values are swapped in place (recursively): \((reversedArrayRecursive(&numbers, index: 0)))\n")

print("Third call to recursiveefunction: Array after values are swapped in place (recursively): \((reversedArrayRecursive(&numbers, index: 0)))")
