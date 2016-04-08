//
//  SudokuSolver.swift
//  Sudoku
//
//  Created by Nishant on 2016-04-03.
//  Copyright © 2016 Epicara. All rights reserved.
//

import Foundation

enum BoardType {
    case Solved
    case Puzzle
}

class SudokuSolver
{
    //  Constants
    
    let EMPTY = 0
    let kTotalItems = 81 // 9x9 grid = 81
    
    //  Variables
    public var totalItemsInBoard:Int = 0
    
    private var sudokuGridSolution = [[Int]](count:9, repeatedValue: [Int](count: 9, repeatedValue: 0))
    private var sudokuBoard = [[Int]](count:9, repeatedValue: [Int](count: 9, repeatedValue: 0))
    private var isSolved:Bool = false
    private var isValidBoard:Bool = false
    
    //  MARK: - Initializer
    
    init(board:[[Int]])
    {
        sudokuBoard = board
        isValidBoard = checkValidPuzzle(sudokuBoard)
        if(isValidBoard)
        {
            sudokuGridSolution = deepCopy(board)
        }
    }
    
    /**
     *
     * Name         : solve
     *
     * Parameters   : Nothing
     *
     * Return Value : Bool
     *
     * -- Description --
     *
     * Solve method that uses the SudokuBoard aka puzzle
     * to find the solution and puts its into SodokuGridSolution
     * Returns true if a solution is found else false.
     *
     **/
    
    func solve() -> Bool
    {
        // Checking if board is valid 
        
        if(self.isValidBoard)
        {
            self.isSolved = solve(0, gridCol: 0, grid: &self.sudokuGridSolution)
        }
        
        return self.isSolved
    }
    
    /**
     *
     * Name         : solve
     *
     * Parameters   : 
     *
     *  GridRow:Int
     *  GridCol:Int  
     *  Inout - Grid:[[Int]]
     *
     * Return Value : Bool
     *
     * -- Description --
     *
     * Solve method takes in puzzle / grid along with starting point 
     * for row and coloum (0,0) and solves that puzzle. Because the grid
     * is inout it means that the grid pass by reference and thus 
     * changes will be made to original value.
     * Returns true if a solution is found else false.
     * This method uses recursive backtracking to solve the puzzle.
     *
     * More can be found on wikipedia page.
     * https://en.wikipedia.org/wiki/Sudoku_solving_algorithms#Backtracking
     * https://en.wikipedia.org/wiki/Backtracking
     *
     **/
    
    // https://en.wikipedia.org/wiki/Sudoku_solving_algorithms#Backtracking
    
    private func solve(gridRow:Int, gridCol:Int, inout grid:[[Int]]) -> Bool
    {
        var row = gridRow
        var col = gridCol
        
        if (row == 9)
        {
            row = 0;
            
            col = col + 1
            if(col == 9)
            {
                return true
            }
        }
        
        if (grid[row][col] != EMPTY)
        {
            return solve(row + 1, gridCol: col, grid: &grid)
        }
        
        // Iterates from value 1 to 9 so see if it can be placed 
        // or not using isTrue method on provided row and column
        
        for value in 1...9
        {
            // If isTrue is valid then we can place value on provided
            // row and column in the grid.
            
            if(isTrue(row, col: col, val: value, grid: grid))
            {
                // Saving the value on the row / col of the grid
                
                grid[row][col] = value
                
                // Incrementing row by 1 and calling the solve method 
                // recursively. Once a solution is found we return true.
                
                if(solve(row + 1, gridCol: col, grid: &grid))
                {
                    return true
                }
            }
        }
        
        grid[row][col] = EMPTY
        
        return false
    }
    
    
    /**
     *
     * Name         : isTrue
     *
     * Parameters   :
     *
     *  ow:Int
     *  col:Int
     *  val:Int
     *  grid - Grid:[[Int]]
     *
     * Return Value : Bool
     *
     * -- Description --
     *
     * This method checks if the value (val) can be placed on 
     * given row / col on the 2d grid provided to it.
     * If the value can be placed it returns true.
     *
     **/
    
