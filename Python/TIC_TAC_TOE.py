#Nombre: Arellano Ochoa Daniel Ignacio 
#No. de control: 19141118
import enum
import os
class Seed(enum.Enum):
    CRUZ = 'X'#3
    CIRCULO = 'O'#5
    VACIO = ' '#2

    def __init__(self, icon):#str
        self.icon = icon
        self.valor = 0
        if icon == 'X': self.valor = 3
        elif icon == 'O': self.valor = 5
        elif icon == ' ': self.valor = 2

class State(enum.Enum):
    PLAYING = 4
    DRAW = 3
    CRUZ_GANA = 2
    CIRCULO_GANA = 1

class Cell():
    def __init__(self, posicion):#int
        self.posicion = posicion
        self.content = Seed.VACIO
    
    def newGame(self):
        self.content = Seed.VACIO
        self.valor = 2
    
    def paint(self):
        if(self.content != Seed.VACIO): return self.content.icon
        else: return (self.posicion + 1)

class Board():
    TABLERO = 9
    def __init__(self):  
        self.cells = []
        for x in range(self.TABLERO):
            self.cells.append(Cell(x))
    
    def newGame(self):
        for x in range(self.TABLERO):
            self.cells[x].newGame()
    
    def stepGame(self, player, selectedPosi):#Seed, int
        wins = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
        self.cells[selectedPosi].content = player

        for win in wins:
            if(self.cells[win[0]].content == self.cells[win[1]].content == self.cells[win[2]].content == Seed.CRUZ):# gana X
                return State.CRUZ_GANA
            elif(self.cells[win[0]].content == self.cells[win[1]].content == self.cells[win[2]].content == Seed.CIRCULO): # gana O
                return State.CIRCULO_GANA

        for cell in self.cells:
            if(cell.content == Seed.VACIO): return State.PLAYING
        return State.DRAW # nadie ha ganado aun

    def paint(self):
        #print('\n')
        os.system('CLS')
        print(f" {self.cells[0].paint()} | {self.cells[1].paint()} | {self.cells[2].paint()} ")
        print(f"---|---|---")
        print(f" {self.cells[3].paint()} | {self.cells[4].paint()} | {self.cells[5].paint()} ")
        print(f"---|---|---")
        print(f" {self.cells[6].paint()} | {self.cells[7].paint()} | {self.cells[8].paint()} ")
    ###################################################
    #Regresa la posicion en la que el jugador player puede ganar, en caso de que no pueda regresa -1
    def poswin(self,player): #Seed
        wins = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
        
        if(player == Seed.CRUZ):
            for win in wins:
                if(self.cells[win[0]].content.valor * self.cells[win[1]].content.valor * self.cells[win[2]].content.valor == 18): 
                    if(self.cells[win[0]].content.valor == 2): return (win[0])
                    elif(self.cells[win[1]].content.valor == 2): return (win[1])
                    elif(self.cells[win[2]].content.valor == 2): return (win[2])
        elif(player == Seed.CIRCULO):
            for win in wins:
                if(self.cells[win[0]].content.valor * self.cells[win[1]].content.valor * self.cells[win[2]].content.valor == 50): 
                    if(self.cells[win[0]].content.valor == 2): return (win[0])
                    elif(self.cells[win[1]].content.valor == 2): return (win[1])
                    elif(self.cells[win[2]].content.valor == 2): return (win[2])
        return -1
    
