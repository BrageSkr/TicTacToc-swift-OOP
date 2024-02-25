//
//  GameState.swift
//  TicTacToe2
//
//  Created by Brage Skrettingland on 01/11/2022.
//

import Foundation
class GameState: ObservableObject
{
    @Published var board = [[Cell]]()
    @Published var turn = Tile.Cross
    @Published var noughtsScore = 0
    @Published var crossesScore = 0
    @Published var showAlert = false
    @Published var alertMessage = "Draw"
    init(){
        resetBoard()
    }
    func turnText() -> String {
        return turn == Tile.Cross ? "Turn X" : "Turn O"
    }
    func placeTile(_ row: Int ,_ column: Int )
    {
        if(board[row][column].tile != Tile.Empty){
             return
        }
        board[row][column].tile = turn == Tile.Cross ? Tile.Cross : Tile.Nought
        
        if (checkForVictory()){
            if (turn == Tile.Cross){
                crossesScore += 1
            }
            else {
                noughtsScore += 1
            }
            let winner = turn == Tile.Cross ? "Crosses" : "Noughts"
            alertMessage = winner + " Win!"
            showAlert = true
        }
        else {
            turn = turn == Tile.Cross ? Tile.Nought : Tile.Cross
        }
        if (checkForDraw()){
            alertMessage = "Draw"
            showAlert = true
        }
        func checkForDraw() -> Bool {
           for row in board {
                for cell in row {
                    if cell.tile == Tile.Empty{
                        return false
                    }
                }
            }
            if isTurnTile(row:0,column:0) && isTurnTile(row:1,column:0) && isTurnTile(row:2,column:0){
                return false
            }
            if isTurnTile(row:0,column:1) && isTurnTile(row:1,column:1) && isTurnTile(row:2,column:1){
                return false
            }
            if isTurnTile(row:0,column:2) && isTurnTile(row:1,column:2) && isTurnTile(row:2,column:2){
                return false
            }
            if isTurnTile(row:0,column:0) && isTurnTile(row:0,column:1) && isTurnTile(row:0,column:2){
                return false
            }
            if isTurnTile(row:1,column:0) && isTurnTile(row:1,column:1) && isTurnTile(row:1,column:2){
                return false
            }
            if isTurnTile(row:2,column:0) && isTurnTile(row:2,column:1) && isTurnTile(row:2,column:2){
                return false
            }
            if isTurnTile(row:0,column:0) && isTurnTile(row:1,column:1) && isTurnTile(row:2,column:2){
                return false
            }
            if isTurnTile(row:2,column:0) && isTurnTile(row:1,column:1) && isTurnTile(row:0,column:2){
                return false
            }
            return true
        }
        func checkForVictory() -> Bool {
            if isTurnTile(row:0,column:0) && isTurnTile(row:1,column:0) && isTurnTile(row:2,column:0){
                return true
            }
            if isTurnTile(row:0,column:1) && isTurnTile(row:1,column:1) && isTurnTile(row:2,column:1){
                return true
            }
            if isTurnTile(row:0,column:2) && isTurnTile(row:1,column:2) && isTurnTile(row:2,column:2){
                return true
            }
            if isTurnTile(row:0,column:0) && isTurnTile(row:0,column:1) && isTurnTile(row:0,column:2){
                return true
            }
            if isTurnTile(row:1,column:0) && isTurnTile(row:1,column:1) && isTurnTile(row:1,column:2){
                return true
            }
            if isTurnTile(row:2,column:0) && isTurnTile(row:2,column:1) && isTurnTile(row:2,column:2){
                return true
            }
            if isTurnTile(row:0,column:0) && isTurnTile(row:1,column:1) && isTurnTile(row:2,column:2){
                return true
            }
            if isTurnTile(row:2,column:0) && isTurnTile(row:1,column:1) && isTurnTile(row:0,column:2){
                return true
            }
            return false
        }
        func isTurnTile (row: Int ,column: Int) -> Bool {
            return board[row][column].tile == turn
        }
    }
    func resetBoard(){
        var newBoard = [[Cell]]()
        
        for _ in 0...2
        {
            var row = [Cell]()
            for _ in 0...2{
                row.append(Cell(tile:Tile.Empty))
            }
            newBoard.append(row)
        }
        board = newBoard
    }
}
