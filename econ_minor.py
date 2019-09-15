import json
import requests
from pprint import pprint
from auth import api_key

def check_econ_minor(student_courses):
    courses_left = []
    ams_
    if 'AS.180.101'  not in student_courses :
        courses_left.append('EN.660.105 - Introduction to Business')
    if 'AS.180.102' not in student_courses:
        courses_left.append('EN.660.203 - Financial Accounting')

    econ_uppers = [course for course in student_courses if course.startswith('AS.180.2') or course.startswith('AS.180.3')]
    if len(econ_uppers) < 3:
        for i in range(3 - len(econ_uppers)):
            courses_left.append('Econ course at the 200 level or above (not including 180.203')

    return courses_left