integer RezMenu=-293;
integer CHANNEL;
integer listener;
float time = 120;
integer start_param;


list rezzable_items = [
"Item1", "<-0.17402, 0.28621, 0.46001>","<0.00022, 1.00000, 0.00000, 0.00012>",
"Item2", "<0.17963, -0.01522, -0.14911>","<0.00022, 1.00000, 0.00000, 0.00012>",
"Item3", "<0.01069, -0.05439, 0.25971>","<0.00022, 1.00000, 0.00000, 0.00012>",
"DeRez",ZERO_VECTOR,ZERO_VECTOR];

list sitters;
list options;

get_options()
{
    options = [];
    integer x;
    for(x=0;x<llGetListLength(rezzable_items);x+=3)
    {
           options += [llList2String(rezzable_items,x)];
    }   
}

RezSomething(string object, integer x)
{
    vector deltaP = (vector)llList2String(rezzable_items,(x+1)); 
    rotation deltaR =(rotation)llList2String(rezzable_items,(x+2));
    vector rezposition = llGetPos() + deltaP * llGetRot();
    rotation rezrotation = llGetRot() * deltaR;
    rezrotation = <-rezrotation.x, -rezrotation.y, rezrotation.z, rezrotation.s>;//just negate the x and y components of the quaternion to make the back the new front - Zelun Preez
    llRezObject(object, rezposition, ZERO_VECTOR, rezrotation, start_param);
}

llMenu(key toucher)
{
    llStartListener(toucher);
    llDialog(toucher, "Please choose a thing",options,CHANNEL);   
}

llStartListener(key toucher)
{
    llListenRemove(listener);//Clear up before we start
    CHANNEL = (integer)llFrand(-6000-(-900000));//make a random channel
    listener = llListen(CHANNEL,"",toucher,"");//Set the listener
    llSetTimerEvent(time);
}

llStopListener()
{
    llSetTimerEvent(0);
    llListenRemove(listener);//remove the listener
}
 
make_start_param()
{
    start_param = (integer)llFrand(-6000-(-900000));//make a random channel
}

default
{
    state_entry()
    {
        make_start_param();
        get_options();
    }
    
    touch_start(integer total_number)
    {
        if(llGetListLength(sitters)==0)
        {
            key toucher = llDetectedKey(0);
            llStartListener(toucher);
            llMenu(toucher);
        }
    }
    
    link_message(integer sender, integer num, string msg, key id)
    {
        //llOwnerSay((string)sender+", "+(string)num+", "+msg+", "+(string)id);
        list line = llParseString2List(msg,[","],["|"]);
        string cmd = llList2String(line,0);
        //line = llParseString2List(cmd,[","],[]);
        cmd = llList2String(line,1);
        //llOwnerSay(cmd);
        //Add any new sitters to the list
        if(num==90060)
        {
            sitters+=[id];
        }
        //remove people who stood up
        if(num==90065)
        {
            integer removal = llListFindList(sitters,[id]);
            sitters = llDeleteSubList(sitters,removal,removal);
        }
        if(num==RezMenu&&msg=="Rez Menu")
        {
            llMenu(id);
        }
    }
    
    listen(integer ch, string name, key id, string msg)
    {
        llStopListener();
        integer x = llListFindList(rezzable_items, [msg]);
        if(x!=-1)
        {
            if(msg!="DeRez")
            {
                RezSomething(msg, x);
            }
            else llWhisper(start_param,"DIEDIEDIE");
        }
    }
    
    timer()
    {
        llStopListener();
    }
    
    changed(integer C)
    {
        if(C&CHANGED_INVENTORY|C&CHANGED_OWNER)
        {
            llResetScript();
        }
    }
}
