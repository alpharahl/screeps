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
	        var targets = creep.room.find(FIND_CONSTRUCTION_SITES);
            if(targets.length) {
                if(creep.build(targets[0]) == ERR_NOT_IN_RANGE) {
                    creep.moveTo(targets[0], {visualizePathStyle: {stroke: '#ffffff'}});
                }
            } else { // nothing to build
                creep.moveTo(Game.spawns['Spawn1'])
            }
	    }
	    else {
          var source = creep.pos.findClosestByPath(FIND_STRUCTURES, {
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
