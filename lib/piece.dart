import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_tetris_jose/board.dart';

import 'values.dart';

class Piece {
  // type of tetris piece
  Tetromino type;

  Piece({required this.type});

  // the piece is just of integers
  List<int> position = [];

// color of the piece
  Color get color{
    return tetrominoColors[type] ??
      const Color(0xFFFFFFFF);
  }
  // generate the integer
  void initializePiece(){
    switch (type) {
      case Tetromino.L:
        position = [
          -26,
          -16,
          -6,
          -5,
        ];
        break;
      case Tetromino.J:
        position = [
          -25,
          -15,
          -5,
          -6,
        ];
        break;
      case Tetromino.I:
        position = [
          -4,
          -5,
          -6,
          -7,
        ];
        break;
      case Tetromino.O:
        position = [
          -15,
          -16,
          -5,
          -6,
        ];
        break;
      case Tetromino.S:
        position = [
          -15,
          -14,
          -6,
          -5,
        ];
        break;
      case Tetromino.Z:
        position = [
          -17,
          -16,
          -6,
          -5,
        ];
        break;
      case Tetromino.T:
        position = [
          -26,
          -16,
          -6,
          -15,
        ];
        break;
      default:
    }
  }

  // move pices
  void movePiece(Direction direction){
    switch (direction) {
      case Direction.down:
        for(int i=0; i < position.length; i++){
          position[i] += rowLength;
        }
        break;
        case Direction.left:
        for(int i=0; i < position.length; i++){
          position[i] -= 1;
        }
        break;
        case Direction.right: 
        for(int i=0; i < position.length; i++){
          position[i] += 1;
        }
        break;
      default:
    }
  }
  // rotate piece
  int rotationState = 1;

  void rotatePiece(){
    List<int> newPosition = [];
    
    switch (type){
      case Tetromino.L:
        switch(rotationState){
          case 0:
            newPosition = [
              position[1] - 1,      
              position[1],           
              position[1] + 1,       
              position[1] + rowLength + 1,  
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            newPosition = [
              position[1] - rowLength,  
              position[1],              
              position[1] + rowLength,  
              position[1] + rowLength - 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            newPosition = [
              position[1] - 1,          
              position[1],              
              position[1] + 1,          
              position[1] - rowLength - 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            newPosition = [
              position[1] + rowLength,  
              position[1],              
              position[1] - rowLength,  
              position[1] - rowLength + 1,
            ];
            if (piecePositionIsValid(newPosition)) {
              position = newPosition;
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
        break;
      default:

    }
  }

  // check if
  bool positionIsValid(int position){
    // get
    int row = (position / rowLength).floor();
    int col = position % rowLength;

    // if
    if (row < 0 || col < 0 || gameBoard[row][col]!= null){
      return false;
    }

    // position is valid
    else{
      return true;
    }
  }


  // check if piece position
  bool piecePositionIsValid(List<int> piecePosition){
    bool firstColOccupied = false;
    bool lastColOccupied = false;

    for (int pos in piecePosition){
      // return
      if(!positionIsValid(pos)){
        return false;
      }

      // get the conutry
      int col = pos % rowLength;

      // length
      if(col == 0){
        firstColOccupied = true;
      }
      if (col == rowLength - 1){
        lastColOccupied = true;
      }
    }

    // if 
    return !(firstColOccupied && lastColOccupied);
  }
}