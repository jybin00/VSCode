from typing import List
from math import inf
from SBSim import (
    VacuumCleaner,
    STAY,
    MOVE,
    CLEN,
    CHAR,
)
from SBSim.base import UserMap
'''
    WARNING
    Do not change def name, arguments and return.
    ---
'''

class UserRobot(VacuumCleaner):
    def __init__(
        self,
        fuel: int = 100,
        energy_consumption: int = 10,
        move_consumption: int = 10,
        postion: List[int] = ...,
        vision_sight: int = 2
    ) -> None:
        super().__init__(
            fuel=fuel,
            energy_consumption=energy_consumption, 
            move_consumption=move_consumption,
            postion=postion, 
            vision_sight=vision_sight
        )
        '''
            If you want to store some values, define your variables here.
            Using `self`-based variables, you can re-call the value of previous state easily.
        '''
        self.last_x = [] # 경로 저장을 위한 변수
        self.last_y = []
        self.detecting_obstacle = [] 
        self.NOC = 0 # 배터리 충전 횟수
        self.map = [[0 for i in range(17)]for j in range(17)]
        self.backtowork = 0
        self.isstart = 0
    def algorithms( self, grid_map: UserMap ):
        
        '''
            You can code your algorithm using robot.position and map.information. The following
            introduces accessible data; 1) the position of robot, 2) the information of simulation
            map.

            Here, you should build an algorithm that determines the next action of 
            the robot.

            Robot::
                - position (list-type) : (x, y)
                - mode (int-type) ::
                    You can determine robot state using 'self.mode', and we provide 4-state.
                    (STAY, MOVE, CLEN, CHAR)
                    Example::
                        1) You want to move the robot to target position.
                        >>> self.mode = MOVE
                        2) Clean-up tail.
                        >>> self.mode = CLEN
            
            map::
                - grid_map :
                    grid_map.height : the value of height of map.
                        Example::
                            >>> print( grid_map.height )

                    grid_map.width : the value of width of map.
                        Example::
                            >>> print( grid_map.width )

                    grid_map[ <height/y> ][ <width/x> ] : the data of map, it consists of 2-array.
                        - grid_map[<h>][<w>].req_energy : the minimum energy to complete cleaning.
                            It is assigned randomly, and it is int-type data.
                        - grid_map[<h>][<w>].charger : is there a charger in this tile? boolean-type data.
                        Example::
                            >>> x = self.position.x
                            >>> y = self.position.y
                            >>> print( grid_map[y][x].req_energy )
                            >>> if grid_map[y][x].req_energy > 0:
                            >>>     self.mode = CLEN

            Tip::
                - Try to avoid loop-based codes such as `while` as possible. It will make the problem harder to solve.
        '''
        #### Code Here! ####
        
        #THIS IS AN EXAMPLE CODE. DELETE THIS CODE SEGMENT BEFORE YOU START YOUR OWN CODE.
        #START OF EXAMPLE CODE

        # Default information from robot and env.
        x = self.position.x # 현재 위치 x
        y = self.position.y # 현재 위치 y
        right_side, left_side = 1, -1
        upside, downside = -1, 1
        battery = self._fuel
        map = self.map

        D_req_E = self.detecting_obstacle
        D_req_E = [(grid_map.map[y][x].req_energy), # current location
                   (grid_map.map[y][min(x+1, 16)].req_energy), # east
                   (grid_map.map[y][max(x-1, 0)].req_energy),  # west
                   (grid_map.map[min(y+1, 16)][x].req_energy), # south
                   (grid_map.map[max(y-1, 0)][x].req_energy)]  # north
        
        def cleaning():
            print("cleaning...")
            if self.backtowork == 1:
                back_to_field()
            else:
                if D_req_E[1] == inf:
                    map[y][x+1] = 2
                if D_req_E[2] == inf:
                    map[y][x-1] = 2
                if D_req_E[3] == inf:
                    map[y+1][x] = 2
                if D_req_E[4] == inf:
                    map[y-1][x] = 2
                    
                map[y][x] = 1
                if map[y][min(x+1,16)] == 1 and map[max(y-1,0)][x] != 2 and map[max(y-1,0)][x] != 1: # if right block was visited or there is any obstacle, go upside
                    self.dir_x, self.dir_y = 0, upside
                    print("upside")
                elif map[max(y-1,0)][x] == 1 and map[y][max(x-1,0)] != 2 and map[y][max(x-1,0)] != 1 : # if upside block was visited or there is any obstacle, go leftside
                    self.dir_x, self.dir_y = left_side, 0
                    print("leftside")
                elif map[y][max(x-1,0)] == 1 and map[min(y+1,16)][x] != 2 and map[min(y+1,16)][x] != 1: # if left block was visited or there is any obstacle, go downside
                    self.dir_x, self.dir_y = 0, downside
                    print("downside")
                elif map[min(y+1,16)][x] == 1 and map[y][min(x+1,16)] != 2 and map[y][min(x+1,16)] != 1: # if downside block was visited or there is any obstacle, go rightside
                    self.dir_x, self.dir_y = right_side, 0
                    print("right")
                else:
                    if map[y][max(x-1,0)] == 2 and map[min(y+1,16)][x] != 2: # if left block was visited or there is any obstacle, go downside
                        self.dir_x, self.dir_y = 0, downside
                    elif map[y][min(x+1,16)] == 2 and map[max(y-1,0)][x] != 2: # if right block was visited or there is any obstacle, go upside
                        self.dir_x, self.dir_y = 0, upside
                    elif map[max(y-1,0)][x] == 2 and map[y][max(x-1,0)] != 2: # if upside block was visited or there is any obstacle, go leftside
                        self.dir_x, self.dir_y = left_side, 0
                    elif map[min(y+1,16)][x] == 2 and map[y][min(x+1,16)] != 2: # if downside block was visited or there is any obstacle, go rightside
                        self.dir_x, self.dir_y = right_side, 0
                if D_req_E[0] == 0:
                    self.mode = MOVE
                else : self.mode = CLEN
                print("1") 
                
        def battery_charge():
            print("moving for charge!")
            if x > 8:
                if y > 8:
                    if D_req_E[2] != inf:
                        self.dir_x, self.dir_y = left_side, 0
                    else:
                        self.dir_x, self.dir_y = 0, upside
                else:
                    if D_req_E[2] != inf:
                        self.dir_x, self.dir_y = left_side, 0
                    else:
                        self.dir_x, self.dir_y = 0, downside  
            elif x < 8:
                if y > 8:
                    if D_req_E[1] != inf:
                        self.dir_x, self.dir_y = right_side, 0
                    else:
                        self.dir_x, self.dir_y = 0, upside
                else:
                    if D_req_E[1] != inf:
                        self.dir_x, self.dir_y = right_side, 0
                    else:
                        self.dir_x, self.dir_y = 0, downside
            elif x == 8:
                if y > 8: 
                    if D_req_E[4] != inf: self.dir_x, self.dir_y = 0, upside
                    else: self.dir_x, self.dir_y = right_side, 0
                elif y < 8:
                    if D_req_E[3] != inf: self.dir_x, self.dir_y = 0, downside
                    else: self.dir_x, self.dir_y = right_side, 0
                else:
                    self.mode = CHAR
                    print("battery charged")
                    if battery == 3000:
                        self.NOC = self.NOC + 1
                        self.backtowork = 1
            self.last_x.append(x)
            self.last_y.append(y)
            if self.mode == CHAR:
                self.mode = self.mode
            else:
                self.mode = MOVE
                print("2")
            
        def back_to_field():
            print("back to the last position")
            for i in (0, len(self.last_x)):
                past_x = self.last_x.pop()
                past_y = self.last_y.pop()
                self.dir_x = past_x - x
                self.dir_y = past_y - y
                self.mode = MOVE
                print("3")
            self.backtowork = 0
                
        def start():
            print("start!")   
            map[y][x] = 1
            if self.mode == STAY:
                print("this car is staying...")
                if D_req_E[3] == inf:
                    print("downside required energy is inf!")
                    self.dir_x, self.dir_y = 0, upside
                    if D_req_E[0] == 0: self.mode = MOVE
                    else: self.mode = CLEN
                    
                elif D_req_E[4] == inf:
                    print("upside required energy is inf!")
                    self.dir_x, self.dir_y = 0, downside
                    if D_req_E[0] == 0: self.mode = MOVE
                    else: self.mode = CLEN
                    
                elif D_req_E[1] == inf:
                    print("rightside required energy is inf!")
                    self.dir_x, self.dir_y = left_side, 0
                    if D_req_E[0] == 0: self.mode = MOVE
                    else: self.mode = CLEN
                    
                elif D_req_E[2] == inf:
                    print("leftside required energy is inf!")
                    self.dir_x = right_side
                    self.dir_y = 0
                    if D_req_E[0] == 0: self.mode = MOVE
                    else: self.mode = CLEN
                    
                else:
                    print("there are not any obstacles!")
                    self.dir_x, self.dir_y = left_side, 0 # 첫 출발에 아무 장애물도 없으면 왼쪽으로. 
                    if D_req_E[0] == 0: self.mode = MOVE
                    else: self.mode = CLEN
            self.isstart = 1
            print("3")
