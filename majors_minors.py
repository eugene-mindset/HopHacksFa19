from pathlib import Path
from csminor import check_cs_minor
from africanaminor import check_as_minor
from anthrominor import check_anthro_minor
from physicsminor import check_physics_minor
from cisminor import check_cis_minor
from psychminor import check_psych_minor
from get_courses import generate_courses_file

def print_required_courses(courses_left):
    pass

# Update json file with all courses if there have been some changes
option = input("Update courses listings? (Y/N): ")
if option == 'Y':
    generate_courses_file()

# Parse file to get list of courses student has taken
course_file_name = input("Enter course file name: ")
course_file_path = Path(course_file_name)
course_file = open(course_file_path)
user_courses = course_file.readlines()
user_courses = [course.strip() for course in user_courses]

# List of tuples, where first item is the department, second item is courses needed
minors = []
minors.append(('Computer Science', check_cs_minor(user_courses)))
minors.append(('Africana Studies', check_as_minor(user_courses)))
minors.append(('Anthropolgy', check_anthro_minor(user_courses)))
minors.append(('Physics', check_physics_minor(user_courses)))
minors.append(('Computer Integrated Surgery', check_cis_minor(user_courses)))
minors.append(('Psychology', check_psych_minor(user_courses)))

# Sort list of possible minors by number of courses needed
minors = sorted(minors, key=lambda tup : len(tup[1]))

for i in range(3):
    print(f'You are {len(minors[i][1])} course(s) away from a {minors[i][0]} minor!')

'''
cs_minor_courses_left = check_cs_minor(user_courses)
as_minor_courses_left = check_as_minor(user_courses)
anthro_minor_courses_left = check_anthro_minor(user_courses)
physics_minor_courses_left = check_physics_minor(user_courses)
cis_minor_courses_left = check_cis_minor(user_courses)
psych_minor_courses_left = check_psych_minor(user_courses)

print(cs_minor_courses_left)
print(as_minor_courses_left)
print(anthro_minor_courses_left)
print(physics_minor_courses_left)
print(cis_minor_courses_left)
print(psych_minor_courses_left)
'''