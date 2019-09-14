import json
import requests
from pprint import pprint
from auth import api_key

def check_cis_minor(student_courses):
    courses_left = []
    if 'EN.500.112' not in student_courses and 'EN.601.107' not in student_courses:
        courses_left.append('EN.500.112 - Gateway Computing: Java')
    if 'EN.601.226' not in student_courses:
        courses_left.append('EN.601.226 - Data Structures')
    if 'AS.110.106' not in student_courses and 'AS.110.108' not in student_courses:
        courses_left.append(('AS.110.106 - Calculus I (Biology and Social Sciences)', 'AS.110.108 - Calculus I'))
    if 'AS.110.107' not in student_courses and 'AS.110.109' not in student_courses:
        courses_left.append(('AS.110.107 - Calculus II (For Biological and Social Science)', 'AS.110.109 - Calculus II (For Physical Sciences and Engineering)'))
    if 'AS.110.202' not in student_courses and 'AS.110.211' not in student_courses:
        courses_left.append(('AS.110.202 - Calculus III', 'AS.110.211 - Honors Multivariable Calculus'))
    if 'EN.553.291' not in student_courses and 'AS.110.201' not in student_courses and 'AS.110.212' not in student_courses:
        courses_left.append(('AS.110.201 - Linear Algebra', 'EN.553.291 - Linear Algebra and Differential Equations', 'AS.110.212 - Honors Linear Algebra'))
    if 'EN.601.455' not in student_courses:
        courses_left.append('EN.601.455 - Computer Integrated Surgery I')
    if 'EN.601.456' not in student_courses:
        courses_left.append('EN.601.456 - Computer Integrated Surgery II')
    
    imaging_group = ['EN.520.414', 'EN.520.432', 'EN.580.472', 'EN.520.433', 'EN.601.461']
    robotics_group = ['EN.530.420', 'EN.530.421', 'EN.530.603', 'EN.530.646', 'EN.601.463']
    other_group = ['EN.520.448', 'EN.520.425', 'EN.530.445', 'EN.580.471', 'EN.601.476', 'EN.601.482', 'EN.601.454']

    cis_courses_left = 4
    imaging_courses = len(list(set(student_courses).intersection(imaging_group)))
    if imaging_courses < 1:
        courses_left.append('CIS Imaging course')
        cis_courses_left -= 1
    cis_courses_left -= imaging_courses
    robotics_courses = len(list(set(student_courses).intersection(robotics_group)))
    if robotics_courses < 1:
        courses_left.append('CIS Robotics course')
        cis_courses_left -= 1
    cis_courses_left -= robotics_courses
    other_courses = len(list(set(student_courses).intersection(other_group)))
    for i in range(cis_courses_left - other_courses):
        courses_left.append(('CIS Imaging course', 'CIS Robotics course', 'CIS Other course'))

    return courses_left