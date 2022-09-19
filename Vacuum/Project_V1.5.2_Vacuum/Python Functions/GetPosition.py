import cv2
import numpy as np
import math

def get_contour_angle(cnt):
    rect = cv2.minAreaRect(cnt)
    angle = rect[-1]
    width, height = rect[1][0], rect[1][1]
    ratio_size = float(width) / float(height)
    if 1.25 > ratio_size > 0.75:
        if angle < -45:
            angle = 90 + angle
    else:
        if width < height:
            angle = angle + 180
        else:
            angle = angle + 90

        if angle > 90:
            angle = angle - 180

    return math.radians(angle)

def find_contours(frame, lower_limit, upper_limit):
    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
    _,lightThresh = cv2.threshold(gray, 230, 255, cv2.THRESH_BINARY_INV)
    frame = cv2.bitwise_and(frame, frame, mask=lightThresh)
    blur = cv2.GaussianBlur(frame,(3,3),0)
    #Resize and coverting BGR to HSV
    hsv = cv2.cvtColor(blur, cv2.COLOR_BGR2HSV)
    #Finding the range in image
    out = cv2.inRange(hsv, lower_limit, upper_limit)
    dilated = cv2.dilate(out, cv2.getStructuringElement(cv2.MORPH_RECT,ksize=(3,3)))
    contours, _ = cv2.findContours(dilated, cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)
    return contours

def get_pos(frame, lower_limit, upper_limit):
    x_res, y_res = 256, 128
    frame = cv2.resize(frame, (x_res,y_res))
    contours = find_contours(frame, lower_limit, upper_limit)
    result = frame.copy()
    cv2.drawContours(result, contours, -1, (255,255,255), 3)

    cx, cy = 0,0
    min_x, min_y = -10000,-10000
    rotation = -10000;
    if len(contours) > 0:
        for _,cnt in enumerate(contours):           
            M = cv2.moments(cnt)
            if M['m00'] != 0:
                area = cv2.contourArea(cnt)
                if area>500:
                    cx = int(M['m10']/M['m00'])
                    cy = int(M['m01']/M['m00'])
                    if (cy > min_y): 
                        min_x = cx
                        min_y = cy
                    cv2.circle(result, (cx, cy), 5, (255, 255, 255), -1)
                    cv2.circle(result, (cx,cy), 10, (0,255,255), 3)
                    
                    rotation = get_contour_angle(cnt)
                    cv2.imwrite('out.png', result)
    else:
        return (-10000, -10000, -10000)

    return (min_x,min_y,rotation)

def callme():
    # matlab calls this function and this function return nearest cube position or -10000 if no cube found.
    frame = cv2.imread('image.png')
    
    #blue   
    lower_limit_blue = np.array([66,0,0])
    upper_limit_blue =  np.array([180,255,255])
    x_min_blue, y_min_blue, rotation_blue = get_pos(frame, lower_limit_blue, upper_limit_blue)

    #red
    lower_limit_red =   np.array([0,0,135])
    upper_limit_red =  np.array([0,255,255])
    x_min_red, y_min_red, rotation_red = get_pos(frame, lower_limit_red, upper_limit_red)

    #green
    lower_limit_green =   np.array([15,0,0])
    upper_limit_green =  np.array([85,255,255])
    x_min_green, y_min_green, rotation_green = get_pos(frame, lower_limit_green, upper_limit_green)

    if (y_min_blue >= y_min_red and y_min_blue >= y_min_green): return (x_min_blue,y_min_blue,rotation_blue,'b')
    elif (y_min_red >= y_min_blue and y_min_red >= y_min_green):  return (x_min_red,y_min_red,rotation_red,'r')
    elif (y_min_green >= y_min_blue and y_min_green >= y_min_red):  return (x_min_green,y_min_green,rotation_green,'g')
    else: return (-10000, -10000, -10000, '-10000')