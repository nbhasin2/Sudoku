//
//  SudokuSolverTest.swift
//  Sudoku
//
//  Created by Nishant on 2016-04-07.
//  Copyright © 2016 Epicara. All rights reserved.
//

import XCTest
import Foundation
@testable import Sudoku

class PxServerFetchTests: XCTestCase {
    

    // Bad Boards
    
    // Has only 7 Rows
    
    let bboard1:[[Int]] = [[0,2,0,0,0,0,4,0,7],
                           
                           [0,0,7,0,2,4,0,5,0],
                           
                           [3,0,0,0,1,0,2,0,6],
                           
                           [4,0,0,3,0,5,9,7,1],
                           
                           [7,0,0,0,0,0,0,0,5],
                           
                           [8,3,5,1,0,7,0,0,2],
                           
                           [2,0,3,0,0,0,0,6,0]]
    
    // Has one element greater than 9
    
    let bboard2:[[Int]] = [[0,2,0,0,0,0,4,0,7],
                          
                          [0,0,7,0,2,4,0,5,100],
                          
                          [3,0,0,0,1,0,2,0,6],
                          
                          [4,0,0,3,0,5,9,7,1],
                          
                          [7,0,0,0,0,0,0,0,5],
                          
                          [8,3,5,1,0,7,0,0,2],
                          
                          [5,0,9,0,7,0,0,0,8],
                          
                          [0,7,0,8,4,0,5,0,0],
                          
                          [2,0,3,0,0,0,0,6,0]]
    
    
    // Has one negative element
    
    let bboard3:[[Int]] = [[0,2,0,0,0,0,4,0,7],
                           
                           [0,0,7,0,2,4,0,5,-100],
                           
                           [3,0,0,0,1,0,2,0,6],
                           
                           [4,0,0,3,0,5,9,7,1],
                           
                           [7,0,0,0,0,0,0,0,5],
                           
                           [8,3,5,1,0,7,0,0,2],
                           
                           [5,0,9,0,7,0,0,0,8],
                           
                           [0,7,0,8,4,0,5,0,0],
                           
                           [2,0,3,0,0,0,0,6,0]]
    
    
    // Good Board
    
    let gboard:[[Int]] = [[0,2,0,0,0,0,4,0,7],
                           
                           [0,0,7,0,2,4,0,5,0],
                           
                           [3,0,0,0,1,0,2,0,6],
                           
                           [4,0,0,3,0,5,9,7,1],
                           
                           [7,0,0,0,0,0,0,0,5],
                           
                           [8,3,5,1,0,7,0,0,2],
                           
                           [5,0,9,0,7,0,0,0,8],
                           
                           [0,7,0,8,4,0,5,0,0],
                           
                           [2,0,3,0,0,0,0,6,0]]
    
    
    var sudokuSolver:SudokuSolver?
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        self.sudokuSolver = SudokuSolver(board: [[Int]](count:9, repeatedValue: [Int](count: 9, repeatedValue: 0)))
        
        // After 4 fetches now the total number of objects in the PhotoArray (GridView) should be 144
        
        
        
    }
    
    // Test to check if board is valid 
    
    func testAIsValidBoard()
    {
        // Test the condition
        XCTAssertEqual(false, self.sudokuSolver?.checkValidPuzzle(self.bboard1))

    }
    
    func testBIsValidBoard()
    {
        // Test the condition
        XCTAssertEqual(false, self.sudokuSolver?.checkValidPuzzle(self.bboard2))
        
    }
    
    func testCIsValidBoard()
    {
        // Test the condition
        XCTAssertEqual(false, self.sudokuSolver?.checkValidPuzzle(self.bboard3))
        
    }
    
    func testDIsValidBoard()
    {
        // Test the condition
        XCTAssertEqual(true, self.sudokuSolver?.checkValidPuzzle(self.gboard))
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}