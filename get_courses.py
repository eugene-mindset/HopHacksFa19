import json
import requests
from pprint import pprint
from auth import api_key

'''
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
'''

'''
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
'''

def get_school_departments(school):
    url = f'https://sis.jhu.edu/api/classes/codes/departments/{school}?key={api_key}'
    response = requests.get(url)
    response.raise_for_status()
    data = json.loads(response.text)
    departments = []
    for department in data:
        departments.append(department['DepartmentName'])
    return departments

def get_semester_classes(school, department, semester):
    url = f'https://sis.jhu.edu/api/classes/{school}/{department}/{semester}?key={api_key}'
    response = requests.get(url)
    response.raise_for_status()
    data = json.loads(response.text)
    classes = {}
    for course in data:
        classes[course['OfferingName']] = {'Title': course['Title'], 'Credits': course['Credits'], 'Areas': course['Areas']}
    return classes

def generate_courses_file():
    whiting = 'Whiting School of Engineering'
    krieger = 'Krieger School of Arts and Sciences'
    #semesters = ['Fall 2019', 'Spring 2019', 'Fall 2018', 'Spring 2018', 'Fall 2017', 'Spring 2017', 'Fall 2016']
    semesters = ['Fall 2019', 'Spring 2019', 'Fall 2018', 'Spring 2018', 'Fall 2017']
    all_courses = {}

    #whiting_departments = get_whiting_departments()
    whiting_departments = get_school_departments(whiting)
    #krieger_departments = get_krieger_departments()
    krieger_departments = get_school_departments(krieger)

    # Apostrophe in name messes up API calls, no one is even in this department anyway
    krieger_departments.remove("AS Dean's Teaching Fellowship Courses")
    whiting_departments.remove("AS Dean's Teaching Fellowship Courses")

    for department in whiting_departments:
        for semester in semesters:
            courses = get_semester_classes(whiting, department, semester)
            all_courses = {**courses, **all_courses}

    for department in krieger_departments:
        for semester in semesters:
            courses = get_semester_classes(krieger, department, semester)
            all_courses = {**courses, **all_courses}

    #pprint(all_courses)

    with open('all_courses.json', 'w') as fp:
        json.dump(all_courses, fp)

def main():
    generate_courses_file()

if __name__ == "__main__":
    main()