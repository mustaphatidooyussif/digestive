extends Node2D


onready var downRight = $"./downRight/"
onready var topRight = $"./topRight/"
onready var topLeft = $"./topLeft/"
onready var downLeft = $"./downLeft/"

onready var downRightL = $"./downRightL/"
onready var topRightL = $"./topRightL/"
onready var topLeftL = $"./topLeftL/"
onready var downLeftL = $"./downLeftL/"

onready var shuttle = $"./shuttle/"
onready var scoreLabel = $"./score/"
#var speed = 100

onready var pos = topLeft.get_position()
onready var motion =  pos

onready var score = 2
#onready var an_x = downRight.get_position().x - pos.x #downRight.get_position_in_parent().x
#onready var a_y = downRight.get_position().y - pos.y #downRight.get_position_in_parent().y
func show_everything():
	downRight.show()
	topRight.show()
	topLeft.show()
	downLeft.show()
	
func show_everythingL():
	downRightL.show()
	topRightL.show()
	topLeftL.show()
	downLeftL.show()
	
func hide_everything():
	downRight.hide()
	topRight.hide()
	topLeft.hide()
	downLeft.hide()
	
func hide_everythingL():
	downRightL.hide()
	topRightL.hide()
	topLeftL.hide()
	downLeftL.hide()
	
onready var good = downRight
onready var goodL = downRight

onready var rng = RandomNumberGenerator.new()

func resetGood(pos):
	var listOfCorners = [topLeft,topRight,downLeft,downRight]
	var listOfCornersL = [topLeftL,topRightL,downLeftL,downRightL]
	print(listOfCorners)
	print(listOfCornersL)
	for k in range(4):
		print(k)
		if pos.get_position() == listOfCorners[k].get_position():
			listOfCorners.remove(k)
			listOfCornersL.remove(k)
			break
	#for k in range(4):
	#	print(k)
	#	if pos.get_position() == listOfCorners[k].get_position():
	#		listOfCorners.remove(k)
	#		break
	var ind = rng.randi_range(0, 2)
	print(ind,ind)
	goodL = listOfCornersL[ind]
	good = listOfCornersL[ind]
	listOfCornersL[ind].show()
	listOfCorners[ind].hide()
	for i in range(3):
		if i != ind:
			print(i)
			if pos.get_position() != listOfCorners[i].get_position():
				print(listOfCorners[i])
				listOfCorners[i].show()
				listOfCornersL[i].hide()
			else:
				print(i,i,i,i)
				listOfCorners[i].hide()
				listOfCornersL[i].hide()
	
	
func turn(pos, posL):
	pos.hide()
	posL.hide()
	if pos.get_position() == good.get_position():
		score += 1
	else:
		score -= 1
	
func _process(delta):
	if Input.is_action_pressed("ui_right") && Input.is_action_pressed("ui_down"):
		if pos == topLeft.get_position():
			motion = downRight.get_position()
			print("diagonal down right")
			pos = motion
			turn(downRight, downRightL)
			resetGood(downRight)
			
	elif Input.is_action_pressed("ui_left") && Input.is_action_pressed("ui_down"):
		if pos == topRight.get_position():
			motion = downLeft.get_position()
			print("diagonal down leftt")
			pos = motion
			turn(downLeft, downLeftL)
			resetGood(downLeft)
			
	elif Input.is_action_pressed("ui_left") && Input.is_action_pressed("ui_up"):
		if pos == downRight.get_position():
			motion = topLeft.get_position()
			print("diagonal up left")
			pos = motion
			turn(topLeft, topLeftL)
			resetGood(topLeft)
			
	elif Input.is_action_pressed("ui_right") && Input.is_action_pressed("ui_up"):
		if pos == downLeft.get_position():
			motion = topRight.get_position()
			print("diagonal up right")
			pos = motion
			turn(topRight, topRightL)
			resetGood(topRight)
			
	elif Input.is_action_just_pressed("ui_right"):
		if pos == downLeft.get_position():
			motion = downRight.get_position()
			turn(downLeft, downLeftL)
			resetGood(downLeft)
			
		elif pos == topLeft.get_position():
			motion = topRight.get_position()
			turn(topRight, topRightL)
			resetGood(topRight)
			
		pos = motion
	elif Input.is_action_just_pressed("ui_left"):
		if pos == downRight.get_position():
			motion = downLeft.get_position()
			resetGood(downLeft)
		elif pos == topRight.get_position():
			motion = topLeft.get_position()
			turn(topLeft, topLeftL)
			resetGood(topLeft)
			
		pos = motion
	elif Input.is_action_just_pressed("ui_up"):
		if pos == downLeft.get_position():
			motion = topLeft.get_position()
			resetGood(topLeft)
		elif pos == downRight.get_position():
			motion = topRight.get_position()
			turn(topRight, topRightL)
			resetGood(topRight)
		pos = motion
	elif Input.is_action_just_pressed("ui_down"):
		if pos == topLeft.get_position():
			motion = downLeft.get_position()
			turn(downLeft, downLeftL)
			resetGood(downLeft)
		elif pos == topRight.get_position():
			motion = downRight.get_position()
			turn(downRight, downRightL)
			resetGood(downRight)
		pos = motion
	scoreLabel.set_text(str(score))
	#hide_everythingL()
	shuttle.set_position(motion)
	
