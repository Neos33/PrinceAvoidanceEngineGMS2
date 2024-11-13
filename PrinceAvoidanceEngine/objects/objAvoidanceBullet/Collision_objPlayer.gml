
if(killer){

    var _killed=!global.dotHitbox||collision_rectangle(other.x-1,other.y-1,other.x+1,other.y+1,id,true,false);
    if(_killed){
        if(global.ance){
            bullet_kill_ance();
            
        }else{
            if(global.hp>1){
                ance_active=0;
                ance_alpha=0.5;
            }
            endurance_player_kill();
        }
    }
}
