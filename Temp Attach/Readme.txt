The purpose of this script is to provide temporary attachments of objects when specific animations are chosen in AV Sitter. Temp attach allows avatars to wear items without cluttering up their inventory. When the item is detached it deletes itself.  


====Setup instructions======
nstructions Script 1:

Wear the objects in the appropriate attach point and position them as you would normally for wearables. 

Remove items and rez on ground. 

Name the objects you wish to attach the same as the AV Sitter menu option for example: 

[13:59] Object: ◆POSE Blusher|blushbrush
[13:59] Object: ◆POSE BrushHair|hairbrush
[13:59] Object: ◆POSE Lipstick|lipstick

Objects will be named Blusher, BrushHair and Lipstick 

Change the description of the object to reflect the attach point. A full list is provided at the end of this notecard but the most common descriptions are LHAND and RHAND for left hand and right hand or MOUTH for mouth. 

Set permissions of object to copy and transfer. Failure to do so will result in script errors. Attempting rez the objects from inventory will result in them deleting themselves. 

Place script 1 in the object and take the item back into inventory. 

Place objects in the contents of the furniture item (the one with AV Sitter in it).


Instructions Script 2:

Place script 2 in the contents of the attaching item. 

========================

====Usage instructions===

When the sitter chooses an animation option that has a relevant object to attach it will either 

A) Rez an item and ask their permission to attach*
B) Give inventory**

When the new item attaches, the old one detaches and vanishes into mists of second life. 

*When either build is enabled, the owner of the furniture is the owner of the land or when group build is set and the furniture is in the same group.

**Give inventory will only occur when rez is not possible. 

=================

===Full list of attach points ====  

CHEST    - chest/sternum
HEAD    - head
LSHOULDER    - left shoulder
RSHOULDER    - right shoulder
LHAND    - left hand
RHAND    - right hand
LFOOT    - left foot
RFOOT    - right foot
BACK    - back
PELVIS    - pelvis
MOUTH    - mouth
CHIN    - chin
LEAR    - left ear
REAR    - right ear
LEYE    - left eye
REYE    - right eye
NOSE    - nose
RUARM    - right upper arm
RLARM    - right lower arm
LUARM    - left upper arm
LLARM    - left lower arm
RHIP    - right hip
RULEG    - right upper leg
RLLEG    - right lower leg
LHIP    - left hip
LULEG    - left upper leg
LLLEG    - left lower leg
BELLY    - belly/stomach/tummy
LEFT_PEC    - left pectoral
RIGHT_PEC    - right pectoral
HUD_CENTER_2    - HUD Center 2
HUD_TOP_RIGHT    - HUD Top Right
HUD_TOP_CENTER    - HUD Top
HUD_TOP_LEFT    - HUD Top Left
HUD_CENTER_1    - HUD Center
HUD_BOTTOM_LEFT    - HUD Bottom Left
HUD_BOTTOM    - HUD Bottom
HUD_BOTTOM_RIGHT    - HUD Bottom Right
NECK    - neck
AVATAR_CENTER    - avatar center/root