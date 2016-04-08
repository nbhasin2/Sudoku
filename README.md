# Sudoku
Simple Sudoku in Swift

## How to run

- Simply download the project and make sure you have XCode 7.3 to run it.
- Once downloaded open project in XCode 7.3 and hit play button to run the app. 
- Written in Swift 2 

## How to add new puzzle / solve it

- In order to modify the puzzle. Go to the Constants.swift file and modify sudokuGrid with your own values.
- If the puzzle is valid then you may solve it using Solve button.
- If the puzzle is really hard (sudokuGrid2) it might take a while and user sees an indicator while app tries to find its solution. 

## Different screen size supported

- The game is tested on all screen size.
- Also added code to support landscape left and right + portrait.

** However the game is not tested on all real devices **

## Unit Test

- Added unit tests to check checkValidPuzzle(sudokuGrid:[[Int]]) function.

## Cross Platform suggestion 

- Current app is natively written but the algorithm can be modified to be written in C/C++ which can be used in Linux / Windows or Mac
- Other frameworks like IONIC and Phonegap can be used to make this game. 

____

![alt text](http://i.imgur.com/jZYPqWK.png?1)

____
