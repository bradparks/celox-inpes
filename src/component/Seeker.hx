package component;

import luxe.Component;
import luxe.options.ComponentOptions;

// import states.Play;
import luxe.Vector;

import entity.Missile;

import C;

typedef PlayerPositionEvent = {
	var x: Float;
	var y: Float;
}

class Seeker extends Component {
	
	public var targetPos:Vector;

	override public function new() {
		super({name: 'seeker'});
		targetPos = new Vector( );
	}

	override public function update(dt:Float) {
		Luxe.events.listen('player position', function(e: PlayerPositionEvent){
			targetPos.x = e.x;
			targetPos.y = e.y;
		});
	}

	public function reload() {
		// Randomized firing delay
		Luxe.timer.schedule(
			Luxe.utils.random.float(C.seeker_firingDelay_min, C.seeker_firingDelay_max),
			fire
			);
	}

	public function fire() {

		var missile = new Missile(0, 500);
		missile.pos = new Vector(entity.pos.x, entity.pos.y);
		// if (entity.active) {
		// 	var missile = Play.pool_missile.get( );
		// 	missile.pos = new Vector(entity.pos.x, entity.pos.y);
		// 	missile.rotation_z = Luxe.utils.random.float(0,360);

		var angle = Math.atan2(
			targetPos.y - this.pos.y,
			targetPos.x - this.pos.x
			);

		missile.velocity.set(
			C.missile_speed * Math.cos(angle),
			C.missile_speed * Math.sin(angle)
		);

		// 	missile.velocity.x = C.missile_speed * Math.cos(angle);
		// 	missile.velocity.y = C.missile_speed * Math.sin(angle);

		// 	missile.revive( );
		// }
		trace('seeker fired');
	}

}