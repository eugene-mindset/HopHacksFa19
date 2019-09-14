import json
import requests
from pprint import pprint
from auth import api_key

def check_as_minor(student_courses):
    courses_left = []
    missing_class = []

    if 'AS.362.112' not in student_courses:
        missing_class.append('AS.362.112')
    if 'AS.100.122' not in student_courses:
        missing_class.append('AS.100.122')
    if 'AS.100.123' not in student_courses:
        missing_class.append('AS.100.123')

    if (3 - len(missing_class) < 1):
        if 'AS.362.112' in missing_class:
            courses_left.append('AS.362.112 - Introduction to Africana Studies')
        if 'AS.100.122' in missing_class:
            courses_left.append('AS.100.122 - Introduction to History of Africa (since 1880)')
        if 'AS.100.123' in missing_class:
            courses_left.append('Introduction to African History: Diversity, Mobility, Innovation')

    as_uppers = [course for course in student_courses if course.startswith('AS.362.3')
        or course.startswith('AS.362.4') or course.startswith('AS.362.5') or course.startswith('AS.362.6')]
    if len(as_uppers) < 3:
        for i in range(3 - len(as_uppers)):
            courses_left.append('Africana Studies course at the 300 level or above')

    as_others = [course for course in student_courses if (course.startswith('AS.362.') and not course.startswith('AS.362.112'))]
    if len(as_others) < 1:
        courses_left.append('Africana Studies course at any level')

    return courses_left
