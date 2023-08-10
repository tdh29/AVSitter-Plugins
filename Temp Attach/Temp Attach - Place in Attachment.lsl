integer start_param = 102;
key user;

integer ATTACH_POINT(string temp)
{
    integer A;
    if(temp=="RHAND")
    {
        A = ATTACH_RHAND;
    }
    if(temp=="LHAND")
    {
        A = ATTACH_LHAND;
    }
    if(temp=="CHEST")
    {
        A=ATTACH_CHEST;
    }
    if(temp=="HEAD")
    {
        A=ATTACH_HEAD;
    }
    if(temp=="LSHOULDER")
    {
        A=ATTACH_LSHOULDER;
    }
    if(temp=="RSHOULDER")
    {
        A=ATTACH_RSHOULDER;
    }
    if(temp=="LHAND")
    {
        A=ATTACH_LHAND;
    }
    if(temp=="RHAND")
    {
       A= ATTACH_RHAND;
    }
    if(temp=="LFOOT")
    {
        A=ATTACH_LFOOT;
    }
    if(temp=="RFOOT")
    {
        A=ATTACH_RFOOT;
    }
    if(temp=="BACK")
    {
        A=ATTACH_BACK;
    }
    if(temp=="PELVIS")
    {
        A=ATTACH_PELVIS;
    }
    if(temp=="MOUTH")
    {
        A=ATTACH_MOUTH;
    }
    if(temp=="CHIN")
    {
        A=ATTACH_CHIN;
    }
    if(temp=="LEAR")
    {
        A=ATTACH_LEAR;
    }
    if(temp=="REAR")
    {
        A=ATTACH_REAR;
    }
    if(temp=="LEYE")
    {
        A=ATTACH_LEYE;
    }
    if(temp=="REYE")
    {
        A=ATTACH_REYE;
    }
    if(temp=="NOSE")
    {
        A=ATTACH_NOSE;
    }
    if(temp=="RUARM")
    {
        A=ATTACH_RUARM;
    }
    if(temp=="RLARM")
    {
        A=ATTACH_RLARM;
    }
    if(temp=="LUARM")
    {
        A=ATTACH_LUARM;
    }
    if(temp=="LLARM")
    {
        A=ATTACH_LLARM;
    }
    if(temp=="RHIP")
    {
        A=ATTACH_RHIP;
    }
    if(temp=="RULEG")
    {
        A=ATTACH_RULEG;
    }
    if(temp=="RLLEG")
    {
        A=ATTACH_RLLEG;
    }
    if(temp=="LHIP")
    {
        A=ATTACH_LHIP;
    }
    if(temp=="LULEG")
    {
        A=ATTACH_LULEG;
    }
    if(temp=="LLEG")
    {
        A=ATTACH_LLLEG;
    }
    if(temp=="BELLY")
    {
        A=ATTACH_BELLY;
    }
    if(temp=="LEFT_PEC")
    {
        A=ATTACH_LEFT_PEC;
    }
    if(temp=="RIGHT_PEC")
    {
        A=ATTACH_RIGHT_PEC;
    }
    if(temp=="HUD_CENTER_2")
    {
        A=ATTACH_HUD_CENTER_2;
    }
    if(temp=="HUD_TOP_RIGHT")
    {
        A=ATTACH_HUD_TOP_RIGHT;
    }
    if(temp=="HUD_TOP_CENTER")
    {
        A=ATTACH_HUD_TOP_CENTER;
    }
    if(temp=="HUD_TOP_LEFT")
    {
        A=ATTACH_HUD_TOP_LEFT;
    }
    if(temp=="HUD_CENTER_1")
    {
        A=ATTACH_HUD_CENTER_1;
    }
    if(temp=="HUD_BOTTOM_LEFT")
    {
        A=ATTACH_HUD_BOTTOM_LEFT;
    }
    if(temp=="ATTACH_HUD_BOTTOM")
    {
        A=ATTACH_HUD_BOTTOM;
    }
    if(temp=="HUD_BOTTOM_RIGHT")
    {
        A=ATTACH_HUD_BOTTOM_RIGHT;
    }
    if(temp=="NECK")
    {
        A=ATTACH_NECK;
    }
    if(temp=="AVATAR_CENTER")
    {
        A=ATTACH_AVATAR_CENTER;
    }
    return A;
}
     
default
{
    state_entry()
    {
        llListen(start_param,"","","");
        llSetTimerEvent(30);
    }
 
    run_time_permissions( integer vBitPermissions )
    {
        if( vBitPermissions & PERMISSION_ATTACH )
        {
            llSay(start_param,"DETACH*"+(string)user);
            llAttachToAvatarTemp(ATTACH_POINT(llGetObjectDesc()));
        }
        else
        {
            llDie();
        }
    }
 
    on_rez(integer rez)
    {
        if(rez==start_param)
        {
            if(!llGetAttached())
            { 
                llListen(start_param,"","","");
            }
        }
        else llDie();
    }
 
    attach(key AvatarKey)
    {
        if(AvatarKey)
        {
            state attached_state;
        }
        else llDie();
    }
    
    timer()
    {
        llDie();
    }
    
    listen(integer chan, string name, key id, string msg)
    {
        list line = llParseString2List(msg,["*"],[]);
        user = (key)llList2String(line,1);
        string cmd = llList2String(line,0);
        if(cmd=="DIE")
        {     
            llDie();
        }
        if(cmd=="DETACH")
        {
            llRequestPermissions(user, PERMISSION_ATTACH );
        }
        else if(cmd=="ATTACH")
        {
            llRequestPermissions(user, PERMISSION_ATTACH );
            llSetTimerEvent(30);
        }
    }
}

state attached_state
{
    state_entry()
    {
        llListen(start_param,"","","");
    }
 
    run_time_permissions( integer vBitPermissions )
    {
        llDetachFromAvatar();
    }
 
    on_rez(integer rez)
    {
        if(rez==start_param)
        {
            llResetScript();
        }
        else llDie();
    }
    
    listen(integer chan, string name, key id, string msg)
    {
        list line = llParseString2List(msg,["*"],[]);
        user = (key)llList2String(line,1);
        string cmd = llList2String(line,0);
        if(cmd=="DIE")
        {     
            llDie();
        }
        if(cmd=="DETACH"&&user!=NULL_KEY)
        {
            llRequestPermissions(user, PERMISSION_ATTACH );
        }
    }
}