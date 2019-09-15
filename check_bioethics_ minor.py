import json
import requests
from pprint import pprint
from auth import api_key

def check_bioethics_minor(student_courses):
    courses_left = []
    if 'AS.150.219'  not in student_courses :
        courses_left.append('EN.660.105 - Introduction to Bioethics')
    if 'AS.150.220' not in student_courses:
        courses_left.append('EN.150.220 - Introduction to Moral Philosophy')
    if 'AS.020.151' and 'AS.020.152' not in student_courses or 'AS.020.305' and 'AS.020.306' not in student_courses or 'EN.580.421' and 'EN.580.422' not in student_courses:
        courses_left.append(('AS.020.151 - General Biology I and General Biology II'), ('AS.020.305 - Biochemistry and AS.020.306 - Cell Biology'), ('EN.580.421 - Systems Bioengineering I and EN.580.422 Systems Bioengineering II'))

    bioethics_uppers = [course for course in student_courses if course.startswith('AS.150.3') or course.startswith('AS.180.4')]
    if len(bioethics_uppers) < 3:
        for i in range(3 - len(bioethics_uppers)):
            courses_left.append('Bioethics course at the 300 level or above')

    return courses_left