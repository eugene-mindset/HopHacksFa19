import json
import requests
from pprint import pprint
from auth import api_key

def check_cs_minor(student_courses):
    courses_left = []
    if 'EN.500.112' not in student_courses and 'EN.601.107' not in student_courses:
        courses_left.append('EN.500.112 - Gateway Computing: Java')
    if 'EN.601.220' not in student_courses:
        courses_left.append('EN.601.220 - Intermediate Programming')
    if 'EN.601.226' not in student_courses:
        courses_left.append('EN.601.226 - Data Structures')
    if 'EN.601.229' not in student_courses and 'EN.601.231' not in student_courses:
        courses_left.append(('EN.601.229 - Computer Systems Fundamentals', 'EN.601.231 - Automata and Computation Theory'))
    cs_uppers = [course for course in student_courses if course.startswith('EN.601.3') or course.startswith('EN.601.4')]
    if len(cs_uppers) < 3:
        for i in range(3 - len(cs_uppers)):
            courses_left.append('CS course at the 300 level or above')

    return courses_left