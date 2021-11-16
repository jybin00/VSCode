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
        self.dir_x = 0
        self.dir_y = 0
        self.detecting_obstacle = []
        self.NOC = 0 # 배터리 충전 횟수
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
        x = self.position.x
        y = self.position.y
        right_side = 1
        left_side = -1
        upside = -1
        downside = 1
        battery = self._fuel

        D_req_E = self.detecting_obstacle
        D_req_E = [(grid_map.map[y][x].req_energy), # current location
                   (grid_map.map[y][min(x+1, 16)].req_energy), # east
                   (grid_map.map[y][max(x-1, 0)].req_energy),  # west
                   (grid_map.map[min(y+1, 16)][x].req_energy), # south
                   (grid_map.map[max(y-1, 0)][x].req_energy)]  # north
        
        def battery_charge():
            print("moving for charge!")
            self.mode = MOVE
            if x == 8 and y == 8:
                print("battery charged")
                self.mode = CHAR
                self.NOC = self.NOC + 1
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
            if x < 8:
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
            else:
                if y > 8: 
                    if D_req_E[4] != inf: self.dir_x, self.dir_y = 0, upside
                    else: self.dir_x, self.dir_y = right_side, 0
                if y < 8:
                    if D_req_E[3] != inf: self.dir_x, self.dir_y = 0, downside
                    else: self.dir_x, self.dir_y = right_side, 0
                    
                    

        self.max_h = grid_map.height - 1
        self.max_w = grid_map.width - 1
        print("현재 위치 x: {}, y: {}".format(str(x),str(y)))     
            
#처음 시작 및 충전 후에        
        def cleaning():
            print("battery: {}".format(battery))   
            if self.mode == STAY or CHAR:
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
                    if self.mode == CHAR:
                        self.dir_x, self.dir_y = 0, downside
                        if D_req_E[0] == 0: self.mode = MOVE
                        else: self.mode = CLEN
                    else : self.dir_x, self.dir_y = left_side, 0
                    if D_req_E[0] == 0: self.mode = MOVE
                    else: self.mode = CLEN
# Each corner             
            if x == 0 and y == 0:
                print("left top corner!")
                self.dir_x = right_side
                self.dir_y = 0
                if D_req_E[0] == 0:
                    self.mode = MOVE
                else:
                    self.mode = CLEN
                    
            if x == 16 and y == 0:
                print("right top corner!")
                self.dir_x = 0
                self.dir_y = downside
                if D_req_E[0] == 0:
                    self.mode = MOVE
                else:
                    self.mode = CLEN
                    
            if x == 0 and y == 16:
                print("left down corner!")
                self.dir_x = 0
                self.dir_y = upside
                if D_req_E[0] == 0:
                    self.mode = MOVE
                else:
                    self.mode = CLEN
            if x == 16 and y == 16:
                print("right down corner!")
                self.dir_x = left_side
                self.dir_y = 0
                if D_req_E[0] == 0:
                    self.mode = MOVE
                else:
                    self.mode = CLEN

# Each line            
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
                    
            if x == 16 and y > 0 and y < 16: # 오른쪽 끝까지 갔지만 모서리는 아닐 때
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
                        
            if y == 0 and x > 0 and x < 16: # 위쪽 끝까지 갔지만 모서리는 아닐 때
                if D_req_E[2] == inf: # 왼쪽에 장애물이 있으면 아래로
                    print("downside required energy is inf!")
                    self.dir_x = 0
                    self.dir_y = downside
                    if D_req_E[0] == 0:
                        self.mode = MOVE
                    else:
                        self.mode = CLEN
                if D_req_E[1] == inf: # 오른쪽에 장애물이 있으면 아래쪽으로
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
            
            if y == 16 and x > 0 and x < 16: # 아래쪽으로 끝까지 갔지만 모서리는 아닐 때
                if D_req_E[2] == inf: # 왼쪽에 장애물이 있으면 위쪽으로
                    print("downside required energy is inf!")
                    self.dir_x = upside
                    self.dir_y = 0
                    if D_req_E[0] == 0:
                        self.mode = MOVE
                    else:
                        self.mode = CLEN
                if D_req_E[1] == inf: # 오른쪽에 장애물이 있으면 왼쪽으로
                    print("upside required energy is inf!")
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

        if battery < 200:
            if self.NOC == 3:
                cleaning()
            else:
                print("battery: {}".format(battery))
                battery_charge()
        else: cleaning() 
        
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

