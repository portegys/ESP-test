key avatar;

default
{
    state_entry()
    {
        llSitTarget(<0.0, -0.5, 0.25>, llEuler2Rot(<0, 0, -90> * DEG_TO_RAD));
    }
 
    changed(integer change) {
        if (change & CHANGED_LINK) { 
            avatar = llAvatarOnSitTarget();
            if (avatar) {
                llMessageLinked(LINK_ROOT, 1, "sit", avatar);
            } else {
                llMessageLinked(LINK_ROOT, 1, "stand", avatar);    
            }
        }
    }
}
