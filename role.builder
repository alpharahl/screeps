var roleBuilder = {

    /** @param {Creep} creep **/
    run: function(creep) {

	    if(creep.memory.building && creep.carry.energy == 0) {
            creep.memory.building = false;
            creep.say('pickup');
	    }
	    if(!creep.memory.building && creep.carry.energy == creep.carryCapacity) {
	        creep.memory.building = true;
	        creep.say('build');
	    }

	    if(creep.memory.building) {
        //check for repairs needed for containers first
        var targets = creep.room.find(FIND_STRUCTURES, {
          filter: (structure) => {
            return (structure.structureType == STRUCTURE_CONTAINER &&
                    structure.hits < (structure.hitsMax))
          }
        });
        if (targets.length) {
          if (creep.repair(targets[0]) == ERR_NOT_IN_RANGE){
            creep.moveTo(targets[0])
          }
        } else {
	        var targets = creep.room.find(FIND_CONSTRUCTION_SITES);
          if(targets.length) {
              if(creep.build(targets[0]) == ERR_NOT_IN_RANGE) {
                  creep.moveTo(targets[0], {visualizePathStyle: {stroke: '#ffffff'}});
              }
          } else { // nothing to build
              creep.moveTo(Game.spawns['Spawn1'])
          }
        }
	    }
	    else {
        var sources = creep.room.find(FIND_SOURCES);
        var source = sources[1].pos.findClosestByPath(FIND_STRUCTURES, {
            filter: (structure) => {
                return structure.structureType == STRUCTURE_CONTAINER
            }
        })
        if(creep.withdraw(source, RESOURCE_ENERGY) == ERR_NOT_IN_RANGE) {
            creep.moveTo(source, {visualizePathStyle: {stroke: '#ffaa00'}});
        }
	    }
	}
};

module.exports = roleBuilder;
