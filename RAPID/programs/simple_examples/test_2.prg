%%%
VERSION:1
LANGUAGE:ENGLISH
%%%

MODULE TEST_2
PERS tooldata TD_tool0:=[TRUE,[[0,0,0],[1,0,0,0]],[0,[0,0,0],[1,0,0,0],0,0,0]];

!initial position
JV_q0=[0 0 0 0 0 0]';
!target points
CONST robtarget RT_tp1:=[[300,9,1020],[0.2175,0.0971,-0.0689,0.9688],[1,0,0,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
CONST robtarget RT_tp2:=[[715,-200,512],[0.7071,0,0.7071,0],[-1,-1,0,0],[9E9,9E9,9E9,9E9,9E9,9E9]];
CONST robtarget RT_tp3:=[[800,0,300],[0.7071,0,0.7071,0],[-1,-1,0,0],[9E9,9E9,9E9,9E9,9E9,9E9]];


PROC main()

ConfJ \Off;
ConfL \Off;


!The MoveAbsJ function performs a joint coordinate planning to the
!specified joint values
 MoveAbsJ(JV_q0, 'vmax' , 'fine' , TD_tool0, 'wobj0');
 MoveJ    RT_tp1  ,vmax    ,fine    ,TD_tool0\WObj:=wobj0   ;
 MoveJ    RT_tp2  ,vmax    ,fine    ,TD_tool0\WObj:=wobj0   ;
 MoveL    RT_tp1  ,vmax    ,fine    ,TD_tool0\WObj:=wobj0;
 MoveL    RT_tp2  ,vmax    ,fine    ,TD_tool0\WObj:=wobj0;
!Return to tp1
 MoveJ    RT_tp1  ,vmax    ,fine    ,TD_tool0\WObj:=wobj0   ;

 MoveC    RT_tp2  ,RT_tp3  ,vmax    ,fine    ,TD_tool0\WObj:=TD_tool0;

!use the Offs function to move relative to tp1
! The Offs function makes a relative displacement in X, Y and Z directions
!Please note that, by using Offs, the specified axes configuration may
!differ from the one specified in tp1.
 MoveJ    Offs    (RT_tp1  ,100,0,100),vmax    ,fine    ,TD_tool0\WObj:=wobj0   ;

!use MoveL inside a Loop, moving incrementally
 FOR i   FROM 1   TO 4    DO
     MoveL    Offs    (RT_tp1  ,100,0,100),0.2     ,vmax    ,fine    \WObj:=wobj0   ;
 ENDFOR

ENDPROC

ENDMODULE