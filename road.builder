var roadBuilder = {
    run: function(pos1, pos2){
        var r = Game.rooms['W72N4'];
        const path = r.findPath(pos1.pos, pos2.pos, {ignoreCreeps: true});
        for (var p in path){
            var position = path[p];
            r.createConstructionSite(position['x'], position['y'], STRUCTURE_ROAD);
        }
    }
}

module.exports = roadBuilder;
