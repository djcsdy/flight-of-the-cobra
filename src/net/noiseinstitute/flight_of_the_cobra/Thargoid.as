package net.noiseinstitute.flight_of_the_cobra {
    import net.flashpunk.Entity;
    import net.flashpunk.graphics.Image;

    public class Thargoid extends Entity {
        [Embed(source="Thargoid.png")]
        private static const ThargoidSprite:Class;

        [Embed(source="Pop.png")]
        private static const DeadSprite:Class;

        private static const DEAD_TIME:int = 12;

        private var _normalGraphic:Image = new Image(ThargoidSprite);
        private var _deadGraphic:Image = new Image(DeadSprite);
        private var _behaviour:ThargoidBehaviour;
        private var _dead:Boolean = false;
        private var _deadFrames:int;

        public function Thargoid () {
            _normalGraphic.x = -_normalGraphic.width*0.5;
            _normalGraphic.y = -_normalGraphic.height*0.5;
            _deadGraphic.x = -_deadGraphic.width*0.5;
            _deadGraphic.y = -_deadGraphic.height*0.5;

            super(0, 0, _normalGraphic);

            setHitboxTo(_normalGraphic);

            collidable = false;
            visible = false;
        }

        public function set behaviour(behaviour:ThargoidBehaviour):void {
            _behaviour = behaviour;
        }

        public function init(behaviour:ThargoidBehaviour=null):void {
            type = "enemy";
            active = true;
            collidable = true;
            visible = true;
            graphic = _normalGraphic;
            _behaviour = behaviour;
            _dead = false;
        }

        public function kill ():void {
            type = "dead";
            collidable = false;
            graphic = _deadGraphic;
            _behaviour = null;
            _dead = true;
            _deadFrames = 0;
        }

        override public function update():void {
            if (_dead) {
                if (_deadFrames++ > DEAD_TIME) {
                    active = false;
                    visible = false;
                }
            } else {
                if (_behaviour != null) {
                    _behaviour.update(this);
                }
                super.update();
            }
        }
    }
}
