from pathlib import Path
from minor_requirements import *

def degree_calculations(user_courses):
    # Parse file to get list of courses student has taken
    '''
    course_file_name = input("Enter course file name: ")
    course_file_path = Path(course_file_name)
    course_file = open(course_file_path)
    user_courses = course_file.readlines()
    user_courses = [course.strip() for course in user_courses]
    '''

    # List of tuples, where first item is the department, second item is courses needed
    minors = []
    minors.append(('Computer Science', check_cs_minor(user_courses)))
    minors.append(('Africana Studies', check_as_minor(user_courses)))
    minors.append(('Anthropolgy', check_anthro_minor(user_courses)))
    minors.append(('Physics', check_physics_minor(user_courses)))
    minors.append(('Computer Integrated Surgery', check_cis_minor(user_courses)))
    minors.append(('Psychology', check_psych_minor(user_courses)))
    minors.append(('Classics', check_classics_minor(user_courses)))
    minors.append(('Economics', check_econ_minor(user_courses)))
    minors.append(('Mathematics', check_math_minor(user_courses)))

    # Sort list of possible minors by number of courses needed
    minors = sorted(minors, key=lambda tup : len(tup[1]))

    degree_suggestions = ''

    for i in range(3):
        degree_suggestions += f'You are {len(minors[i][1])} course(s) away from a {minors[i][0]} minor!\n'
        degree_suggestions += ', '.join(minors[i][1])
        degree_suggestions += '\n\n'

    return degree_suggestions