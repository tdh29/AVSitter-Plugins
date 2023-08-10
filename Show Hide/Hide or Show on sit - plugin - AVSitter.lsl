list sitters =[];

Sit()
{
    integer x;
    integer y = llGetNumberOfPrims();
    for(x=0;x<=y;x++)
    {
        list temp = llParseString2List(llGetLinkName(x),["#"],[""]);
        if(llList2String(temp,0)=="Sit")
        {
            integer A=1;
            for(A=1;A<llGetListLength(temp);A+=2)
            {
                integer B;
                string tempstring = llList2String(temp,A);
                if(tempstring=="-1")
                {
                    integer B = ALL_SIDES;
                }
                else B = (integer)tempstring;
                llSetLinkPrimitiveParamsFast(x,[PRIM_COLOR,B,<1,1,1>,((float)llList2String(temp,A+1))]);
            }
        }
        if(llList2String(temp,0)=="Stand")
        {
            llSetLinkPrimitiveParamsFast(x,[PRIM_COLOR,ALL_SIDES,<1,1,1>,0]);
        }
    }
}

Stand()
{
    integer x;
    integer y = llGetNumberOfPrims();
    for(x=0;x<=y;x++)
    {
        list temp = llParseString2List(llGetLinkName(x),["#"],[""]);
        if(llList2String(temp,0)=="Stand")
        {
            integer A=1;
            for(A=1;A<llGetListLength(temp);A+=2)
            {
                integer B;
                string tempstring = llList2String(temp,A);
                if(tempstring=="-1"||tempstring=="ALL_SIDES")
                {
                    integer B = ALL_SIDES;
                }
                else if(tempstring!="-1"&&tempstring!="ALL_SIDES")
                {
                    B = (integer)tempstring;
                }
                llSetLinkPrimitiveParamsFast(x,[PRIM_COLOR,B,<1,1,1>,((float)llList2String(temp,A+1))]);
            }
        }
        if(llList2String(temp,0)=="Sit")
        {
            llSetLinkPrimitiveParamsFast(x,[PRIM_COLOR,ALL_SIDES,<1,1,1>,0]);
        }
    }
}

    


default
{
    state_entry()
    {
        Stand();
    }
    
    
    link_message(integer sender, integer num, string msg, key id)
    {
        //llOwnerSay((string)sitter);
        //llOwnerSay((string)sender+", "+(string)num+", "+msg+", "+(string)id);
        list line = llParseString2List(msg,[":"],["|"]);
        string cmd = llList2String(line,0);
        //line = llParseString2List(cmd,[":"],[]);
        //cmd = llList2String(line,0);
        //llOwnerSay(cmd);
        if(num==90060)
        {
            sitters+=[id];
            Sit();
        }
        //remove people who stood up
        if(num==90065)
        {
            integer removal = llListFindList(sitters,[id]);
            sitters = llDeleteSubList(sitters,removal,removal);
            //If no one is sitting go to the up position
            if(llGetListLength(sitters)==0)
            {
                Stand();
            }
        }
    }
    
    //When rezzed
    on_rez(integer rez)
    {
        llResetScript();
    }
    
}
