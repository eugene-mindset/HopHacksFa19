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

def check_cis_minor(student_courses):
    courses_left = []
    if 'EN.500.112' not in student_courses and 'EN.601.107' not in student_courses:
        courses_left.append('EN.500.112 - Gateway Computing: Java')
    if 'EN.601.226' not in student_courses:
        courses_left.append('EN.601.226 - Data Structures')
    if 'AS.110.106' not in student_courses and 'AS.110.108' not in student_courses:
        courses_left.append('AS.110.106 - Calculus I (Biology and Social Sciences) OR AS.110.108 - Calculus I')
    if 'AS.110.107' not in student_courses and 'AS.110.109' not in student_courses:
        courses_left.append('AS.110.107 - Calculus II (For Biological and Social Science) OR AS.110.109 - Calculus II (For Physical Sciences and Engineering)')
    if 'AS.110.202' not in student_courses and 'AS.110.211' not in student_courses:
        courses_left.append('AS.110.202 - Calculus III OR AS.110.211 - Honors Multivariable Calculus')
    if 'EN.553.291' not in student_courses and 'AS.110.201' not in student_courses and 'AS.110.212' not in student_courses:
        courses_left.append('AS.110.201 - Linear Algebra OR EN.553.291 - Linear Algebra and Differential Equations OR AS.110.212 - Honors Linear Algebra')
    if 'EN.601.455' not in student_courses:
        courses_left.append('EN.601.455 - Computer Integrated Surgery I')
    if 'EN.601.456' not in student_courses:
        courses_left.append('EN.601.456 - Computer Integrated Surgery II')
    
    imaging_group = ['EN.520.414', 'EN.520.432', 'EN.580.472', 'EN.520.433', 'EN.601.461']
    robotics_group = ['EN.530.420', 'EN.530.421', 'EN.530.603', 'EN.530.646', 'EN.601.463']
    other_group = ['EN.520.448', 'EN.520.425', 'EN.530.445', 'EN.580.471', 'EN.601.476', 'EN.601.482', 'EN.601.454']

    cis_courses_left = 4
    imaging_courses = len(list(set(student_courses).intersection(imaging_group)))
    if imaging_courses < 1:
        courses_left.append('CIS Imaging course')
        cis_courses_left -= 1
    cis_courses_left -= imaging_courses
    robotics_courses = len(list(set(student_courses).intersection(robotics_group)))
    if robotics_courses < 1:
        courses_left.append('CIS Robotics course')
        cis_courses_left -= 1
    cis_courses_left -= robotics_courses
    other_courses = len(list(set(student_courses).intersection(other_group)))
    for i in range(cis_courses_left - other_courses):
        courses_left.append(('CIS Imaging course', 'CIS Robotics course', 'CIS Other course'))

    return courses_left

def check_classics_minor(student_courses):
    courses_left = []
    classics = [course for course in student_courses if course.startswith('AS.040.')]
    if len(classics) < 6:
        for i in range(6 - len(classics)):
            courses_left.append('Classics Department course')

    return courses_left

def check_cs_minor(student_courses):
    courses_left = []
    if 'EN.500.112' not in student_courses and 'EN.601.107' not in student_courses:
        courses_left.append('EN.500.112 - Gateway Computing: Java')
    if 'EN.601.220' not in student_courses:
        courses_left.append('EN.601.220 - Intermediate Programming')
    if 'EN.601.226' not in student_courses:
        courses_left.append('EN.601.226 - Data Structures')
    if 'EN.601.229' not in student_courses and 'EN.601.231' not in student_courses:
        courses_left.append('EN.601.229 - Computer Systems Fundamentals OR EN.601.231 - Automata and Computation Theory')
    cs_uppers = [course for course in student_courses if course.startswith('EN.601.3') or course.startswith('EN.601.4')]
    if len(cs_uppers) < 3:
        for i in range(3 - len(cs_uppers)):
            courses_left.append('CS course at the 300 level or above')

    return courses_left

def check_econ_minor(student_courses):
    courses_left = []
    
    if 'AS.180.101'  not in student_courses :
        courses_left.append('AS.180.101 - Elements of Macroeconomics')
    if 'AS.180.102' not in student_courses:
        courses_left.append('AS.180.102 - Elements of Microeconomics')

    econ_uppers = [course for course in student_courses if course.startswith('AS.180.2') or course.startswith('AS.180.3')]
    if len(econ_uppers) < 3:
        for i in range(3 - len(econ_uppers)):
            courses_left.append('Economics course at 200 level or above (not including 180.203')

    return courses_left

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

