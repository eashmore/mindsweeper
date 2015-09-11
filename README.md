#Minesweeper
This is the classic game of Minesweeper, written in Ruby. Uncover all the tiles without setting off any bombs. This game is played using the command line.

This game is a work in progress. Goals include improving board aesthetics and improving UI.

'*' represents an undiscovered tile

'-' represents a discovered tile

'X' represents a bomb

###Installing and Playing
Download the repository. From the command line, navigate to:

```
minesweeper/lib
```


Run the command:

```
ruby minesweeper.rb
```


Input coordinates as:

```
What's your move? > x,y
```

To save your game, input:

```
What's your move? > save
```

To load a previously saved game, run the command:

```
ruby minesweeper.rb load
```
