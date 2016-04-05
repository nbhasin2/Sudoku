//
//  SudokuSolver.swift
//  Sudoku
//
//  Created by Nishant on 2016-04-03.
//  Copyright © 2016 Epicara. All rights reserved.
//

import Foundation

class SudokuSolver
{
    
    
    var sudokuGrid: [[Int]] = [[0,2,0,0,0,0,4,0,7],
                               
                               [0,0,7,0,2,4,0,5,0],
                               
                               [3,0,0,0,1,0,2,0,6],
                               
                               [4,0,0,3,0,5,9,7,1],
                               
                               [7,0,0,0,0,0,0,0,5],
                               
                               [8,3,5,1,0,7,0,0,2],
                               
                               [5,0,9,0,7,0,0,0,8],
                               
                               [0,7,0,8,4,0,5,0,0],
                               
                               [2,0,3,0,0,0,0,6,0]]
    
    
    
    //for x in 0 ..< sudokuGrid.count {
    //    for y in 0 ..< sudokuGrid[x].count {
    //        print("vector[\(x), \(y)] = \(sudokuGrid[x][y])" )
    //    }
    //}
    
    let EMPTY = 0
    
    func solve()
    {
        solve(0, col: 0, grid: &self.sudokuGrid)
    }
    
    func solve(var row:Int, var col:Int, inout grid:[[Int]]) -> Bool
    {
        if(row == 9)
        {
            row = 0;
            
            col = col + 1
            if(col == 9)
            {
                return true
            }
        }
        
        if grid[row][col] != EMPTY
        {
            return solve(row + 1, col: col, grid: &grid)
        }
        
        for value in 1...9
        {
            if(isTrue(row, col: col, val: value, grid: grid))
            {
                grid[row][col] = value
                if(solve(row + 1, col: col, grid: &grid))
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
        
        var rowOffSet = Int((row / 3) * 3)
        var colOffSet = Int((col / 3) * 3)
        
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

    
}