def check_psych_minor(student_courses):
    courses_left = []
    missing_class = ['AS.200.101', 'AS.200.110', 'AS.200.132', 'AS.200.133', 'AS.200.141']

    if 'AS.200.101' in student_courses:
        missing_class.remove('AS.200.101')
    if 'AS.200.110' in student_courses:
        missing_class.remove('AS.200.110')
    if 'AS.200.132' in student_courses:
        missing_class.remove('AS.200.132')
    if 'AS.200.133' in student_courses:
        missing_class.remove('AS.200.133')
    if 'AS.200.141' in student_courses:
        missing_class.remove('AS.200.141')

    string = ''

    if (len(missing_class) > 2):
        for i in range(len(missing_class)):

            if 'AS.200.101' in missing_class:
                string += 'AS.200.101 - Introduction to Psychology'
            if 'AS.200.110' in missing_class:
                if string:
                    string += ' OR '
                string += 'AS.200.110 - Introduction to Cognitive Psychology'
            if 'AS.200.132' in missing_class:
                if string:
                    string += ' OR '
                string += 'AS.200.132 - Introduction to Developmental Psychology'
            if 'AS.200.133' in missing_class:
                if string:
                    string += ' OR '
                string += 'AS.200.133 - Introduction to Social Psychology'
            if 'AS.200.141' in missing_class:
                if string:
                    string += ' OR '
                string += 'AS.200.141 - Foundations of Brain, Behavior and Cognition'
            courses_left.append(string)
            string = ''


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

def check_as_minor(student_courses):
    courses_left = []
    missing_class = ['AS.362.112', 'AS.100.122', 'AS.100.123']

    if 'AS.362.112' in student_courses:
        missing_class.remove('AS.362.112')
    if 'AS.100.122' in student_courses:
        missing_class.remove('AS.100.122')
    if 'AS.100.123' in student_courses:
        missing_class.remove('AS.100.123')

    string = ''

    if (len(missing_class) > 1):
        for i in range(len(missing_class)):

            if 'AS.362.112' in missing_class:
                string += 'AS.362.112 - Introduction to Africana Studies'
            if 'AS.100.122' in missing_class:
                if string:
                    string += ' OR '
                string += 'AS.100.122 - Introduction to History of Africa (since 1880)'
            if 'AS.100.123' in missing_class:
                if string:
                    string += ' OR '
                string += 'Introduction to African History: Diversity, Mobility, Innovation'
            courses_left.append(string)
            string = ''

    as_uppers = [course for course in student_courses if course.startswith('AS.362.3')
        or course.startswith('AS.362.4') or course.startswith('AS.362.5') or course.startswith('AS.362.6')]
    if len(as_uppers) < 3:
        for i in range(3 - len(as_uppers)):
            courses_left.append('Africana Studies course at the 300 level or above')

    as_others = [course for course in student_courses if (course.startswith('AS.362.') and not course.startswith('AS.362.112'))]
    if len(as_others) < 1:
        courses_left.append('Africana Studies course at any level')

    return courses_left

def check_math_minor(student_courses):
    courses_left = []

    if 'AS.110.106' not in student_courses and 'AS.110.108' not in student_courses:
        courses_left.append('AS.110.106 - Calculus I (Biology and Social Sciences) OR AS.110.108 - Calculus I')
    if 'AS.110.107' not in student_courses and 'AS.110.109' not in student_courses:
        courses_left.append('AS.110.107 - Calculus II (For Biological and Social Science) OR AS.110.109 - Calculus II (For Physical Sciences and Engineering)')
    if 'AS.110.202' not in student_courses and 'AS.110.211' not in student_courses:
        courses_left.append('AS.110.202 - Calculus III OR AS.110.211 - Honors Multivariable Calculus')

    math_uppers = [course for course in student_courses if course.startswith('AS.110.3') or course.startswith('AS.110.4')]
    for i in range (3 - len(math_uppers)):
        courses_left.append('300 level or above math course')

    if len(math_uppers) < 4:
        math_200 = [course for course in student_courses if course.startswith('AS.110.2')]
        if 'AS.110.202' in math_200:
            math_200.remove('AS.110.202')
        if not math_200:
            courses_left.append('200 level or above math course')

    return courses_left