# Each corner     
        def corner():    
            if x == 0 and y == 0:
                print("left top corner!")
                self.dir_x = right_side
                self.dir_y = 0
                if D_req_E[0] == 0:
                    self.mode = MOVE
                else:
                    self.mode = CLEN
                    
            elif x == 16 and y == 0:
                print("right top corner!")
                self.dir_x = 0
                self.dir_y = downside
                if D_req_E[0] == 0:
                    self.mode = MOVE
                else:
                    self.mode = CLEN
                    
            elif x == 0 and y == 16:
                print("left down corner!")
                self.dir_x = 0
                self.dir_y = upside
                if D_req_E[0] == 0:
                    self.mode = MOVE
                else:
                    self.mode = CLEN
            elif x == 16 and y == 16:
                print("right down corner!")
                self.dir_x = left_side
                self.dir_y = 0
                if D_req_E[0] == 0:
                    self.mode = MOVE
                else:
                    self.mode = CLEN
            print("4")

# Each line      
        def line():      
            if x == 0 and y > 0 and y < 16: # 왼쪽 끝이지만 모서리는 아닐 때
                if D_req_E[3] == inf: # 아래쪽에 장애물이 있으면 위로
                    print("downside required energy is inf!")
                    self.dir_x = 0
                    self.dir_y = upside
                    if D_req_E[0] == 0:
                        self.mode = MOVE
                    else:
                        self.mode = CLEN
                elif D_req_E[4] == inf: # 위쪽에 장애물이 있으면 오른쪽으로
                    print("upside required energy is inf!")
                    self.dir_x = right_side
                    self.dir_y = 0
                    if D_req_E[0] == 0:
                        self.mode = MOVE
                    else:
                        self.mode = CLEN
                else: #아무것도 없으면 위쪽으로 
                    self.dir_x = 0
                    self.dir_y = upside
                    if D_req_E[0] == 0:
                        self.mode = MOVE
                    else:
                        self.mode = CLEN
                    
            elif x == 16 and y > 0 and y < 16: # 오른쪽 끝까지 갔지만 모서리는 아닐 때
                if D_req_E[3] == inf: # 아래쪽에 장애물이 있으면 왼쪽으로
                    print("downside required energy is inf!")
                    self.dir_x = left_side
                    self.dir_y = 0
                    if D_req_E[0] == 0:
                        self.mode = MOVE
                    else:
                        self.mode = CLEN
                elif D_req_E[4] == inf: # 위쪽에 장애물이 있으면 왼쪽으로
                    print("upside required energy is inf!")
                    self.dir_x = left_side
                    self.dir_y = 0
                    if D_req_E[0] == 0:
                        self.mode = MOVE
                    else:
                        self.mode = CLEN
                else:
                    print("there are not any obstacle.") # 장애물 없으면 아래로.
                    self.dir_x = 0
                    self.dir_y = downside
                    if D_req_E[0] == 0:
                        self.mode = MOVE
                    else:
                        self.mode = CLEN
                        
            elif y == 0 and x > 0 and x < 16: # 위쪽 끝까지 갔지만 모서리는 아닐 때
                if D_req_E[2] == inf: # 왼쪽에 장애물이 있으면 아래로
                    print("downside required energy is inf!")
                    self.dir_x = 0
                    self.dir_y = downside
                    if D_req_E[0] == 0:
                        self.mode = MOVE
                    else:
                        self.mode = CLEN
                elif D_req_E[1] == inf: # 오른쪽에 장애물이 있으면 아래쪽으로
                    print("upside required energy is inf!")
                    self.dir_x = 0
                    self.dir_y = downside
                    if D_req_E[0] == 0:
                        self.mode = MOVE
                    else:
                        self.mode = CLEN          
                else:
                    self.dir_x = right_side # 아무것도 없으면 오른쪽으로
                    self.dir_y = 0
                    if D_req_E[0] == 0:
                        self.mode = MOVE
                    else:
                        self.mode = CLEN
            
            elif y == 16 and x > 0 and x < 16: # 아래쪽으로 끝까지 갔지만 모서리는 아닐 때
                if D_req_E[2] == inf: # 왼쪽에 장애물이 있으면 위쪽으로
                    print("leftside required energy is inf!")
                    self.dir_x = 0
                    self.dir_y = upside
                    if D_req_E[0] == 0:
                        self.mode = MOVE
                    else:
                        self.mode = CLEN
                elif D_req_E[1] == inf: # 오른쪽에 장애물이 있으면 왼쪽으로
                    print("rightside required energy is inf!")
                    self.dir_x = left_side
                    self.dir_y = 0
                    if D_req_E[0] == 0:
                        self.mode = MOVE
                    else:
                        self.mode = CLEN   
                else:
                    self.dir_x = left_side
                    self.dir_y = 0
                    if D_req_E[0] == 0:
                        self.mode = MOVE
                    else:
                        self.mode = CLEN   
            print("5") 
            
        def detecting_edge():
            if x == 0 or x == 16 or y == 0 or y == 16:
                corner()
                line()   
            print("6") 

        if battery < 300:
            print("battery is not enough")
            if self.NOC == 3:
                print("we've done our chance to charge the battery")
                cleaning()
            else:
                print("battery: {}".format(battery))
                battery_charge()
        elif self.NOC == 0:
            if self.isstart == 0:
                start()
            cleaning()
        else:
            cleaning()
            detecting_edge()
        
        new_x = x + self.dir_x
        new_y = y + self.dir_y
        print("new_x : {}, new_y : {}".format(new_x, new_y))
        #END OF EXAMPLE CODE

        ######################

        ##### DO NOT CHANGE RETURN VARIABLES! #####
        ## The below codes are fixed. The users only determine the mode and/or the next position (coordinate) of the robot.
        ## Therefore, you need to match the variables of return to simulate.
        (new_x, new_y) = self.tunning( [new_x, new_y] )
        return (new_x, new_y)

