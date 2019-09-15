import json
import requests
from pprint import pprint
from auth import api_key

def check_anthro_minor(student_courses):
    courses_left = []
    if 'AS.070.132' not in student_courses:
        courses_left.append('AS.070.132 - Invitation to Anthropology')
    if 'AS.070.273' not in student_courses:
        courses_left.append('AS.070.273 - Ethnographies')
    if 'AS.070.317' not in student_courses:
        courses_left.append('AS.070.317 - Methods')
    if 'AS.070.419' not in student_courses:
        courses_left.append('Logic of Anthropological Inquiry')

    anthro_uppers = [course for course in student_courses if
        course.startswith('AS.070.3') or course.startswith('AS.070.4')]

    if (len(anthro_uppers) < 2):
        for i in range (2 - len(anthro_uppers)):
            courses_left.append('Anthropology course at either the 300 or 400 level')

    others = False

    for course in student_courses:
        if course not in anthro_uppers and course.startswith('AS.070.'):
            others = True

    if not others:
        courses_left.append('Anthropology course at any level')

    return courses_left
