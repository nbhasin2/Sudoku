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
    
    //  Variables
    
    private var sudokuGridSolution:[[Int]]?
    private var sudokuBoard:[[Int]]
    private var isSolved:Bool = false
    
    init(board:[[Int]])
    {
        sudokuBoard = board
        sudokuGridSolution = deepCopy(board)
    }
    
    // Takes in sudoku grid and returns a deep copy of the array
    
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
    
    func solve() -> Bool
    {
        self.sudokuGridSolution = deepCopy(self.sudokuBoard)
        self.isSolved = solve(0, gridCol: 0, grid: &self.sudokuGridSolution!)
        return self.isSolved
    }
    
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
        
        for value in 1...9
        {
            if(isTrue(row, col: col, val: value, grid: grid))
            {
                grid[row][col] = value
                if(solve(row + 1, gridCol: col, grid: &grid))
                {
                    return true
                }
            }
        }
        
        grid[row][col] = EMPTY
        
        return false
    }
    
    func isTrue(row:Int, col:Int, val: Int, grid:[[Int]]) -> Bool
    {
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
    
    func hasFoundSolution() -> Bool
    {
        return isSolved
    }
    
    func getCurrentBoard(boardType:BoardType)->[[Int]]
    {
        if(boardType == BoardType.Solved)
        {
            return self.sudokuGridSolution!
        }
        else if(boardType == BoardType.Puzzle)
        {
            return self.sudokuBoard
        }
        
        return sudokuGridSolution!
    }
    
}