    func isTrue(row:Int, col:Int, val: Int, grid:[[Int]]) -> Bool
    {
        // Checking if there are no duplicate values.
        // If a duplicate is found we return false
        
        for index in 0...8
        {
            if(val == grid[index][col])
            {
                return false
            }
        }
        
        for index in 0...8
        {
            if(val == grid[row][index])
            {
                return false
            }
        }
        
        // Checking if the 3 by 3 squares have no duplicates
        
        let rowOffSet = Int((row / 3) * 3)
        let colOffSet = Int((col / 3) * 3)
        
        for rowIndex in 0...2
        {
            for colIndex in 0...2
            {
                if(val == grid[rowOffSet + rowIndex][colOffSet + colIndex])
                {
                    return false
                }
            }
        }
        
        return true
    }
    
    //  MARK: Helper Functions
    
    /**
     *
     * Name         : deepCopy
     *
     * Parameters   : sudokuGrid:[[Int]]
     *
     * Return Value : [[Int]] - 2D Int array
     *
     * -- Description --
     *
     * Takes in sudoku grid and returns a deep copy of the 2d array.
     *
     **/
    
    private func deepCopy(sudokuGrid:[[Int]]) -> [[Int]]
    {
        var gridCopy = [[Int]]()
        
        for x in 0 ..< sudokuGrid.count {
            var gridRow = [Int]()
            for y in 0 ..< sudokuGrid[x].count {
                gridRow.append(sudokuGrid[x][y])
            }
            gridCopy.append(gridRow)
        }
        
        return gridCopy
    }
    
    
    /**
     *
     * Name         : checkValidPuzzle
     *
     * Parameters   : sudokuGrid:[[Int]]
     *
     * Return Value : Bool
     *
     * -- Description --
     *
     * Takes in sudoku grid and check if the grid is valid
     * If grid satisfies the following conditions we consider it valid.
     * - Total items are 81 
     * - No negative item is there in the grid
     * - Each item in the grid is from range 0 to 9
     *
     **/
    
    private func checkValidPuzzle(sudokuGrid:[[Int]]) -> Bool
    {
        var totalItems = 0
        
        for x in 0 ..< sudokuGrid.count {
            for y in 0 ..< sudokuGrid[x].count {
                totalItems = totalItems + 1
                
                let value = sudokuGrid[x][y]
                
                // Check if there is no negative item
                
                if(value < 0)
                {
                    return false
                }
                
                // Check if item is in range 0 to 9
                
                if !(value >= 0 && value < 10)
                {
                    return false
                }
            }
        }
        
        self.totalItemsInBoard = totalItems
        
        // Check if total items are equal to 81
        
        if(totalItems == kTotalItems)
        {
            return true
        }
        
        return false
    }
    
    /**
     *
     * Name         : hasFoundSolution
     *
     * Parameters   : Nothing
     *
     * Return Value : Bool
     *
     * -- Description --
     *
     * Returns true if a solution is found else false
     *
     **/

    func hasFoundSolution() -> Bool
    {
        return isSolved
    }
    
    /**
     *
     * Name         : getBoard
     *
     * Parameters   : boardType : BoardType
     *
     * Return Value : Int
     *
     * -- Description --
     *
     * Returns board depending on the type of board requested
     * Can request sudoku board i.e. the puzzle type or
     * Can request sudoku grid solution i.e. solved board
     *
     **/
    
    
    func getBoard(boardType:BoardType)->[[Int]]
    {
        if(self.isValidBoard == false)
        {
            return sudokuGridSolution
        }
        
        if(boardType == BoardType.Solved)
        {
            return self.sudokuGridSolution
        }
        else if(boardType == BoardType.Puzzle)
        {
            return self.sudokuBoard
        }
        
        return sudokuGridSolution
    }
    
}