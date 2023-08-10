string object;
key owner;
list sitters;
integer start_param =102;
list give_inventory =[];

vector current_pos;
integer link;


check_inventory()
{
    integer x;
    integer y = llGetInventoryNumber(INVENTORY_OBJECT);
    for(x=0;x<=y;x++)
    {
        give_inventory += [llGetInventoryName(INVENTORY_OBJECT,x)];
    }
}

check_attach(string target)
{
    vector pos = llGetPos();
    if((llGetParcelFlags(pos) & PARCEL_FLAG_ALLOW_CREATE_OBJECTS)|
    (llGetParcelFlags(pos) &  PARCEL_FLAG_ALLOW_CREATE_GROUP_OBJECTS)|
    llGetLandOwnerAt(pos)==owner)
    {
        Rez_Object(target);
    }
    else llGiveInventory(owner, target);
}

Rez_Object(string target)
{
    if(object!="")
    {
        vector deltaP = <0,-1.5,0>;
        rotation deltaR = <0,0,0,0>;
        vector rezposition = llGetPos()+ deltaP * llGetRot();
        rotation rezrotation = deltaR * llGetRot();
        llRezObject(object, rezposition, ZERO_VECTOR, rezrotation, start_param);
        llSleep(1.2);
        llSay(start_param,"ATTACH*"+target);
    }
}

default
{
    state_entry()
    {
        check_inventory();
        owner = llGetOwner();
    }

    changed(integer C)
    { 
        if(C&CHANGED_OWNER|C&CHANGED_LINK|C&CHANGED_INVENTORY)
        {
            llResetScript();
        }
    }
    
    link_message(integer sender, integer num, string msg, key id)
    {
        //llOwnerSay((string)sender+", "+(string)num+", "+msg+", "+(string)id);
        list line = llParseString2List(msg,["|"],[""]);
        string cmd = llList2String(line,0);
        //llOwnerSay(cmd);
        if(num==90045)
        {
            if(llListFindList(give_inventory,[cmd])!=-1)
            {
                object = cmd;
                //llOwnerSay(object);
                check_attach((string)id);
            }
            else if(llListFindList(give_inventory,[cmd])==-1)//not an animation with an object
            {
                llSay(start_param,"DETACH*"+(string)owner);
            }
        }
    }
    
    on_rez(integer rez)
    {
        llResetScript();
    }
}
