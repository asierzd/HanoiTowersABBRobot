MODULE Module1
    VAR robtarget PosInicial:=[[494.257631407,0,518.999985739],[0.499999968,0,0.866025422,0],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    VAR robtarget PosInter:=[[409.924698869,0,249.772067785],[0.113624215,0,0.993523798,0],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    ! Replace 3 with the desired number of disks
    VAR num N := 5;  
    CONST num offPick := 20;
    ! Define tower positions
    ! starting pos
    CONST robtarget TargetPlace1:=[[1.819312748,1.104205791,0],[0,0,1,0],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    VAR num numDisksTP1 := 5;
    ! auxiliry pos
    CONST robtarget TargetPlace2:=[[0.285,0.624,0],[0,0,1,0],[0,0,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    VAR num numDisksTP2 := 0;
    ! target pos
    CONST robtarget TargetPlace3:=[[1.803,-0.41,0],[0,0,1,0],[-1,0,-1,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
    VAR num numDisksTP3 := 0;


    PROC main()
        ! Initialize the Tower of Hanoi with N disks
        towerOfHanoi N, TargetPlace1, TargetPlace3, TargetPlace2;
        MoveLDO PosInicial,v600,fine,MiAspiradorTool\WObj:=wobj0,hold,0;
    ENDPROC

    ! Procedure to move a disk from one position to another
    PROC moveDisk(robtarget fromPos, robtarget toPos)
        VAR num tCase := 1;
        
        IF ((fromPos.trans.x = TargetPlace1.trans.x) AND (fromPos.trans.y = TargetPlace1.trans.y) AND (fromPos.trans.z = TargetPlace1.trans.z)) AND ((toPos.trans.x = TargetPlace2.trans.x) AND (toPos.trans.y = TargetPlace2.trans.y) AND (toPos.trans.z = TargetPlace2.trans.z)) THEN
            tCase := 1;
        ELSEIF ((fromPos.trans.x = TargetPlace2.trans.x) AND (fromPos.trans.y = TargetPlace2.trans.y) AND (fromPos.trans.z = TargetPlace2.trans.z)) AND ((toPos.trans.x = TargetPlace3.trans.x) AND (toPos.trans.y = TargetPlace3.trans.y) AND (toPos.trans.z = TargetPlace3.trans.z)) THEN
            tCase := 2;
        ELSEIF ((fromPos.trans.x = TargetPlace1.trans.x) AND (fromPos.trans.y = TargetPlace1.trans.y) AND (fromPos.trans.z = TargetPlace1.trans.z)) AND ((toPos.trans.x = TargetPlace3.trans.x) AND (toPos.trans.y = TargetPlace3.trans.y) AND (toPos.trans.z = TargetPlace3.trans.z)) THEN
            tCase := 3;
        ELSEIF ((fromPos.trans.x = TargetPlace3.trans.x) AND (fromPos.trans.y = TargetPlace3.trans.y) AND (fromPos.trans.z = TargetPlace3.trans.z)) AND ((toPos.trans.x = TargetPlace2.trans.x) AND (toPos.trans.y = TargetPlace2.trans.y) AND (toPos.trans.z = TargetPlace2.trans.z)) THEN
            tCase := 4;
        ELSEIF ((fromPos.trans.x = TargetPlace2.trans.x) AND (fromPos.trans.y = TargetPlace2.trans.y) AND (fromPos.trans.z = TargetPlace2.trans.z)) AND ((toPos.trans.x = TargetPlace1.trans.x) AND (toPos.trans.y = TargetPlace1.trans.y) AND (toPos.trans.z = TargetPlace1.trans.z)) THEN
            tCase := 5;
        ELSEIF ((fromPos.trans.x = TargetPlace3.trans.x) AND (fromPos.trans.y = TargetPlace3.trans.y) AND (fromPos.trans.z = TargetPlace3.trans.z)) AND ((toPos.trans.x = TargetPlace1.trans.x) AND (toPos.trans.y = TargetPlace1.trans.y) AND (toPos.trans.z = TargetPlace1.trans.z)) THEN
            tCase := 6;
        ENDIF
        
        ! FROM SOURCE TO AUX; Case 1
        IF numDisksTP1 > 0 AND tCase = 1 THEN
            ! Ir a pos inicial
            MoveLDO PosInicial,v600,fine,MiAspiradorTool\WObj:=wobj0,hold,0;
            ! Ir a por disco
            MoveLDO Offs(fromPos,0,0,offPick*(numDisksTP1) + 3),v600,fine,MiAspiradorTool\WObj:=Place1,hold,1;
            WaitRob\InPos;
            WaitTime 1;
            ! Home position, intermedio
            MoveJ PosInter,v1000,fine,MiAspiradorTool\WObj:=wobj0;
            ! Dejar disco
            MoveLDO Offs(toPos,0,0,offPick*(numDisksTP2+1)+3),v600,fine,MiAspiradorTool\WObj:=Place2,hold,0;
            WaitRob\InPos;
            WaitTime 1;
            numDisksTP1 := numDisksTP1 - 1;
            numDisksTP2 := numDisksTP2 + 1;
            
        ! FROM AUX TO DEST; Case 2
        ELSEIF numDisksTP2 > 0 AND tCase = 2 THEN
            ! Ir a pos inicial
            MoveLDO PosInicial,v600,fine,MiAspiradorTool\WObj:=wobj0,hold,0;
            ! Ir a por disco
            MoveLDO Offs(fromPos,0,0,offPick*(numDisksTP2) + 3),v600,fine,MiAspiradorTool\WObj:=Place2,hold,1;
            WaitRob\InPos;
            WaitTime 1;
            ! Home position, intermedio
            MoveJ PosInter,v1000,fine,MiAspiradorTool\WObj:=wobj0;
            ! Dejar disco
            MoveLDO Offs(toPos,0,0,offPick*(numDisksTP3+1)+3),v600,fine,MiAspiradorTool\WObj:=Place3,hold,0;
            WaitRob\InPos;
            WaitTime 1;
            numDisksTP2 := numDisksTP2 - 1;
            numDisksTP3 := numDisksTP3 + 1;
            
        ! FROM SOURCE TO DESTINATION; Case 3
        ELSEIF numDisksTP1 > 0 AND tCase = 3 THEN
            MoveLDO PosInicial,v600,fine,MiAspiradorTool\WObj:=wobj0,hold,0;
            ! Ir a por disco
            MoveLDO Offs(fromPos,0,0,offPick*(numDisksTP1) + 3),v600,fine,MiAspiradorTool\WObj:=Place1,hold,1;
            WaitRob\InPos;
            WaitTime 1;
            ! Home position, intermedio
            MoveJ PosInter,v1000,fine,MiAspiradorTool\WObj:=wobj0;
            ! Dejar disco
            MoveLDO Offs(toPos,0,0,offPick*(numDisksTP3+1)+3),v600,fine,MiAspiradorTool\WObj:=Place3,hold,0;
            WaitRob\InPos;
            WaitTime 1;
            numDisksTP1 := numDisksTP1 - 1;
            numDisksTP3 := numDisksTP3 + 1;
            
        ! FROM DEST TO AUX; Case 4
        ELSEIF numDisksTP3 > 0 AND tCase = 4 THEN
            MoveLDO PosInicial,v600,fine,MiAspiradorTool\WObj:=wobj0,hold,0;
            ! Ir a por disco
            MoveLDO Offs(fromPos,0,0,offPick*(numDisksTP3) + 3),v600,fine,MiAspiradorTool\WObj:=Place3,hold,1;
            WaitRob\InPos;
            WaitTime 1;
            ! Home position, intermedio
            MoveJ PosInter,v1000,fine,MiAspiradorTool\WObj:=wobj0;
            ! Dejar disco
            MoveLDO Offs(toPos,0,0,offPick*(numDisksTP2+1)+3),v600,fine,MiAspiradorTool\WObj:=Place2,hold,0;
            WaitRob\InPos;
            WaitTime 1;
            numDisksTP3 := numDisksTP3 - 1;
            numDisksTP2 := numDisksTP2 + 1;
            
        ! FROM AUX TO SOURCE; Case 5
        ELSEIF numDisksTP2 > 0 AND tCase = 5 THEN
            MoveLDO PosInicial,v600,fine,MiAspiradorTool\WObj:=wobj0,hold,0;
            ! Ir a por disco
            MoveLDO Offs(fromPos,0,0,offPick*(numDisksTP2) + 3),v600,fine,MiAspiradorTool\WObj:=Place2,hold,1;
            WaitRob\InPos;
            WaitTime 1;
            ! Home position, intermedio
            MoveJ PosInter,v1000,fine,MiAspiradorTool\WObj:=wobj0;
            ! Dejar disco
            MoveLDO Offs(toPos,0,0,offPick*(numDisksTP1+1)+3),v600,fine,MiAspiradorTool\WObj:=Place1,hold,0;
            WaitRob\InPos;
            WaitTime 1;
            numDisksTP2 := numDisksTP2 - 1;
            numDisksTP1 := numDisksTP1 + 1;
            
        ! FROM DEST TO SOURCE; Case 6
        ELSEIF numDisksTP3 > 0 AND tCase = 6 THEN
            MoveLDO PosInicial,v600,fine,MiAspiradorTool\WObj:=wobj0,hold,0;
            ! Ir a por disco
            MoveLDO Offs(fromPos,0,0,offPick*(numDisksTP3) + 3),v600,fine,MiAspiradorTool\WObj:=Place3,hold,1;
            WaitRob\InPos;
            WaitTime 1;
            ! Home position, intermedio
            MoveJ PosInter,v1000,fine,MiAspiradorTool\WObj:=wobj0;
            ! Dejar disco
            MoveLDO Offs(toPos,0,0,offPick*(numDisksTP1+1)+3),v600,fine,MiAspiradorTool\WObj:=Place1,hold,0;
            WaitRob\InPos;
            WaitTime 1;
            numDisksTP3 := numDisksTP3 - 1;
            numDisksTP1 := numDisksTP1 + 1;
        ENDIF
        
    ENDPROC
    
    ! Recursive function to solve Tower of Hanoi
    PROC towerOfHanoi(num numb, robtarget source, robtarget destination, robtarget auxiliary)
            
        IF numb > 0 THEN
            towerOfHanoi numb-1, source, auxiliary, destination;
            moveDisk source, destination;
            towerOfHanoi numb-1, auxiliary, destination, source;
        ENDIF
            
    ENDPROC
    
ENDMODULE