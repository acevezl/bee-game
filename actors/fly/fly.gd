extends AbstractEnemy

func move_behavior(delta: float):
	super(delta)
	position.y += 5*delta