class GameMain():
    def __init__(self):
        self.board = Board()
        self.board.newGame()
        self.currentPlayer = Seed.CRUZ
        self.currentState = State.PLAYING
        self.turno = 1
        self.jugador = Seed.CRUZ if(int(input('1.-Primero -> X \n2.-Segundo -> O  \nElige tu turno: ')) == 1) else Seed.CIRCULO
        self.computador = Seed.CIRCULO if(self.jugador == Seed.CRUZ) else Seed.CRUZ

        self.board.paint()

        while(self.currentState == State.PLAYING):
            if self.currentPlayer == self.jugador :self.stepGame()
            else: self.algoritmoComputador()

            self.board.paint()
            if(self.currentState == State.CRUZ_GANA): print('COMPUTADOR GANA!!!') if(self.computador == Seed.CRUZ) else print('JUGADOR GANA!!!')
            elif(self.currentState == State.CIRCULO_GANA): print('COMPUTADOR GANA!!!') if(self.computador == Seed.CIRCULO) else print('JUGADOR GANA!!!')
            elif(self.currentState == State.DRAW): print('DRAW!!!')
            self.currentPlayer = Seed.CIRCULO if (self.currentPlayer == Seed.CRUZ) else Seed.CRUZ

    #tiro del jugador
    def stepGame(self):
        validInput = False
        while(not validInput):
            icon = self.currentPlayer.icon
            posicion = int(input('Player ' + icon + ' enter your move [1-9]: '))
            posicion = posicion - 1
            if(posicion >= 0 and posicion <=8 and self.board.cells[posicion].content == Seed.VACIO):
                self.currentState = self.board.stepGame(self.currentPlayer, posicion)
                validInput = True
            else:
                print('This move is not valid. Try again...')
        self.turno = self.turno + 1

    ##############################################
    #Tiro del computador en n posicion, no verifica si esta ocupado 
    def go(self, n):#int
        self.currentState = self.board.stepGame(self.currentPlayer,n)
        self.turno = self.turno + 1

    #Algoritmo 2
    def algoritmoComputador(self):
        if self.computador == Seed.CRUZ : #Pasos 1 3 5 7 9
            if self.turno == 1: self.go(0)
            elif self.turno == 3:
                if self.board.cells[4].content == Seed.VACIO: self.go(4)
                else: self.go(2)
            elif self.turno == 5:
                if self.board.poswin(self.computador) != -1: self.go(self.board.poswin(self.computador))
                elif self.board.poswin(self.jugador) != -1: self.go(self.board.poswin(self.jugador))
                elif self.board.cells[6].content == Seed.VACIO: self.go(6)
                else: self.go(2)
            elif self.turno == 7 or self.turno == 9:
                if self.board.poswin(self.computador) != -1: self.go(self.board.poswin(self.computador))
                elif self.board.poswin(self.jugador) != -1: self.go(self.board.poswin(self.jugador))
                else:
                    for x in range(len(self.board.cells)):
                        if self.board.cells[x].content == Seed.VACIO: self.go(x)
        elif self.computador == Seed.CIRCULO: #Pasos 2 4 6 8
            if self.turno == 2:
                if self.board.cells[4].content == Seed.VACIO: self.go(4)
                else: self.go(0)
            elif self.turno == 4:
                if self.board.poswin(self.jugador) != -1: self.go(self.board.poswin(self.jugador))
                else: self.make2()
            elif self.turno == 6:
                if self.board.poswin(self.computador) != -1: self.go(self.board.poswin(self.computador))
                elif self.board.poswin(self.jugador) != -1: self.go(self.board.poswin(self.jugador))
                else: self.make2()
            elif self.turno == 8:
                if self.board.poswin(self.computador) != -1: self.go(self.board.poswin(self.computador))
                elif self.board.poswin(self.jugador) != -1: self.go(self.board.poswin(self.jugador))
                else: 
                    for x in range(len(self.board.cells)):
                        if self.board.cells[x].content == Seed.VACIO: self.go(x)
    
    def make2(self): 
        if self.trampa() != -1:self.go(self.trampa())
        elif self.board.cells[4].content == Seed.VACIO: self.go(4)
        elif self.board.cells[0].content == Seed.VACIO: self.go(0)
        else:
            for x in range(len(self.board.cells)):
                        if self.board.cells[x].content == Seed.VACIO: self.go(x)
    
    #regresa -1 si no hay trampa, en caso contrario regresa la movida para evitarla
    def trampa(self):
        if(self.trampaEsquinas() != -1): return self.trampaEsquinas()
        elif(self.trampaL() != -1): return self.trampaL()
        elif(self.trampaDiagonal != -1): return self.trampaDiagonal()
        return -1

    def trampaEsquinas(self):
        if((self.board.cells[0].content == self.board.cells[2].content == self.jugador) or
        (self.board.cells[0].content == self.board.cells[6].content == self.jugador) or
        (self.board.cells[0].content == self.board.cells[8].content == self.jugador) or
        (self.board.cells[2].content == self.board.cells[6].content == self.jugador) or
        (self.board.cells[2].content == self.board.cells[8].content == self.jugador) or
        (self.board.cells[6].content == self.board.cells[8].content == self.jugador) ):
            if self.board.cells[1].content == Seed.VACIO: return 1
            elif self.board.cells[3].content == Seed.VACIO: return 3
            elif self.board.cells[5].content == Seed.VACIO: return 5
            elif self.board.cells[7].content == Seed.VACIO: return 7
        return -1
    
    def trampaL(self):
        if(self.board.cells[0].content == self.board.cells[5].content == self.jugador): return 2
        elif(self.board.cells[0].content == self.board.cells[7].content == self.jugador): return 6
        elif(self.board.cells[1].content == self.board.cells[6].content == self.jugador): return 0
        elif(self.board.cells[1].content == self.board.cells[8].content == self.jugador): return 2
        elif(self.board.cells[2].content == self.board.cells[3].content == self.jugador): return 0
        elif(self.board.cells[2].content == self.board.cells[7].content == self.jugador): return 8
        elif(self.board.cells[3].content == self.board.cells[2].content == self.jugador): return 0
        elif(self.board.cells[3].content == self.board.cells[8].content == self.jugador): return 6
        elif(self.board.cells[5].content == self.board.cells[0].content == self.jugador): return 2
        elif(self.board.cells[5].content == self.board.cells[6].content == self.jugador): return 8
        elif(self.board.cells[6].content == self.board.cells[1].content == self.jugador): return 0
        elif(self.board.cells[6].content == self.board.cells[5].content == self.jugador): return 8
        elif(self.board.cells[7].content == self.board.cells[0].content == self.jugador): return 6
        elif(self.board.cells[7].content == self.board.cells[2].content == self.jugador): return 8
        elif(self.board.cells[8].content == self.board.cells[1].content == self.jugador): return 2
        elif(self.board.cells[8].content == self.board.cells[3].content == self.jugador): return 6
        return -1

    def trampaDiagonal(self):
        if((self.board.cells[4].content == self.board.cells[2].content == self.jugador) or
        (self.board.cells[4].content == self.board.cells[6].content == self.jugador) or
        (self.board.cells[4].content == self.board.cells[8].content == self.jugador)):
            if self.board.cells[2].content == Seed.VACIO: return 2
            elif self.board.cells[6].content == Seed.VACIO: return 6
        return -1



opcion = True
while(opcion):
    GameMain()    
    opcion = True if(int(input('Game Over !!! <\nRetry?\n1.-yes \n2.-no \n->')) == 1) else False 
#terminado