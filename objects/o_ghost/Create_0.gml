/// @description Insert description here
// You can write your code in this editor

waxing = false;
waxWaneTimer = irandom(GHOST_WAX_WANE_TIMER);
pinged = false;
pingedDistance=0;
pingHoldTimer=GHOST_HOLD_VISIBLE_TIMER;
selectedSpeed=random_range(GHOST_SPEED_MIN, GHOST_SPEED_MAX);
attacking=false;
attackTimer=0;
seeking=true;
cruiseTimer=0;
cruisingDirection=0;