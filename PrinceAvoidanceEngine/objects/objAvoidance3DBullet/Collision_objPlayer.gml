/// @desc
if(killer&&z<=0){

    var _killed=!global.dotHitbox||collision_rectangle(other.x-1,other.y-1,other.x+1,other.y+1,id,true,false);
    if(_killed){
        if(global.ance){
            bullet_kill_ance();
            
        }else{
            player_kill();
        }
    }
}