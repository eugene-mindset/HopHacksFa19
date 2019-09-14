import json
import requests
from pprint import pprint

api_key = '8p4Wk8y5gUYk3LJDqxMIdll2MLkxM7DW'
whiting = 'Whiting School of Engineering'
krieger = 'Krieger School of Arts and Sciences'
semesters = ['Fall 2019', 'Spring 2019', 'Fall 2018', 'Spring 2018', 'Fall 2017', 'Spring 2017', 'Fall 2016']
all_courses = {}

def get_whiting_departments():
    url = f'https://sis.jhu.edu/api/classes/codes/departments/{whiting}?key={api_key}'
    response = requests.get(url)
    response.raise_for_status()
    data = json.loads(response.text)
    departments = []
    for department in data:
        if department['DepartmentName'].startswith('EN'):
            departments.append(department['DepartmentName'])
    return departments

def get_krieger_departments():
    url = f'https://sis.jhu.edu/api/classes/codes/departments/{krieger}?key={api_key}'
    response = requests.get(url)
    response.raise_for_status()
    data = json.loads(response.text)
    departments = []
    for department in data:
        if department['DepartmentName'].startswith('AS'):
            departments.append(department['DepartmentName'])
    return departments

whiting_departments = get_whiting_departments()
krieger_departments = get_krieger_departments()

krieger_departments.remove("AS Dean's Teaching Fellowship Courses")

#print(whiting_departments[0])

#print(whiting_departments[3])

def get_semester_classes(school, department, semester):
    url = f'https://sis.jhu.edu/api/classes/{school}/{department}/{semester}?key={api_key}'
    response = requests.get(url)
    response.raise_for_status()
    data = json.loads(response.text)
    classes = {}
    for course in data:
        classes[course['OfferingName']] = {'Title': course['Title'], 'Credits': course['Credits'], 'Areas': course['Areas']}
    return classes

for department in whiting_departments:
    for semester in semesters:
        courses = get_semester_classes(whiting, department, semester)
        all_courses = {**courses, **all_courses}

for department in krieger_departments:
    for semester in semesters:
        courses = get_semester_classes(krieger, department, semester)
        all_courses = {**courses, **all_courses}

#pprint(all_courses)