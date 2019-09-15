import json
import requests
from pprint import pprint
from auth import api_key

def check_classics_minor(student_courses):
    courses_left = []
    classics = [course for course in student_courses if course.startswith('AS.040')]
    if len(classics_uppers) < 6:
        for i in range(6 - len(classisc_uppers)):
            courses_left.append('Classics course')

    return courses_left