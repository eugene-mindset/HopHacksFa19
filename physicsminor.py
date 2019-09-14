import json
import requests
from pprint import pprint
from auth import api_key

def check_physics_minor(student_courses):
    courses_left = []
    if 'AS.172.203' not in student_courses:
        courses_left.append('AS.172.203 - Contemporary Physics Seminar')

    physics_core = [course for course in student_courses if course.startswith('AS.172.2')
        or course.startswith('AS.172.3') or course.startswith('AS.172.4') or
        course.startswith('AS.172.5') or course.startswith('AS.172.5')]

    if len(physics_core) < 4:
        for i in range(4 - len(physics_core)):
            courses_left.append('Physics class at the 200 level or above')

    return courses_left
