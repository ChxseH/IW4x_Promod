#include maps\mp\_utility;
init(){}vehicleKilled(owner,vehicle,eInflictor,attacker,iDamage,sMeansOfDeath,sWeapon){data=spawnstruct();data.vehicle=vehicle;data.victim=owner;data.eInflictor=eInflictor;data.attacker=attacker;data.iDamage=iDamage;data.sMeansOfDeath=sMeansOfDeath;data.sWeapon=sWeapon;data.time=gettime();}playerAssist(){data=spawnstruct();data.player=self;}useHardpoint(hardpointType){wait.05;WaitTillSlowProcessAllowed();data=spawnstruct();data.player=self;data.hardpointType=hardpointType;}genericChallenge(challengeType,value){return;}