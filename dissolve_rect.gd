extends ColorRect

func change_scene(target: String) -> void:
	$AnimationPlayer.play('dissolve')
	await($AnimationPlayer,'animation_finished')
	get_tree().change_scene(target)
	$AnimationPlayer.play_backwards('dissolve')
