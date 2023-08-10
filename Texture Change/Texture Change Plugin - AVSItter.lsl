list sitters =[];
integer link_to_change = 4;
//AV Sitter Stuff

key sitter;
string avmenu = "Texture";
//What we want to say when people use the menu

string message = "Please select a texture option";

//Stuff here for listening to the texture menu
integer CHANNEL;//Don't set a channel we'll make a random one each time
integer listener;//We use this to identify and remove listens

//It is good practice to close ore remove listens when not in use.

float time = 60;//Time in seconds before we revert textures

integer touched_face;//To remember what was touched when;
integer touched_link;

// To save doing an extra script thing we copy some info from the build menu

integer face_1= 0;//First texture in list changes this face
integer face_2= 4;//Second texture in list changes this face
integer face_3= 3;//Third texture in list changes this face


//This script was used for a bed with multiple cusions you will want to modify it to suit your build
//Now we list all of the textures, first the name then the UUIDs
//The name is used in the dialog menu, the UUID is used to set the textures
// so "Texture Name","UUID","UUID"
//first UUID is for the first link the second is the second link

list texture_list =[
"Light", "UUID 1",
"UUID 2", 
"UUID 3", 

"Dark","UUID 1", 
"UUID 2",
"UUID 3", 

"Birch","UUID 1",
"UUID 2", 
"UUID 3"]; 

list texture_options;

get_options()
{
    integer x;//We temporarily use this integer for counting
    //Now we go through the texture list and add the names to a new list
    for(x=0;x<llGetListLength(texture_list);x+=4)
    {
        //so from the zero position in the list we add
        //the name to teh new list, then jump two spaces
        //so we miss the UUID and add the next name 
        texture_options += llList2String(texture_list,x);
    }
}

start_listener(key toucher)
{
    llListenRemove(listener);//Clear up before we start
    CHANNEL = (integer)llFrand(-6000-(-900000));//make a random channel
    listener = llListen(CHANNEL,"",toucher,"");//Set the listener
}

stop_listener()
{
    llListenRemove(listener);//remove the listener
}


set_texture(string test)
{
    llOwnerSay(test);
    integer x = llListFindList(texture_list,[test]);//find the names position in the list
    string texture = llList2String(texture_list,x+1);//Set corresponding UUID
    llSetLinkPrimitiveParamsFast(link_to_change,[PRIM_TEXTURE,face_1,texture, <1.0, 1.0, 0.0>, <0.0, 0.0, 0.0>, 0.0 ]);
    texture = llList2String(texture_list,x+2);//Set corresponding UUID
    llSetLinkPrimitiveParamsFast(link_to_change,[PRIM_TEXTURE,face_2,texture, <1.0, 1.0, 0.0>, <0.0, 0.0, 0.0>, 0.0 ]);
    texture = llList2String(texture_list,x+3);//Set corresponding UUID
    llSetLinkPrimitiveParamsFast(link_to_change,[PRIM_TEXTURE,face_3,texture, <1.0, 1.0, 0.0>, <0.0, 0.0, 0.0>, 0.0 ]);
}


texture_menu(key id)
{
    start_listener(id);
    touched_link = link_to_change;
    llDialog(id,message,texture_options,CHANNEL);
}



default
{
    state_entry()
    {
        get_options();
    }
    
    touch_start(integer T)
    {
        sitter = llDetectedKey(0);
        touched_link = llDetectedLinkNumber(0);
        touched_face = llDetectedTouchFace(0);// for more complicated builds
        llOwnerSay((string)touched_face);
        if(llGetListLength(sitters)==0)//Only works when no one is sitting, if they are sitting we use trhe AVSitter menu
        {
            if(touched_link==link_to_change) // This is for cases where you want different texture menus for different links
            {
                texture_menu(sitter);
            }
        }
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
        if(num==800&&msg==avmenu)
        {
            sitter = id;
            texture_menu(sitter);
        }
    }
    
    //When rezzed
    on_rez(integer rez)
    {
        llResetScript();
    }
    
    listen(integer CH, string name, key id, string message)
    {
        llOwnerSay(message);
        stop_listener();//always close the listener
        if(touched_link == link_to_change)
        {
            if(llListFindList(texture_list,[message])!=-1)
            {
                set_texture(message);//Set the texture according to what was selected
            }
        }
    }
    
    timer()
    {
        stop_listener();//stop listener just in case it is still on
    }
}
