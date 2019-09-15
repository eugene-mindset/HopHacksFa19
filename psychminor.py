import json
import requests
from pprint import pprint
from auth import api_key

def check_psych_minor(student_courses):
    courses_left = []
    if 'AS.200.101' not in student_courses:
        courses_left.append('AS.200.101 - Introduction to Psychology')
    if 'AS.200.110' not in student_courses:
        courses_left.append('AS.200.110 - Introduction to Cognitive Psychology')
    if 'AS.200.132' not in student_courses:
        courses_left.append('AS.200.132 - Introduction to Developmental Psychology')
    if 'AS.200.133' not in student_courses:
        courses_left.append('AS.200.133 - Introduction to Social Psychology')
    if 'AS.200.141' not in student_courses:
        courses_left.append('Foundations of Brain, Behavior and Cognition')

    courses = 0
    uppers = []

    for course in student_courses:
        if course.startswith('AS.200.3') or course.startswith('AS.200.6'):
            courses += 1
            uppers.append(course)
        if courses == 2:
            break

    if courses < 2:
        for i in range(2 - courses):
            courses_left.append('Psychology class at the 300 or 600 level')

    other = False

    for course in student_courses:
        if not ((course == 'AS.200.101' or course == 'AS.200.110' or course == 'AS.200.132'
            or course == 'AS.200.133' or course == 'AS.200.141') or course in uppers):

            if course.startswith('AS.200.'):
                other = False

    if not other:
        courses_left.append('Psychology class at any level')


    return courses_left
