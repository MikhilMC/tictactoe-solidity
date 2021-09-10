// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.7.0;

contract tic_tac_toe {
    
    // State variables
    uint[9] board;
    uint turn;
    uint filled;
    string status;
    
    // Test cases for a win
    uint[][]  tests = [
        [0,1,2],[3,4,5],[6,7,8], 
        [0,3,6],[1,4,7],[2,5,8], 
        [0,4,8],[2,4,6]
    ];
    
    // constructor() {
    //     resetGame();
    // }
    
    // Function for resetting the game
    function resetGame() public returns (string memory) {
        turn = 0;
        
        for (uint8 i = 0; i < 9; i++) {
            board[i] = turn;
        }
        
        filled = 0;
        status = "START GAME";
        
        return status;
    }
    
    // Function for determining which symbol ('X' or 'O') will go first.
    function toss(string memory _char) public returns (string memory) {
        require (compareString(_char), 'Invalid character');
        
        if (isStringX(_char)) {
            turn = 1;
            status = "FIRST MOVE FOR X";
        } else {
            turn = 2;
            status = "FIRST MOVE FOR O";
        }
        
        return status;
    }
    
    // Function for setting the move.
    function setNextMove(uint8 _cell) public returns (string memory)  {
        
        // require(isCellFilled(_cell), "This cell is already filled.");
        // require(checkResult() != false, "This game is already finished.");
        
        if (_cell < 0 || _cell >= 9) {
            // If the given cell number is less than 0, or greater than or equal to 9,
            // then it will be an invalid condition.
            return "INVALID CELL NUMBER.";
        } else if (checkResult() != false || filled == 9) {
            // If the game is already won, or all the cells are filled,
            // there no point to continue.
            return "THIS GAME IS ALREADY FINISHED.";
        } else if (board[_cell] != 0) {
            // If that cell is not empty
            return "THIS CELL IS ALREADY OCCUPIED.";
        } else {
            board[_cell] = turn;
            filled++;
            
            string memory cellStringified = uintToString(_cell);
            
            if (filled < 5) {
                // In order to determine a winner, atleast 5 cells must be filled.
                // If not, we should do only normal operations.
                if (turn == 1) {
                    turn = 2;
                    status = append("X FILLED AT CELL ", cellStringified, ". NEXT MOVE FOR O.");
                } else {
                    turn = 1;
                    status = append("O FILLED AT CELL ", cellStringified, ". NEXT MOVE FOR X.");
                }
                
            } else if (filled >= 5 && filled < 9) {
                // If the number of filled cells exceeds 4 and less than 9,
                // then we should check whether there is a winner or not.
                if (checkResult()) {
                    if (turn == 1) {
                        status = "X WINS.";
                    } else {
                        status = "O WINS.";
                    }
                    
                } else {
                    if (turn == 1) {
                        turn = 2;
                        status = append("X FILLED AT CELL ", cellStringified, ". NEXT MOVE FOR O.");
                    } else {
                        turn = 1;
                        status = append("O FILLED AT CELL ", cellStringified, ". NEXT MOVE FOR X.");
                    }
                }
            } else if (filled == 9) {
                // If all the cells are filled, either there should be a winner,
                // or the game draws.
                if (checkResult() && turn == 1) {
                    status = "X WINS.";
                } else if (checkResult() && turn == 2) {
                    status = "O WINS.";
                } else {
                    status = "GAME DRAWS.";
                }
            }
            
            return status;
        }
    }
    
    // Functions for checking whether a winner is available, or not
    function checkResult() private view returns (bool) {
        if (turn == 0) {
            return false;
        }
        
        for (uint i = 0; i < 8; i++) {
            uint[] memory test = tests[i];
            if (
                board[test[0]] == turn && 
                board[test[1]] == board[test[0]] && 
                board[test[2]] == board[test[0]]
            ) {
                return true;
            }
        }
        return false;
    }
    
    // Function for checking whether the input to the toss() function is
    // invalid or not.
    function compareString(string memory _char) private pure returns (bool) {
        if (keccak256(abi.encodePacked((_char))) == keccak256(abi.encodePacked(('X')))) {
            return true;
        } else if (keccak256(abi.encodePacked((_char))) == keccak256(abi.encodePacked(('x')))) {
            return true;
        } else if (keccak256(abi.encodePacked((_char))) == keccak256(abi.encodePacked(('O')))) {
            return true;
        } else if (keccak256(abi.encodePacked((_char))) == keccak256(abi.encodePacked(('o')))) {
            return true;
        } else {
            return false;
        }
    }
    
    // Function for checking whether the given input to the function
    // toss() is 'X' or 'O'.
    function isStringX(string memory _char) private pure returns (bool) {
        if (keccak256(abi.encodePacked((_char))) == keccak256(abi.encodePacked(('X')))) {
            return true;
        } else if (keccak256(abi.encodePacked((_char))) == keccak256(abi.encodePacked(('x')))) {
            return true;
        } else {
            return false;
        }
    }
    
    // Function for appending 3 strings to a single string.
    // It is used for updating the value of the state variable, status.
    function append(string memory a, string memory b, string memory c) internal pure returns (string memory) {
        return string(abi.encodePacked(a, b, c));
    }
    
    // Function for converting the uint numbers from 0 to 9 into string format.
    function uintToString(uint _cell) private pure returns (string memory) {
        if (_cell == 0) {
            return "0";
        } else if (_cell == 1) {
            return "1";
        }  else if (_cell == 2) {
            return "2";
        }  else if (_cell == 3) {
            return "3";
        }  else if (_cell == 4) {
            return "4";
        }  else if (_cell == 5) {
            return "5";
        }  else if (_cell == 6) {
            return "6";
        }  else if (_cell == 7) {
            return "7";
        }  else if (_cell == 8) {
            return "8";
        }  else if (_cell == 9) {
            return "9";
        }  else {
            return "Invalid number";
        } 
    }

}